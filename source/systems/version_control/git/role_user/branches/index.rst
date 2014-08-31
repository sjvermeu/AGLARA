********
Branches
********

Branches in Git allow for parallel development, merging changes and developing
without affecting master code.

Concept
=======

Please see `Git Branching
<http://git-scm.com/book/en/Git-Branching-Basic-Branching-and-Merging>`_.

Tasks
=====

How to create a branch that is also trackable by remotes?
---------------------------------------------------------

In order to create a branch locally and then push it to the ``origin`` remote::

  ~$ git checkout -b testing
  ~$ git push -u origin testing

This will create a remote branch called ``origin/testing``.

How do I set or switch the remote that a branch uses?
-----------------------------------------------------

Use the ``--set-upstream-to`` parameter like so::

  ~$ git branch --set-upstream-to remotes/foobar/mybranch thisbranch


How to delete a branch and also its remote?
-------------------------------------------

In order to delete a local branch, and remove it from the ``origin`` remote::

  ~$ git branch -D testing
  ~$ git push origin :testing

The important bit is the ``:``, telling that the given remote should be removed.

Next, remove all tracking branches that are deleted from the remote repositories::

  ~$ git remote prune origin


How do I reset my local branch to the state of the remote branch?
-----------------------------------------------------------------

Fetch the (latest) metadata for the branch, and then perform a hard reset.

For instance, assuming the remote is called ``someremote/foo``::

  ~$ git fetch someremote/foo
  ~$ git reset --hard someremote/foo

How do I reset the remote branch to the state of the local branch?
------------------------------------------------------------------

If you have made (through rebasing, resetting based on other branches, etc.)
significant changes that can't be fast-forwarded, then you can force-push the
changes remotely to set the remote branch on it.

Be aware though that this should only be done when all developers working on
that remote branch are aware of a force-push::

  ~$ git push -f

Or, if you want to push to a different remote than the one that is tracked by
the current branch::

  ~$ git push -f <remote> <branch>

How do I list which (local) branches are tracking remotes?
----------------------------------------------------------

Use ``git branch`` with high verbosity::

  ~$ git branch -a -vv
    master               efbcdcd [origin/master] Do something
  * foo-bar              8f7e80c [someremote/foo] Adding interface to something
    testing              7bf3f6b [origin/testing] Fix merge conflict
    localonly            3fbcdfb Workaround for bug #422343

When a branch is tracking a remote, that remote is listed between ``[`` and ``]``.
