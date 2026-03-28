[ ]
[ ]

[Skip to content](#about)

SADIE

SADIE

Initializing search

[jwillis0720/sadie](https://github.com/jwillis0720/sadie "Go to repository")

SADIE

[jwillis0720/sadie](https://github.com/jwillis0720/sadie "Go to repository")

* [ ]

  SADIE

  [SADIE](.)

  Table of contents
  + [About](#about)
  + [Installation](#installation)

    - [Installation with M1 or M2 Macs](#installation-with-m1-or-m2-macs)
  + [Quick Usage](#quick-usage)
  + [License](#license)
* [Reference Database](reference/)
* [ ]

  AIRR Sequence Annotation

  AIRR Sequence Annotation
  + [Annotating](annotation/)
  + [Advanced Annotation Methods](advanced_annotation/)
  + [Visualization](visualization/)
* [Sequence Numbering](renumbering/)
* [BCR/TCR Objects](models/)
* [Clustering](clustering/)
* [Contributing to SADIE](contribute/)

Table of contents

* [About](#about)
* [Installation](#installation)

  + [Installation with M1 or M2 Macs](#installation-with-m1-or-m2-macs)
* [Quick Usage](#quick-usage)
* [License](#license)

## **S**equencing **A**nalysis and **D**ata Library for **I**mmunoinformatics **E**xploration

![SADIE](https://sadiestaticcrm.s3.us-west-2.amazonaws.com/Sadie.svg)

[![Python Version](https://img.shields.io/badge/Python-3.9%7C3.10%7C3.11%7C3.12%7C3.13-blue)
[![Format Version](https://img.shields.io/badge/code%20style-black-000000.svg)
[![Code Coverage](https://codecov.io/gh/jwillis0720/sadie/branch/main/graph/badge.svg?token=EH9QEX4ZMP)](https://codecov.io/gh/jwillis0720/sadie)](https://github.com/psf/black)](https://img.shields.io/badge/Python-3.9%7C3.10%7C3.11%7C3.12%7C3.13-blue)

![pre commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)
[![pypi](https://img.shields.io/pypi/v/sadie-antibody?color=blue)
[![Documentation](https://api.netlify.com/api/v1/badges/59ff956c-82d9-4900-83c7-758ed21ccb34/deploy-status)](https://sadie.jordanrwillis.com)
[![Documentation](https://github.com/jwillis0720/sadie/actions/workflows/docs.yml/badge.svg)](https://github.com/jwillis0720/sadie/actions/workflows/docs.yml)](https://pypi.org/project/sadie-antibody%22)

[![Linux Build](https://github.com/jwillis0720/sadie/workflows/Linux%20Build%20and%20Test/badge.svg)
[![Mac Build](https://github.com/jwillis0720/sadie/workflows/MacOS%20Build%20and%20Test/badge.svg)
[![Static Type](https://github.com/jwillis0720/sadie/actions/workflows/pyright.yml/badge.svg)](https://github.com/jwillis0720/sadie/actions/workflows/pyright.yml/badge.svg)](https://github.com/jwillis0720/sadie/workflows/MacOS%20Build%20and%20Test/badge.svg)](https://github.com/jwillis0720/sadie/workflows/Linux%20Build%20and%20Test/badge.svg)

## About[¶](#about "Permanent link")

---

**Documentations**: <https://sadie.jordanrwillis.com>

**Source Code**: <https://github.com/jwillis0720/sadie>

**Colab**: [https://colab.research.google.com/github/jwillis0720/sadie](https://colab.research.google.com/github/jwillis0720/sadie/blob/main/notebooks/airr_c/SADIE_DEMO.ipynb)

---

SADIE is the **S**equencing **A**nalysis and **D**ata library for **I**mmunoinformatics **E**xploration. The key features include:

* Provide pre-built **command line apps** for popular immunoinformatics applications.
* Provide a **low-level API framework** for immunoinformatics developers to build higher level tools.
* Provide a **testable** and **reusable** library that WORKS!
* Provide a **customizable** and **verified** germline reference library.
* Maintain data formats consistent with standards governed by the [**AIRR community**](https://docs.airr-community.org/en/stable/#table-of-contents)
* **Portability** ready to use out of the box.

SADIE is billed as a "**complete antibody library**", not because it aims to do everything but because it aims to meet the needs of all immunoinformatics users. SADIE contains both low, mid, and high level functionality for immunoinformatics tools and workflows. You can use SADIE as a framework to develop your own tools, use many of the prebuilt contributed tools, or run it in a notebook to enable data exploration. In addition, SADIE aims to port all code to Python because it relies heavily on the [Pandas](https://www.pandas.org) library, the workhorse of the data science/machine learning age.

## Installation[¶](#installation "Permanent link")

---

Installation is handled using the Python package installer `pip`

```
$ pip install sadie-antibody
---> 100%
```

### Installation with M1 or M2 Macs[¶](#installation-with-m1-or-m2-macs "Permanent link")

---

If you use the Apple M1 version of [Conda](https://docs.conda.io/en/latest/miniconda.html), please create your SADIE environment using the following.

```
$ conda create -n sadie python=3.10.6
---> 100%
$ conda activate sadie
$ pip install sadie-antibody
$ conda install -c conda-forge biopython
---> 100%
```

Note

You must install biopython from conda since pip install sadie-antibody will not install the proper version of biopython.

For additional help, please file an issue on the [SADIE GitHub](https://github.com/jwillis0720/sadie/issues).

# Quick Usage[¶](#quick-usage "Permanent link")

Consult the [documentation](https://sadie.jordanrwillis.com) for complete usage. Or checkout our [Colab](https://colab.research.google.com/github/jwillis0720/sadie/blob/main/notebooks/airr_c/SADIE_DEMO.ipynb) notebook

# License[¶](#license "Permanent link")

[![License](https://img.shields.io/github/license/jwillis0720/sadie)](https://opensource.org/licenses/MIT)

* Copyright © Jordan R. Willis, Troy Sincomb, and Caleb K Kibet

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)