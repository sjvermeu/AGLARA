Git
===

Git is an advanced version control system, popular in the free software world.
It works decentralized, meaning that there is no need for a central server
infrastructure.

In order to support collaboration between multiple developers, developers can
define a point (server) where they will push and fetch changes to and from.
These locations contain the same information as the local repositories
of the developers: if at any point in time the server crashes or is down,
developers can easily point to a new location, push changes and continue
working. Because these locations have no bearing on the operational continuity
of the developer, and because multiple remote locations can be defined if
wanted, such an architecture is often called a *decentralized* architecture.

The git infrastructure supports multiple protocols to push and pull from these
decentralized locations. This includes the SSH protocol and HTTP/HTTPS.

Contents
--------

.. toctree::
   :maxdepth: 2

   role_user/index.rst
