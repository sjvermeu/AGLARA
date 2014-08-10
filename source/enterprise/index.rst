###############
Enterprise view
###############

The *Enterprise Architecture* we focus on is shown in the following diagram:

.. image:: enterprise_architecture.png

The larger an environment is, the more complex it might seem to position
services left or right. A new workstation needs to be put inside a network
segment (which one?), possibly assigned to a central LDAP server and structure
(which tree in the LDAP?). Servers could be for one customer or another. Having
a high-level structure for positioning components provides a quick way of
dealing with more general requirements: allowed data flows, location of the
central user repository and more. But most importantly, it provides a structure
in which security measurements can be positioned.

Structuring the Environment
===========================

Multi-tenancy
-------------

In a multi-tenant organization, several larger customers (be it internal or not)
are identified. Each of these customers probably has very different requirements
and might take risks in their architecture that other tenants won't. For this
reason alone, differentiation between tenants is at the highest level (the most
segregated level).

.. image:: multitenant.png

The most important part here is that anything used within a tenant that might be
shared across tenants (such as user ids for administration) is pushed to the
tenant, never used directly from the tenant hub. This provides a clean, modular
approach to handling tenants. When a tenant wants to leave the organization, the
data flow is stopped and the tenant can continue with its internal architecture
(with little to no immediate adaptations). When a new tenant enters the
organization, data is pushed and converted towards that tenants' internal
services.

Communication between the tenants directly should be done through the external
gateways as it is seen as B2B (Business to Business) communication.

SLA Groups
----------

Larger environments will have different SLA groups. Those could be called
"production", "preproduction", "testing" and "sandbox" for instance. Smaller
organizations might have just two, or even one SLA group.

.. image:: sla-groups.png

The segregation between the SLA groups not only makes proper service level
agreements possible on the various services, but also controls communication
flows between these SLA groups.

For instance, communication of data between production and pre-production might
be possible, but has to be governed through the proper gateways or control
points. In the above figure, the SLA groups are layered so direct communication
between production and sandbox should not be possible unless through the three
gateway levels. However, that is definitely not a mandatory setup.

To properly design such SLA groups, make sure communication flows in either
direction (which not only includes synchronous communication, but also file
transfers and such) are properly documented and checked.

Architectural positioning
-------------------------

The next differentiator is the architectural positioning. This gives a
high-level overview of the various IT services provided by an organization.

.. image:: architectural-positioning.png

At this level, specific data flows are already denied (for instance, direct
access from DMZ to the processing block). Communication between blocks will
still be managed through the next level, which is the categorization.

.. note:: Certain flows will also depend on the SLA group. For instance, it
   might be possible that internet access (towards DMZ) will only be allowed for
   sandbox and production. And that communication to/from mid tier blocks are
   only allowed within the same SLA group.

Categories
----------

Finally, categories allow for proper flow and communication management between
individual blocks. Let's consider end user device communication:

.. image:: categories.png

Blocks are not mutually exclusive. For instance, an employees workstation can be
both in the network administration and infrastructure administration block if it
is multi-homed.

Categories are often made based on the users accessing a system. For instance,
for mid tier application servers, we could have categories for Internet
disclosed applications, internal applications, authenticated customer
applications, business-to-business (B2B) applications, etc. Segregation between
those categories helps reduce the risk involved with a potential breach.

Once categories on all architecture blocks are known, then a good IP map, with
firewall rules and segmentation can be defined.

Contents
========

.. toctree::
   :maxdepth: 2

   basic_infrastructure/index.rst
   management_control_services/index.rst
   supporting_infrastructure/index.rst


