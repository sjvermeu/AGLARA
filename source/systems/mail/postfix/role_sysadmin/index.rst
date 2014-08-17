=================================
Postfix for System Administrators
=================================

This document is intended for *system administrators* (or more precisely,
*operating system administrators*) who have to deal with Postfix deployments.
The document will not talk about Postfix administration itself, but merely about
how Postfix works on a system and how it interacts with the outside world.

Postfix as a Mail Transfer Agent
================================

The Postfix application is what is called a *Mail Transfer Agent*, or MTA. It is
responsible for receiving and sending e-mails and, depending on the
configuration, pass the mails through other applications (such as for filtering
purposes) or delivering it to a final destination (such as an IMAP server or to
local mail boxes).

Postfix deployments generally have one of the following functions:

Mail sender
  Responsible for sending out mails generated on the system (for instance by
  system daemons) towards a relay server. Senders can be configured with or
  without local queueing.

Relay host
  The relay host receives e-mails from various mail senders across the
  organization and acts as a sort-of "mail router". The relay host decides where
  to send e-mails to further and if they need to be filtered first or not

Mail handler
  The handler receives incoming e-mails meant for local processes or users. They
  can be seen as a destination for mails.

Processes
=========

Locations
=========
