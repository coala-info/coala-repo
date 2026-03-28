[Skip to main content](#content)
Switch to mobile version

Warning
Some features may not work without JavaScript. Please try enabling it if you encounter problems.

[![PyPI](/static/images/logo-small.8998e9d1.svg)](/)

Search PyPI

Search

* [Help](/help/)
* [Docs](https://docs.pypi.org/)
* [Sponsors](/sponsors/)
* [Log in](/account/login/?next=https%3A%2F%2Fpypi.org%2Fproject%2Fpyfasta%2F0.1%2F)
* [Register](/account/register/)

Menu

* [Help](/help/)
* [Docs](https://docs.pypi.org/)
* [Sponsors](/sponsors/)
* [Log in](/account/login/?next=https%3A%2F%2Fpypi.org%2Fproject%2Fpyfasta%2F0.1%2F)
* [Register](/account/register/)

Search PyPI

Search

# pyfasta 0.1

pip install pyfasta==0.1

Copy PIP instructions

[Newer version available (0.5.2)](/project/pyfasta/)

Released:
May 27, 2009

pythonic access to fasta sequence files

### Navigation

* [Project description](#description)
* [Release history](#history)
* [Download files](#files)

### Verified details

*These details have been [verified by PyPI](https://docs.pypi.org/project_metadata/#verified-details)*

###### Maintainers

[![Avatar for brentp from gravatar.com](https://pypi-camo.freetls.fastly.net/7b667679ed7ef0782a146cf586ce8cbaf1577704/68747470733a2f2f7365637572652e67726176617461722e636f6d2f6176617461722f36373361313132636365616638613437313461633663336236616539313639303f73697a653d3530 "Avatar for brentp from gravatar.com")
brentp](/user/brentp/)

### Unverified details

*These details have **not** been verified by PyPI*

###### Project links

* [Homepage](http://code.google.com/p/bpbio/)

###### Meta

* **License:** MIT
* **Author:** brentp
* Tags

  bioinformatics
  ,

  blast

###### Classifiers

* **Topic**
  + [Scientific/Engineering :: Bio-Informatics](/search/?c=Topic+%3A%3A+Scientific%2FEngineering+%3A%3A+Bio-Informatics)

[Report project as malware](https://pypi.org/project/pyfasta/submit-malware-report/)

* [Project description](#description)
* [Project details](#data)
* [Release history](#history)
* [Download files](#files)

## Project description

Description:
:   pythonic access to fasta sequence files.

Author:
:   Brent Pedersen (brentp)

Email:
:   bpederse@gmail.com

License:
:   MIT

## Implementation

Requires Python >= 2.6. Uses the gzip module to store a flattened version of the fasta file
without any spaces or headers. And a pickle of the start, stop (for fseek) locations of each
header in the fasta file for internal use.

## Usage

```
>>> from pyfasta import Fasta

>>> f = Fasta('tests/data/three_chrs.fasta')
>>> sorted(f.keys())
['chr1', 'chr2', 'chr3']

>>> f['chr1']
FastaGz('tests/data/three_chrs.fasta.gz', 0..80)

>>> f['chr1'][:10]
'ACTGACTGAC'

# the index stores the start and stop of each header from teh fasta file
>>> f.index
{'chr3': (160, 3760), 'chr2': (80, 160), 'chr1': (0, 80)}

# can query by a 'feature' dictionary
>>> f.sequence({'chr': 'chr1', 'start': 2, 'stop': 9})
'CTGACTGA'

# with reverse complement for - strand
>>> f.sequence({'chr': 'chr1', 'start': 2, 'stop': 9, 'strand': '-'})
'TCAGTCAG'

# creates a .gz and a .gdx pickle of the fasta and the index.
>>> import os
>>> sorted(os.listdir('tests/data/'))[1:]
['three_chrs.fasta', 'three_chrs.fasta.gdx', 'three_chrs.fasta.gz']

# cleanup (though for real use these will remain for faster access)
>>> os.unlink('tests/data/three_chrs.fasta.gdx')
>>> os.unlink('tests/data/three_chrs.fasta.gz')
```

## Project details

### Verified details

*These details have been [verified by PyPI](https://docs.pypi.org/project_metadata/#verified-details)*

###### Maintainers

[![Avatar for brentp from gravatar.com](https://pypi-camo.freetls.fastly.net/7b667679ed7ef0782a146cf586ce8cbaf1577704/68747470733a2f2f7365637572652e67726176617461722e636f6d2f6176617461722f36373361313132636365616638613437313461633663336236616539313639303f73697a653d3530 "Avatar for brentp from gravatar.com")
brentp](/user/brentp/)

### Unverified details

*These details have **not** been verified by PyPI*

###### Project links

* [Homepage](http://code.google.com/p/bpbio/)

###### Meta

* **License:** MIT
* **Author:** brentp
* Tags

  bioinformatics
  ,

  blast

###### Classifiers

* **Topic**
  + [Scientific/Engineering :: Bio-Informatics](/search/?c=Topic+%3A%3A+Scientific%2FEngineering+%3A%3A+Bio-Informatics)

## Release history [Release notifications](/help/#project-release-notifications) | [RSS feed](/rss/project/pyfasta/releases.xml)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.5.2

Apr 3, 2014](/project/pyfasta/0.5.2/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.5.1

Oct 3, 2013](/project/pyfasta/0.5.1/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.5.0

Aug 29, 2013](/project/pyfasta/0.5.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.4.5

Feb 21, 2012](/project/pyfasta/0.4.5/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.4.4

Oct 12, 2011](/project/pyfasta/0.4.4/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.4.3

May 31, 2011](/project/pyfasta/0.4.3/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.4.2

Apr 5, 2011](/project/pyfasta/0.4.2/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.4.1

Dec 1, 2010](/project/pyfasta/0.4.1/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.4.0

Oct 25, 2010](/project/pyfasta/0.4.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.9

Mar 17, 2010](/project/pyfasta/0.3.9/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.7

Dec 21, 2009](/project/pyfasta/0.3.7/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.6

Dec 21, 2009](/project/pyfasta/0.3.6/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.5

Dec 20, 2009](/project/pyfasta/0.3.5/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.4

Dec 15, 2009](/project/pyfasta/0.3.4/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.3

Dec 6, 2009](/project/pyfasta/0.3.3/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.2

Dec 3, 2009](/project/pyfasta/0.3.2/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.1

Nov 17, 2009](/project/pyfasta/0.3.1/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.0

Nov 17, 2009](/project/pyfasta/0.3.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.2.9

Nov 10, 2009](/project/pyfasta/0.2.9/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.2.8

Nov 6, 2009](/project/pyfasta/0.2.8/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.2.5

Sep 23, 2009](/project/pyfasta/0.2.5/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.2.4

Sep 9, 2009](/project/pyfasta/0.2.4/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.2.3

Sep 8, 2009](/project/pyfasta/0.2.3/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.2.2

Sep 8, 2009](/project/pyfasta/0.2.2/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.2.1

Jul 13, 2009](/project/pyfasta/0.2.1/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.2

Jul 13, 2009](/project/pyfasta/0.2/)

This version

![](https://pypi.org/static/images/blue-cube.572a5bfb.svg)

[0.1

May 27, 2009](/project/pyfasta/0.1/)

## Download files

Download the file for your platform. If you're not sure which to choose, learn more about [installing packages](https://packaging.python.org/tutorials/installing-packages/ "External link").

### Source Distribution

[pyfasta-0.1.tar.gz](https://files.pythonhosted.org/packages/96/6f/510f7dc1ebb333301c23ebed17b7e38a0393a765c889cb0320e14769ecfe/pyfasta-0.1.tar.gz)
(4.9 kB
[view details](#pyfasta-0.1.tar.gz))

Uploaded
May 27, 2009
`Source`

## File details

Details for the file `pyfasta-0.1.tar.gz`.

### File metadata

* Download URL: [pyfasta-0.1.tar.gz](https://files.pythonhosted.org/packages/96/6f/510f7dc1ebb333301c23ebed17b7e38a0393a765c889cb0320e14769ecfe/pyfasta-0.1.tar.gz)
* Upload date:
  May 27, 2009
* Size: 4.9 kB
* Tags: Source
* Uploaded using Trusted Publishing? No

### File hashes

Hashes for pyfasta-0.1.tar.gz

| Algorithm | Hash digest |  |
| --- | --- | --- |
| SHA256 | `e7f9e5a1bb63b6c093e44cd96d1d9d0ccfd645add075eecef5337c5538e1b3c1` | Copy |
| MD5 | `1997d5d93ada9e7f6a5056555fcab50f` | Copy |
| BLAKE2b-256 | `966f510f7dc1ebb333301c23ebed17b7e38a0393a765c889cb0320e14769ecfe` | Copy |

[See more details on using hashes here.](https://pip.pypa.io/en/stable/topics/secure-installs/#hash-checking-mode "External link")

![](/static/images/white-cube.2351a86c.svg)

## Help

* [Installing packages](https://packaging.python.org/tutorials/installing-packages/ "External link")
* [Uploading packages](https://packaging.python.org/tutorials/packaging-projects/ "External link")
* [User guide](https://packaging.python.org/ "External link")
* [Project name retention](https://www.python.org/dev/peps/pep-0541/ "External link")
* [FAQs](/help/)

## About PyPI

* [PyPI Blog](https://blog.pypi.org "External link")
* [Infrastructure dashboard](https://dtdg.co/pypi "External link")
* [Statistics](/stats/)
* [Logos & trademarks](/trademarks/)
* [Our sponsors](/sponsors/)

## Contributing to PyPI

* [Bugs and feedback](/help/#feedback)
* [Contribute on GitHub](https://github.com/pypi/warehouse "External link")
* [Translate PyPI](https://hosted.weblate.org/projects/pypa/warehouse/ "External link")
* [Sponsor PyPI](/sponsors/)
* [Development credits](https://github.com/pypi/warehouse/graphs/contributors "External link")

## Using PyPI

* [Terms of Service](https://policies.python.org/pypi.org/Terms-of-Service/ "External link")
* [Report security issue](/security/)
* [Code of conduct](https://policies.python.org/python.org/code-of-conduct/ "External link")
* [Privacy Notice](https://policies.python.org/pypi.org/Privacy-Notice/ "External link")
* [Acceptable Use Policy](https://policies.python.org/pypi.org/Acceptable-Use-Policy/ "External link")

---

Status:[all systems operational](https://status.python.org/ "External link")

Developed and maintained by the Python community, for the Python community.
[Donate today!](https://donate.pypi.org)

"PyPI", "Python Package Index", and the blocks logos are registered [trademarks](/trademarks/) of the [Python Software Foundation](https://www.python.org/psf-landing).

© 2026 [Python Software Foundation](https://www.python.org/psf-landing/ "External link")

[Site map](/sitemap/)

Switch to desktop version

* English
* español
* français
* 日本語
* português (Brasil)
* українська
* Ελληνικά
* Deutsch
* 中文 (简体)
* 中文 (繁體)
* русский
* עברית
* Esperanto
* 한국어

Supported by

[![](https://pypi-camo.freetls.fastly.net/ed7074cadad1a06f56bc520ad9bd3e00d0704c5b/68747470733a2f2f73746f726167652e676f6f676c65617069732e636f6d2f707970692d6173736574732f73706f6e736f726c6f676f732f6177732d77686974652d6c6f676f2d7443615473387a432e706e67)
AWS

Cloud computing and Security Sponsor](https://aws.amazon.com/)
[![](https://pypi-camo.freetls.fastly.net/8855f7c063a3bdb5b0ce8d91bfc50cf851cc5c51/68747470733a2f2f73746f726167652e676f6f676c65617069732e636f6d2f707970692d6173736574732f73706f6e736f726c6f676f732f64617461646f672d77686974652d6c6f676f2d6668644c4e666c6f2e706e67)
Datadog

Monitoring](https://www.datadoghq.com/)
[![](https://pypi-camo.freetls.fastly.net/60f709d24f3e4d469f9adc77c65e2f5291a3d165/68747470733a2f2f73746f726167652e676f6f676c65617069732e636f6d2f707970692d6173736574732f73706f6e736f726c6f676f732f6465706f742d77686974652d6c6f676f2d7038506f476831302e706e67)
Depot

Continuous Integration](https://depot.dev)
[![](https://pypi-camo.freetls.fastly.net/df6fe8829cbff2d7f668d98571df1fd011f36192/68747470733a2f2f73746f726167652e676f6f676c65617069732e636f6d2f707970692d6173736574732f73706f6e736f726c6f676f732f666173746c792d77686974652d6c6f676f2d65684d3077735f6f2e706e67)
Fastly

CDN](https://www.fastly.com/)
[![](https://pypi-camo.freetls.fastly.net/420cc8cf360bac879e24c923b2f50ba7d1314fb0/68747470733a2f2f73746f726167652e676f6f676c65617069732e636f6d2f707970692d6173736574732f73706f6e736f726c6f676f732f676f6f676c652d77686974652d6c6f676f2d616734424e3774332e706e67)
Google

Download Analytics](https://careers.google.com/)
[![](https://pypi-camo.freetls.fastly.net/d01053c02f3a626b73ffcb06b96367fdbbf9e230/68747470733a2f2f73746f726167652e676f6f676c65617069732e636f6d2f707970692d6173736574732f73706f6e736f726c6f676f732f70696e67646f6d2d77686974652d6c6f676f2d67355831547546362e706e67)
Pingdom

Monitoring](https://www.pingdom.com/)
[![](https://pypi-camo.freetls.fastly.net/67af7117035e2345bacb5a82e9aa8b5b3e70701d/68747470733a2f2f73746f726167652e676f6f676c65617069732e636f6d2f707970692d6173736574732f73706f6e736f726c6f676f732f73656e7472792d77686974652d6c6f676f2d4a2d6b64742d706e2e706e67)
Sentry

Error logging](https://sentry.io/for/python/?utm_source=pypi&utm_medium=paid-community&utm_campaign=python-na-evergreen&utm_content=static-ad-pypi-sponsor-learnmore)
[![](https://pypi-camo.freetls.fastly.net/b611884ff90435a0575dbab7d9b0d3e60f136466/68747470733a2f2f73746f726167652e676f6f676c65617069732e636f6d2f707970692d6173736574732f73706f6e736f726c6f676f732f737461747573706167652d77686974652d6c6f676f2d5467476c6a4a2d502e706e67)
StatusPage

Status page](https://statuspage.io)