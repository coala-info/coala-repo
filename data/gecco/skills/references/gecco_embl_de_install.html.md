[![](_static/gecco.png)
GECCO](index.html)
**v0.9.10**

* [Repository](https://github.com/zellerlab/GECCO)
* [Documentation](index.html)

  - Installation
  - [Integrations](integrations.html)
  - [Training](training.html)
  - [Contributing](contributing.html)
  - [API reference](api/index.html)
  - [Changelog](changes.html)
* [« GECCO](index.html "Previous Chapter: GECCO")
* [Integrations »](integrations.html "Next Chapter: Integrations")

* Installation
  + [Requirements](#requirements)
  + [Installing GECCO locally](#installing-gecco-locally)
    - [PyPi](#pypi)
    - [Conda](#conda)
  + [Using GECCO in Galaxy](#using-gecco-in-galaxy)

# Installation[¶](#installation "Permalink to this heading")

## Requirements[¶](#requirements "Permalink to this heading")

GECCO requires additional libraries that can be installed directly from PyPI,
the Python Package Index. Contrary to other tools in the field
(such as DeepBGC or AntiSMASH), it does not require any external binary.

## Installing GECCO locally[¶](#installing-gecco-locally "Permalink to this heading")

### PyPi[¶](#pypi "Permalink to this heading")

The GECCO source is hosted on the EMBL Git server and mirrored on GitHub, but
the easiest way to install it is to download the latest release from
[PyPi](https://pypi.python.org/pypi/gecco) with `pip`.

```
$ pip install gecco-tool
```

### Conda[¶](#conda "Permalink to this heading")

GECCO is also available as a [recipe](https://anaconda.org/bioconda/GECCO)
in the [Bioconda](https://bioconda.github.io/) channel. To install, simply
use the `conda` installer:

```
$ conda install -c bioconda GECCO
```

## Using GECCO in Galaxy[¶](#using-gecco-in-galaxy "Permalink to this heading")

GECCO is available as a Galaxy tool in the [Toolshed](https://toolshed.g2.bx.psu.edu/).
It can be used directly on the [Galaxy Europe server](https://usegalaxy.eu/). To
add it to your local Galaxy server, get in touch with the admin and ask them
to add the [Toolshed repository for GECCO](https://toolshed.g2.bx.psu.edu/view/althonos/gecco/88dc16b4f583)
to the server tools.

Back to top

© Copyright 2020-2024, Zeller group, EMBL.
Created using [Sphinx](http://sphinx-doc.org/) 5.3.0.