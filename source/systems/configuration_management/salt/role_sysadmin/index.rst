==============================
Salt for System Administrators
==============================

This document is intended for *system administrators* who have to deal with Salt
deployments. It will not talk about Salt configuration (which is more for Salt
administrators) or developing Salt state files (which is for Salt developers),
instead focusing on Salt as an application on the operating system.

Salt for configuration management
=================================

Salt (also often referred to as *saltstack*) is a configuration management
system which boasts simplicity and scalability. It is developed (and runs) on
Python and supports both state configuration as well as ad-hoc configuration
directives:

* developers "write down" the state they need for a system, and Salt enforces
  it on the systems, or
* administrators call the **salt** and **salt-call** commands to perform ad-hoc
  configuration settings

The Salt architecture is quite simple:

salt-master
  The salt master runs on one system (although in case of high availability
  multiple salt masters can be configured) and manages the configuration
  settings for the environment

salt-minion
  The salt minion runs on all managed targets; the minions communicate with the
  salt master to receive configuration updates, as well as receive commands to
  perform

Salt processes
==============

Salt minion
-----------

The **salt-minion** process is a Python script which is daemonized and is
connected with the salt master::

  ~$ pidof -x salt-minion
  2069
  ~$ netstat -napt | grep 2069
  tcp  0  0  192.168.100.152:41184  192.168.100.152:4505  ESTABLISHED 2069/python2.7

The process usually runs as the ``root`` user to allow Salt to configure the
system. When SELinux is enabled (on Gentoo) then it runs in the (privileged)
``salt_minion_t`` domain.

The minion is started and managed through its init script,
``/etc/init.d/salt-minion``. It can also be started directly, through
**salt-minion -d** (which daemonizes and runs in the background) or
**salt-minion -l debug** (which keeps the application in the foreground, helping
debugging of Salt issues when needed).

Invoking Salt
=============

Salt can be invoked from both the Salt master (using the **salt** command) or
locally, using the **salt-call** command.

* When using the **salt** command, the first argument is the set of systems that
  the command needs to be sent to. A ``'*'`` means that all Salt minions that are
  listening to the Salt master have to act. Salt has a query syntax which can be
  used to limit commands to particular systems.

* The **salt-call** command only runs locally, so no system identificiation is
  needed.

Pinging target systems
----------------------

The ``test.ping`` method allows for Salt to check if a target is operational.

For instance, to check the entire fleet of systems::

  ~# salt '*' test.ping

To check if Salt is running locally and responsive::

  ~# salt-call test.ping

Running commands
----------------

With the ``cmd.run`` method Salt can run commands remotely::

  ~# salt '*' cmd.run 'emerge -uDNkvt @world'

