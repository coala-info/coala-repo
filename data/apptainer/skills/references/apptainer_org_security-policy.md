[Apptainer![Apptainer](/apptainer.svg)](/)

Open main menu

[Documentation](/documentation)[Support](/support)[News](/news)[Showcases](/showcases)

[Get Started →](/get-started)

# Security Policy

The Apptainer Technical Steering Committee (TSC) is responsible for managing the security of Apptainer, and this web page
documents the security policy we follow.

### **Do you think you found a vulnerability?**

If you believe you have discovered a vulnerability in Apptainer, please let us know. You can notify the TSC by email at security@apptainer.org.

We encourage people who contact the TSC on a security matter to use email encryption. [Get our PGP public key](/apptainer-security.pub) and verify the fingerprint:

`F642 B2B2 5989 AA44 D987 225C 6F21 6032 31A3 462A`

### **The goals of a standardized security response procedure**

Before we cover the procedure that the TSC takes to mitigate newly discovered vulnerabilities, let's talk about the goals we're
trying to achieve.

* ****Fast turnaround:****
  Even vulnerabilities that have not been announced publicly are a potential source of danger because a savvy hacker may be
  able to discover and exploit them independently. Our procedures are designed to first understand and then quickly remediate as
  primary goals.

* ****Limited exposure:****
  Before patches are developed and made available, our goal is to limit the spread of information until after a patch is
  available and key stakeholders are protected

* ****Transparency:****
  The open-source community must know exactly what the TSC intends to do about vulnerabilities and how we are are carrying out
  our commitment to security. Vulnerabilities are documented using the Common Vulnerabilities and Exposures (CVE) system to
  provide a permanent searchable record allowing administrators to accurately judge the risks of running a particular version of
  Apptainer within their environment.

* ****Enable stakeholders over malicious actors:****
  When a new vulnerability is publicly announced, a race begins between system administrators and those with nefarious intent.
  Apptainer collaborators that distribute Apptainer only in binary form are provided security patches prior to security
  announcements. They then distribute patched binaries to their stakeholders as a head start in the security race. Although
  patched binaries are made available to Apptainer stakeholders first, they are provided without releasing security-related
  information. This limits exposure to the open source community while still providing a way of remediation for Apptainer
  stakeholders, with a level of proactive measure.

### **Apptainer vulnerability procedure**

When a vulnerability is discovered, the TSC takes the following steps:

1. Perform due diligence to fully replicate and describe the scope and severity of the bug. (This step is expected to take hours,
   not days.)
2. A CVE number is requested and embargoed until public release is made.
3. Security patch(es) are confidentially developed. (This step is expected to take hours or days and will be carried out with
   appropriate urgency.)
4. Security patches are merged into test versions of Apptainer and testing commences. Bugs related to patch(es) are fixed and
   testing is repeated as necessary. (This process is expected to take days.)
5. Once patch(es) are developed and fully tested, they are pushed to a
   [GitHub Security Advisory](https://docs.github.com/en/code-security/security-advisories/about-github-security-advisories)
    which keeps them hidden until ready for public disclosure.
6. The GitHub Security Advisory is shared with Apptainer collaborators that distribute binary versions of Apptainer.
7. The Apptainer collaborators then prepare their binaries and notify their stakeholders only with a standard notification that
   there is a new binary and they should upgrade. This notice will NOT contain any sensitive information and will NOT disclose
   the presence of a security-related patch.
8. The stakeholders of Apptainer collaborators are given a reasonable amount of time to upgrade their installations so that when
   details of the exploit are revealed they are already protected.
9. After a reasonable period of time has elapsed and stakeholders have likely upgraded (and on a Tuesday where possible as
   several administrators have
   [suggested](https://groups.google.com/a/lbl.gov/forum/#!topic/singularity/FgHj7WhqIE8)), the patches will be merged
   from the private development space into the public repository and a release will immediately be made. The release notes will
   do the following:
   1. Describe the issue in sufficient detail so that affected parties can judge whether to upgrade.
   2. If there is a mitigation or workaround detail it. If there is not, explicitly say there is no known workaround.
   3. State whether a malicious user needs access to the system to exploit the vulnerability or whether it can be exploited
      remotely.
   4. State which versions of Apptainer are affected and which OS-es/kernels are affected.
   5. Reference relevant CVE number(s).
10. At the same time that a release is being made, the CVE(s) will be filled out with all relevant information and released from
    embargo.
11. Announcements will be made on Slack and on the Google Group that a new version of Apptainer is available with all relevant
    security information and links to release notes.

[Documentation](/documentation)

[Support](/support)

[Security Policy](/security-policy)

[Contact Us](/contact-us)

[Technical Charter](/technical-charter)

Copyright © Contributors to the Apptainer project, established as Apptainer a Series of LF Projects LLC.
For website terms of use,
trademark policy, privacy policy and other project policies please see <https://lfprojects.org/policies>.