:orphan:

Abstract
--------

This online resource called "A Gentoo Linux Advanced Reference Architecture" is
meant as a resource displaying the powerful features of many free software
solutions that are supported on top of Gentoo Linux. It is a deep-dive approach
in many aspects related to processes, supportability, maintainability based on
Gentoo Linux system deployments.

Unlike the existing, per-application documents that exist on the Internet (and
which are a valuable resource to get into the gory details of many applications)
and the per-distribution guides that provide information on using that particular
distribution, this book will focus more on architecturing IT infrastructure for
medium-sized enterprises. Smaller enterprises might find the reference architecture
here too expensive or large - however, many services described in the book can be
slimmed down into a smaller deployment as well.

It is seriously recommended to have a good grasp of what Gentoo Linux is to start
with. The other online resource ("Linux Sea") can be a good introduction to Gentoo
Linux, but that might not be sufficient to appreciate the detail and organization
of this book.

This resource will progress rather slowly (compared to the initial development of
"Linux Sea" as its content will be written down as I teach myself the technologies
mentioned within. When the development of this book started, knowledge about the
technical services described later is still limited, and the book will be used as
a sort-of progress report by the author. Call it offsite knowledge storage ;-) 

The version you are currently reading is 1 and has been generated on 2014/08/08.

How is the document structured
------------------------------

All documentation inside AGLARA is documented in layers, making it easy to find
and position specific information.

The first level is the *class* of the documentation. There are currently four
classes identified:

1. In the *enterprise* class, generic, functional requirements are gathered. It
   provides a high-level overview of the necessary services within a (fictional)
   compnay.
2. In the *solutions* class, specific technologies are mapped to these services.
   A solution is usually tied with a service agreement (SLA or other) and as such
   should be seen as a completely operational set of technologies acting together.
3. In the *systems* class, individual technologies are documented. These are the
   technologies that are used in the solutions.
4. Finally, the *components* class provides documentation about smaller aspects
   of a technology.

A fifth class, *assets*, will not be documented right now.

Within each class, a subhierarchy will be provided that is tied to that class
itself. Once a topic is encountered, a topic will have documentation specific
to a certain audience. The general audiences that we aim for are architects,
administrators, engineers, users and developers.

If necessary, different audience subtypes will be used.
