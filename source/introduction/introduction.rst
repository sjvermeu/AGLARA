***********************
Architecture frameworks
***********************

Many IT infrastructure architecture frameworks exist. When you are working for a
large enterprise, these frameworks will most likely be translated into the
companies internal architecture framework. Small and medium-sized enterprises
usually do not invest that much in managing their own infrastructure
architecture framework and instead work with online published and managed
frameworks as good (or as bad) as they can.

A well-known framework is `CObIT <https://www.isaca.org/Pages/default.aspx>`_,
which is an acronym for Control Objectives for
IT. CObIT dives into the requirements and deliverables of an IT organization,
based on the business requirements of the organization and the processes
involved in managing IT infrastructure. When reading through CObIT, it might
seem very difficult to implement, but that's ok. Most of the time, organizations
gradually grow into the objectives. Trying to implement the objectives
immediately will not work. But having a good read through the framework allows
you to investigate and prepare a good "path" towards a more process-like, mature
IT organization. Still, most organizations that want to have a high degree of
CObIT implementation will be large. Medium-sized organizations might want to
keep CObIT as a valuable resource to see how they can mature, without going into
the full deployment of CObIT in the organization.

When processes come around the corner, `ITIL
<http://www.itil-officialsite.com/home/home.aspx>`_ is most likely the resource for
process maturity. It talks about how IT services should be organized and which
services you need to take care of in order to provide mature and qualitative
services towards your (internal) business. The practices talk about financial
management (contracts, licenses, chargeback, ...), service level management
(allowed changes, production and non-production environments, handling incidents
and questions, ...), security management (including central authentication and
authorization, auditing services, ...), configuration management and more.
Knowing what ITIL wants to achieve and which services it defines is very
important to grow towards a larger enterprise, because those services need to be
consider and deployed. However, unlike CObIT, which is fairly technical driven,
ITIL stays on a higher abstraction level.

Security management is too often seen as a mandatory component that removes
flexibility from the organization. This is not true. When properly done,
security means to have a high degree of manageability across the organization.
Security is more than just authentication and authorization, it strives on
automation (which improves the time-to-market and reduces possible human
errors), standardization (which lowers total cost of ownership), advanced log
management (including accountability, but also very important for quality
assurance and incident handling) and more. The `ISO/IEC 27000 <https://en.wikipedia.org/wiki/ISO/IEC_27000-series>`_ 
standard focuses on
the high-level scope of information security management and introduces the
starting point for many other security-related standards.

Another interesting resource is `TOGAF <http://www.togaf.info/>`_, The
Open Group Architecture Framework.
TOGAF focuses more on service design and how information flows and is managed
through those services. It also helps to design the process of architecturing
itself, providing valuable information about architecture lifecycle, planning,
and more.

Yet all this is often still quite too high-level or abstract to work with. If
so, then please read on, because that is what this book will (also) help with!

Reference architecture for infrastructure
=========================================

To make the various processes and methods described in the architecture
frameworks more tangible, a reference architecture can be documented.

A reference architecture shows how to potentially design infrastructure, working
with known software services (like Apache for web services, OpenLDAP for
directory services, etc.) and management components (like Puppet for
configuration management). This is more in line with what many readers expect
and know, because those are the technologies known and are often deployed
already. Many vendors that have a huge portfolio of software and server services
have their reference architectures as well, which is often used by
administrators as a first resource reference to their own infrastructure.

Microsoft has the `Infrastructure Planning and Design series
<http://technet.microsoft.com/en-us/library/cc196387.aspx>`_ in which it
describes implementations of its various services, such as Active Directory (for
the central management of it all), DirectAccess (for simplified yet secure
VPN-like implementations, SQL Server for databases, etc.)

Oracle uses its `IT Strategies <http://www.oracle.com/goto/itstrategies>`_
series to describe its Oracle Reference Architecture, a suggestion on how to
deal with the various Oracle products and integrate them in the organization.

RedHat uses a different approach, describing `reference architectures
<https://www.redhat.com/resourcelibrary/reference-architectures/>`_ for specific
products within the RedHat Enterprise Linux distribution.

By describing such a reference architecture, administrators can understand why
various processes exist and how they can make life easier for engineers and
administrators as well as provide valuable for the organization as a whole. For
many IT service delivery companies, their suggested reference architecture is
both a sales pitch (to describe the maturity and integration of their services)
as well as a check point for their own development departments (is our offering
sufficient and necessary).

Throughout the rest of this book, a reference architecture will be designed,
with primary focus on the components used, the reason for these components and
possible process implementations that are related to it.

Designing a reference architecture
==================================

The process
-----------

The focus of designing a reference architecture is to be able to display quickly
how all needed services are deployed, integrated and managed. In very high
terms, it boils down to the following steps.

1. Capture the requirements
2. Make a logical design
3. Translate the design in infrastructure implementation details
4. Go do it

These steps are simply put the order of doing things; the hardest part though
lays in the beginning.

Capturing the requirements
^^^^^^^^^^^^^^^^^^^^^^^^^^

Generally speaking, there are two types of requirements:

1. Functional requirements, describing the features, functions, security,
capabilities and more of the organizations' needs

2. Non-functional requirements, which are more about the service level
agreements (performance, availability, reliability, ...), support requirements

Functional requirements can be thought of in terms like:

* What does the organization want to get?
* Which security requirements are there (most often based on legal or
  compliance requirements)
* Which financial requirements are being presented

The non-functional requirements can be thought of through the FURPS(+) acronym.
The F is covered already (which stands for Functional), but the other letters in
the acronym give a nice overview of non-functional requirements that might
exist: Usability, Reliability, Performance, Supportability. The + in the acronym
focuses on additional process-driven requirements, such as design requirements
("you need to use a relational database"), implementation requirement ("you need
to code it in Python"), interface requirement ("you need to use SOAP for
communication across services"), physical requirements ("the service must run in
a colocation center") or progress requirement ("you must use a lean-IT approach
with visual progress boards").

Capturing requirements from the organization is one of the most tough (but most
important) tasks in any design exercise. Properly evaluating and documenting the
requirements, as well as their priority (for which you can use the `MoSCoW
<http://www.coleyconsulting.co.uk/moscow.htm>`_ approach -
Must/Should/Could/Won't - which was originally made for software development but
can be used in other requirement exercises as well) and who asked for it
(stakeholders). Although you can go extremely far in this (asking hundreds of
questions), be sure to take a pragmatic approach and inform the stakeholders
about possible consequences too (like the cost and time-to-market influence of
additional requirements). Using an iterative production approach (where a first
set of requirements is captured, a design is made after which some sort of
storyboard approach is used to describe to the organization how the design looks
like) will give the organization time to react or give their ideas (or
additional requirements).

Make a logical design
^^^^^^^^^^^^^^^^^^^^^

A logical design visualizes and describes a solution without going into the
details of the implementation. The idea of logical designs is that they can be
modularized them, designing one component after another, and using building
blocks to give a high-level overview of the solution you are designing. This
high-level design allows tracking of the architecture whereas the components
logical design documents go into the details of a single building block.

When a logical design is made, try to keep the implementation details out of it.
Details such as IP addresses, number of parallel instances, memory details, ...
are not needed in order to track and manage the architecture. These
implementation details go into the later stage.

Infrastructure implementation details
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The implementation details are then used as a sort-of handover process between
designing the architecture and implementing it. Whereas the logical design can
be reused in other projects or sometimes even other organizations, the
implementation details are more about how it all works in a specific
infrastructure deployment. Overview of instances, IP addresses, functional
accounts in use, location of files and certificates, etc. are all implementation
details that are important to manage properly (and will often be managed through
a configuration management database) but not that vital in understanding the
architecture by itself.

Go do it
^^^^^^^^

Only when these implementation details are known as well can the infrastructure
be really created.

Logical design
--------------

Whereas requirements capturing is the most important, the logical design is
where architects start writing and documenting how the architecture looks like,
translating the requirements in services (or even immediately into
technologies). In this book a lightweight logical design method will be used to
describe why decisions are made in the reference architecture. There will not be
full logical design documents (that would be a bit overkill for now, especially
since it is just a fictional company) but the methods and structures used can
help in the quest to find out what a larger organization might want.

A lightweight logical design document starts off with (a subset of) requirements
that is used during the design and which influences the decisions made.
Alongside the requirements a design might also include assumptions, although it
is recommended to remove assumptions before it is too late - after all, every
assumption that isn't validated is a risk for a design.

Next, the logical design itself is made, for which the FAMOUS abbreviation is
introduced:

* Feeds and flows that are important for the design

  This information provides insight in the occasional data transports that occur towards the system. This might be the shipping of the database backup file towards a remote location, the flow of log entries that are sent to a central log server, an incoming daily snapshot of configuration settings that need to be loaded in an LDAP, etc. By properly documenting these feeds and flows, it is much easier to find possible attention points (storage volume requirements, network traffic shaping needs, heavy I/O timeframes, ...) that need to be tackled.

  In many cases, integration-requirements can also be found from this. A flow of log entries towards a central log server will help in documenting the log structure & communication standard that might be wanted in an organization. An incoming configuration file will need to adhere to a certain format in order to make automation possible.

* Administration of the components

  In many cases, administration is often forgotten to be designed. Yet the administration of components is an important aspect since it is often (flawed) administration that is causing vulnerabilities or exploits. The more administrative accesses that are noticed, the more "attack vectors" exist that might be exploitable. By properly designing the administration of the components, it is much more likely to find a good method that is both secure as well as supported by the administration team.

* Monitoring of the components

  Monitoring is more than having a cronjob checking if a process is still running. A design is needed to see what to verify periodically (and how frequent) as well as the consequences when certain events occur. So next to process monitoring (and perhaps automatically restarting the process), also consider resource monitoring (file system capacity, memory pressure, network I/O) and service monitoring (automatic processes that perform end-to-end tests on services).

* Operational flows (runtime behavior)

  Designing the operational flow is less about the (integration) architecture, but more about understanding what the service is actually doing. Usually, this information can be found on the products' project page (or vendor), but it never hurts to verify this and draw it to understand it.

  An example operational flow could be the high-level working of Apache (with a master process bound to port 80, but that is dispatching work to child processes when a request has entered). These child processes have multiple worker threads that handle requests one-at-a-time. If a request is for a CGI resource, Apache either forks and launches the CGI command, or it uses FastCGI towards a running instance, etc.

  The operational flows also show which actors are involved and how they connect/interact with the service.

* User management

  Many services delegate user management to another service. Be it direct LDAP access, or authentication through SASL or any other method: properly designing and documenting how user management for the service is done helps to figure out potential improvements as well as integration aspects of the service. Don't forget to think about the internal authentication & authorization as well: does the service offer role-based access? Which roles are needed? What are the rights and privileges that these roles should have?

* Security details

  Finally, there is the design of particular security requirements. Based on the earlier design flows, check if these need firewall capabilities (or host filters), encryption (when working with sensitive business data), certain audit requirements that need to be taken care of, gateways that need to be implemented that offer additional filtering or even request rewrites, etc.

After this logical design, write down further details about the design that are
less about the components and more about how they will or could be used. For
this the FASTCARD abbreviation is used:

* Financial information

  If the service has particular licensing restrictions, document how the license works. Is it core-based? User-based? Instance-based? If allowed, document what the cost is of this license as that helps to decide on the usability (and evolution) of the service. Document how to map contracts towards the component.

* Aftermath (future development or evolution)

  The design is most likely either not finished, or is based on the short-term resources available whereas more evolutions are still in sight. For instance, an LDAP can be documented using a master/slave approach, knowing very well that a master/master situation might be in scope later. Document the changes thought to be needed or will be done in the future.

* Selection criteria

  The service probably can serve multiple requests (or types of requests). In many cases, it is best to provide a decision chart or decision table to help administrators and engineers decide if the design fits their needs. For instance, for a web server, the decision table might provide input as to when SSL encryption is needed, when SSL encryption with client certificate validation is needed, etc. For a database, include if (and when) encryption or compression is needed, and so forth.

* Technology lifecycle

  If the project or vendor has described it, document how long this particular version will last. If there is a support contract with a particular vendor, verify if this contract deals with upgrades as well.

* Communication of changes

  Who are the stakeholders that need to be modified when the design changes

* Affiliated standards

  Which standards, policies, guidelines, ... do users, analysts or other roles need to specifically look at when they work with or integrate with this component

* Residual risks

  Issues that cannot be solved by the logical design by itself and thus need to be taken care of during integration or through other means. For instance, if a service does not offer SSL/TLS encryption upon accessing it, a residual risk regarding plain-text network communication should be documented.

* Documentation

  Overview of resources that are interesting to look at

By documenting these two aspects, all information needed about one building block or architecture is readily available. This information should be kept alive during the lifecycle of the components within the architecture. Don't worry if the acronyms are currently too illogical - they will become more clear while looking at the example designs that are described further down the book.


