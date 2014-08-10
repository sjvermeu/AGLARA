************
Gentoo Linux
************

Within the reference architecture, Gentoo Linux is the standard. Standardization
on a single platform allows organizations to keep the cost sufficiently low, but
also offers the advantage that these solutions might be specific for the
platform, rather than having to look for solutions that must support a multitude
of platforms. Of course, the choice of picking Gentoo Linux here might seem
weird - why not CentOS (as that has a possible commercial backing towards RedHat
Enterprise Linux when needed)?

* First of all - the author is a Gentoo Linux developer. Its the distribution he
  know the best.

  But in light of a (fictional) company, it might also be because its current
  (fictional) engineers are all Gentoo Linux developers, or because it has ties
  with regional Gentoo Linux supporting services. In light of many organizations,
  when there is choice between Linux distributions, one thing to consider is which
  distribution the engineers are most likely to work with. Alright, asking them
  will probably result in some heavy fighting to see which distribution is best
  (perhaps the `Condorcet method
  <https://en.wikipedia.org/wiki/Condorcet_method>`_ can be used to find the best selection), but
  picking a distribution the engineers are less eager to support will result in
  bad administration anyhow.

* The reason to use CentOS (RHEL) could be to have certified hosting of certain
  products which are only supported on RHEL (or similar). However, because the
  focus here is to use free software solutions, this is no requirement. But it is
  understandable that companies that do run proprietary software choose a
  distribution that is supported by their vendors.

* Gentoo Linux offers a fairly flexible approach on supported features. Thanks to
  a good balance of USE flags, servers and services can be installed that offer
  just those services that are needed, without any additional dependencies or
  features that need to be disabled (in order to secure the services) anyhow. This
  leads to somewhat better performance, but also to a saving in storage
  requirements, patching frequency, etc. Gentoo is also quite fast in adopting new
  technologies, which might help the business stand out against the other
  competitors.

* Gentoo uses rolling upgrades. That might not seem like a good way in
  enterprises, but it is. If an organization is doing things right, it is already
  distributing and rolling out patches and minor upgrades regularly. With Gentoo,
  this process is a bit more intrusive (as it might contain larger changes as
  well) but because the administrators are used to it, it is very much under
  control. As a result, whereas other organizations have to schedule large
  (expensive and time-consuming) upgrades every 3 to 5 years, Gentoo just moves
  along...

* Gentoo has a subproject called Gentoo Hardened who strives to provide, implement
  and support security-improving patches on the base system. This project has
  always been a fore-runner in security-related risk mitigation strategies.

Of course, because this book is called "A Gentoo Linux Advanced Reference
Architecture", it would be weird to have it talk about another distribution,
wouldn't it?

Now, the selection of Gentoo Linux also has a few challenges up its sleeve.

* Gentoo Linux is primarily a source-based distribution, which is frequently
  frowned upon in the enterprise market. Weirdly enough, enterprises don't find it
  strange that their development and operational teams keep on building frameworks
  and tools themselves because of lack of good tools. This is exactly where Gentoo
  Linux outshines the others: it offers many tools out-of-the-box to support every
  possible requirement.

  To reduce the impact of its source-only stigma, a chapter in this book is
  dedicated to the use of build servers and binhost support for improved
  manageability.

* Because of its source-based nature, it also provides all the tools for
  malicious users to build exploits on the server itself.

  It is fairly easy to hide the compiler or at least have some group-based
  access control on it. But regardless of that - the moment a malicious user has
  (shell) access to a system, the system is screwed anyhow. It is fairly easy to
  transfer files (even full applications) towards the system then.

  To reduce possible impact here, a Mandatory Access Control system should be
  used which isolates processes and even users, confining them to just what they
  need to get their job done.

As architecture, focusing only on the x86_64 architecture (amd64) is beneficial,
partially because it is the widest known in the Gentoo Linux development
community, but also because its hardware is widely available and sufficiently
cheap. It is also a processor architecture that is constantly evolving and has
many vendors working on it (less monopolizing strategies) which makes it a
better platform for consumers in my opinion.

That being said, this might be a good time to use a no-multilib approach in
Gentoo Linux. Systems need to be fully x86_64 driven, partially for
standardization as well, but also to make debugging easier. The fewer special
cases that need to be thought about, the faster problems can be resolved.
Generally though, this gives little (to no) additional advantage towards a
multilib profile.
