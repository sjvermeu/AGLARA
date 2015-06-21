:orphan:

How is the document structured
------------------------------

All documentation inside AGLARA is documented in layers, making it easy to find
and position specific information.

The first level is the *class* of the documentation. There are currently four
classes identified:

1. In the *enterprise* class, generic, functional requirements are gathered. It
   provides a high-level overview of the necessary services within a (fictional)
   company.
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
