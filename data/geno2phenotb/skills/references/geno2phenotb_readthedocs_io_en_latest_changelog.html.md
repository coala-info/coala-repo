latest

* [Overview](readme.html)
* [Installation](installation.html)
* [Command Line Interface](cli.html)
* [Python Interface](api/modules.html)
* [Contributing & Help](contributing.html)
* [Acknowledgments](acknowledgments.html)
* [Authors](authors.html)
* Release Notes
  + [Version 1.0](#version-1-0)
    - [1.0.1 2023-07-31](#id1)
    - [1.0.0 2023-06-21](#id2)
* [License](license.html)
* [References](references.html)

[geno2phenoTB](index.html)

* Release Notes
* [Edit on GitHub](https://github.com/msmdev/geno2phenoTB/blob/main/docs/changelog.rst)

---

# Release Notes[](#release-notes "Permalink to this heading")

## Version 1.0[](#version-1-0 "Permalink to this heading")

### 1.0.1 2023-07-31[](#id1 "Permalink to this heading")

Fixes

* Bump python version to 3.8.15 since 3.7 is not officially supported any longer und thus causes
  problems with bioconda.
* Relax (sub)version pinning of several dependencies to enable building on bioconda.
* Fix failing publish action in CI.
* Fix a known security vulnerability (CVE-2022-21797) by updating joblib to 1.2.

### 1.0.0 2023-06-21[](#id2 "Permalink to this heading")

Initial release.

[Previous](authors.html "Contributors")
[Next](license.html "License")

---

© Copyright 2023, Bernhard Reuter, Jules Kreuer.
Revision `d0de6e0a`.