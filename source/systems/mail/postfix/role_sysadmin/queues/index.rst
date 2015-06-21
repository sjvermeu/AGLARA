******
Queues
******

Queues contain the e-mail when it is not finally delivered yet.

Interesting resources:

- `Managing the Postfix Queue <http://www.tullyrankin.com/managing-the-postfix-queue>`_.

Tasks
=====

How to force e-mails in a hold queue?
-------------------------------------

In ``main.cf`` add the following statement::

  smtpd_recipient_restrictions = check_recipient_access hash:/etc/postfix/hold

In the ``/etc/postfix/hold`` file, add the domain(s) for which e-mails should
be put in the hold queue, like so::

  genfic.local  HOLD

(Re)generate the database and reload the postfix configuration::

  ~# postmap hash:/etc/postfix/hold
  ~# postfix reload

