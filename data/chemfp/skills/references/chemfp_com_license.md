# [chemfp](https://chemfp.com/index.html)

* [Features](https://chemfp.com/features/)
* [Download](https://chemfp.com/download/)
* [Datasets](https://chemfp.com/datasets/)
* [License](https://chemfp.com/license/)
* [News](https://chemfp.com/news/)
* [Contact](https://chemfp.com/contact/)

* [High Performance Search](/performance/)
* [FPS Format](/fps_format/)
* [FPB Format](/fpb_format/)
* [FPC Format](/fpc_format/)
* [• Datasets](/datasets/)
* [Multiple Toolkit Support](/toolkits/)
* [Documentation:](/docs/)
* [• Command-line Tools](/docs/tools.html)
* [• Python API](/docs/chemfp_api.html)
* [• Example Programs](https://hg.sr.ht/~dalke/chemfp_examples)

## Chemfp licenses

chemfp has two development tracks. The 1.x track is available for no
cost under the MIT license, and multiple licensing options are
available for the 5x track.

## Chemfp 5.x licensing

The most recent versions of the 5.x track are available with several
different licensing options. Use one of the buttons below to request
an evaluation license key, or email
sales@dalkescientific.com.

Most customers opt for a source license. This comes with the source
code (which works on macOS and Linux-based OSes) and a year of
support, which includes email support, free updates to any new
releases during the year, and the option to renew support at fraction
of the list price.

In addition, the source license has *no time limit*, *no license
manager*, and *the right to modify and maintain chemfp* even without a
support contract. This helps you avoid vendor lock-in and avoid
licenses expiring unexpectedly.

Binary licensing for the [Linux-based Python package](/download/) is
also available, with a time-limited license key.

### 1. The Chemfp Base License

Pre-compiled Python packages for most Linux-based OSes are available
for download under the
[Chemfp Base License Agreement](/BaseLicense.txt). This can be
installed using:

```
python -m pip install chemfp -i https://chemp.com/packages/
```

This license lets you use most chemfp features in-house, and generate
FPS files for any purpose.

Some features are either limited or disabled. The Base License does
not permit you to:

* generate FPB files;
* create in-memory fingerprint arenas with more than 50,000
  fingerprints;
* use the simarray functionality to process fingerprint
  sets with more than 20,000 fingerprints, unless they
  are licensed FPB files as described below;
* use other search methods on fingerprint arenas with more
  than 50,000 fingerprints, unless they are licensed FPB
  files as described below;
* perform Tversky searches;
* perform Tanimoto searches of FPS files with more than 20 queries at
  a time.

These features can be enabled with a time-based license key. Use one
of the options below to request an evaluation license key.

### 2. Single-site in-house commercial license

The [single-site license](/ChemfpSingleSiteLicenseAgreement_v2.pdf) is
for companies which will only use chemfp at a single geographic
location. This might be a small company with only one location, or a
single research group in a world-wide company, or a self-employed
person. Special consideration may be made for small but distributed
groups.

The location is determined by where the people generally work, not
where the software is used. For example, chemfp may be deployed on
remote cloud-computing hardware so long as the users of the software
generally work at one place. (This will be interpereted generously as
many people are working from home because of the pandemic.)

Customers may purchase a long-term license key for the binary package,
or opt for source code access. Source code licenses are not
time-limited.

### 3. World-wide in-house commercial license

The [world-wide source
license](/ChemfpWorldwideLicenseAgreement_v2.pdf) or [world-wide binary license](/ChemfpWorldwideLicenseAgreement_Binary_v2.pdf) is for
companies which will deploy chemfp any place in the world for in-house
use, including deployment on remote cloud servers.

Customers may purchase a long-term license key for the binary package,
or opt for source code access. Source code licenses are not
time-limited.

### 4. Academic license

The [academic license](/Dalke_Academic_License.pdf) is for public
research and education. It can be used for research where the results
are meant to be published in the open literature, in the development
of web servers which are meant for general public use, and for student
use where the goal is education or training.

Academics may request a no-cost one year license key for the
pre-compiled binary. No support is included in this option.

Academics may also purchase access to the chemfp source code under
this license.

### 5. MIT/Open source license

Chemfp is also available under the MIT open source license. This is a
permissive license which lets you use chemfp for almost any purpose,
including reselling it.

One of the goals of the chemfp project was to experiment with funding
a pure open source software project through commercial sales. The
business model was that people would pay for chemfp and receive the
source code as open source.

Experience showed some of the [problems selling open source software](https://jcheminf.biomedcentral.com/articles/10.1186/s13321-019-0398-8#Sec24). For
example, the economic risk of selling to academics - who typically
expect greatly reduced rates - meant that it was only sold to
industrial customers.

The results of the experiment lead to the different licensing options
listed above.

Open source licensing is still available, though it is the most
expensive option by far.

## Chemfp 1.x licensing (No-cost and Open Source)

Chemfp 1.6.1 is the most recent version of the chemfp 1.x track. Be
aware that it only works on Python 2.7, which is no longer supported
by the modern versions of RDKit, Open Babel, or OEChem. The primary
goal of chemfp 1.6.1 is to provide a good reference baseline for
evaluating Tanimoto similarity search performance.

You can
[download chemfp 1.6.1](http://dalkescientific.com/releases/chemfp-1.6.1.tar.gz)
directly or [install it from PyPI](https://pypi.org/project/chemfp/) using

```
python2.7 -m pip install chemfp
```

This version of chemfp is distributed under the MIT license. Some
third-party components which are distributed under a similarly
permissive license. For license details, see the
[license section](https://web.archive.org/web/20200922233859/http%3A//chemfp.readthedocs.io/en/chemfp-1.6.1/#license-and-advertisement)
of the chemfp 1.6.1 documentation.

Contact sales@dalkescientific.com
if you have questions.

Copyright © 2012-2025 Andrew Dalke Scientific AB