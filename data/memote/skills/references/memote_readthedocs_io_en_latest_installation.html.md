[![](_static/memote-logo.png)](index.html)
**0.11.1**

* [Site](index.html)

  - Installation
  - [Getting Started](getting_started.html)
  - [Flowchart](flowchart.html)
  - [Understanding the reports](understanding_reports.html)
  - [Experimental Data](experimental_data.html)
  - [Custom Tests](custom_tests.html)
  - [Test Suite](test_suite.html)
  - [Contributing](contributing.html)
  - [Credits](authors.html)
  - [History](history.html)
  - [API Reference](autoapi/index.html)
* Page

  - Installation
    * [Stable release](#stable-release)
    * [From sources](#from-sources)
* [« memote - the ...](index.html "Previous Chapter: memote - the genome-scale metabolic model test suite")
* [Getting Started »](getting_started.html "Next Chapter: Getting Started")
* [Source](_sources/installation.rst.txt)

# Installation[¶](#installation "Permalink to this headline")

**Please Note**: With its
[retirement on the horizon](https://pythonclock.org) we decided to stop
testing against Python 2.7,
and [like many others](https://python3statement.org), want to focus entirely
on Python 3.
Hence, we cannot guarantee that memote will still function as expected

Before installing memote, make sure that you have correctly installed the
latest version of [git](https://git-scm.com/).

We highly recommend creating a Python [virtualenv](http://docs.python-guide.org/en/latest/dev/virtualenvs/) for your model testing
purposes.

## Stable release[¶](#stable-release "Permalink to this headline")

To install memote, run this command in your terminal:

```
$ pip install memote
```

This is the preferred method to install memote, as it will always install the most recent stable release.

If you don’t have [pip](https://pip.pypa.io/en/stable/) installed, this [Python installation guide](http://docs.python-guide.org/en/latest/starting/installation/) can guide
you through the process.

## From sources[¶](#from-sources "Permalink to this headline")

The sources for memote can be downloaded from the [Github repo](https://github.com/opencobra/memote).

You can either clone the public repository:

```
$ git clone https://github.com/opencobra/memote.git
```

Or download the [tarball](https://github.com/opencobra/memote/archive/master.tar.gz) or
[zip](https://github.com/opencobra/memote/archive/master.zip) archive:

```
$ curl  -OL https://github.com/opencobra/memote/archive/master.zip
```

Once you have a copy of the source files, you can install it with:

```
$ pip install .
```

Back to top

© Copyright 2017, Novo Nordisk Foundation Center for Biosustainability, Technical University of Denmark.
Last updated on Sep 13, 2023.