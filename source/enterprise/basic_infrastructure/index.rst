====================
Basic infrastructure
====================

In the basic infrastructure service, three subservices are defined:

#. *Storage* focuses on raw data handling services. Things such as the Storage
   Area Network (SAN), Network Attached Storage (NAS), File system support,
   backup and restore services and more
#. *Compute* looks at the hardware that provides services. This includes
   desktop, laptops, servers, appliances.
#. *Network* governs communication related basic services, such as standard
   networking support, wireless support, IP telephony, etc.

Massively redeployable components
=================================

In any large environment, these basic infrastructure services will provide
building blocks that are reused many times. Companies with thousands of
employees generally use standardized infrastructure to keep things manageable.
Indeed, when doing cost analysis, one of the factors that analysis firms often
look into is the *server to system administrator* ratio.

In highly standardized infrastructures, this ratio can get as high as 150:1,
meaning that a single system administrator can be managing one hundred and fifty
servers. But do not be ashamed if this number is significantly lower - it all
depends on what the number takes into account. Are DBAs also system
administrators? If not, what if they do hold system administrative rights
(root permissions)?

Always check with the analyst what the figures are. Especially if there are
consequences tied to it.

Subpages
========

.. toctree::
   :maxdepth: 2

   storage/index.rst
   compute/index.rst
   network/index.rst

