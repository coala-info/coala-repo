Toggle navigation

[dDocent](https://jpuritz.github.io/dDocent/)

* [Why dDocent?](/why)
* Documentation

  [Quick Start Guide](/quick)
  [Full User Guide](/UserGuide)
  [Assembly Tutorial](/assembly)
  [SNP Filtering Tutorial](/filtering)
  [Citing dDocent](/citing)
  [Papers using dDocent](/using)
* Download

  [Bioconda Download and Install](/bioconda)
  [Current Release and Manual Install](/downloads)
  [Developmental Version](https://github.com/jpuritz/dDocent)
* [Blog](/blog)
* [Help](/help)

[![](/dDocent.png)](https://jpuritz.github.io/dDocent/%20)

# Bioconda Install

---

less than 10 lines of code

### The beauty of Conda

Conda is an open source package and environment management system for installing multiple versions of software packages and their dependencies and switching easily between them. It works on Linux, OS X and Windows, and was created for Python programs but can package and distribute any software.

Miniconda is a small version that includes only conda, Python, and the packages they depend on. Over **720** scientific packages and their dependencies can be installed individually from the Continuum repository with the “conda install” command.

![alt text](/biocondabadge.png)

### So easy, your grandfather could do this…

![alt text](https://anaconda.org/bioconda/ddocent/badges/downloads.svg) ![alt text](https://anaconda.org/bioconda/ddocent/badges/platforms.svg)

Install Miniconda: <http://conda.pydata.org/miniconda.html>

Add the bioconda channel:

```
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
```

Create a dDocent conda environment:

```
conda create -n ddocent_env ddocent
```

Activate the dDocent environment:

```
source activate ddocent_env
```

Run dDocent:

```
dDocent
```

Close the environment when you’re done:

```
source deactivate
```

© [Jon Puritz](http://MarineEvoEco.com)
 •
2025

"The "d" is silent, hillbilly" - Django

Theme by
[beautiful-jekyll](http://deanattali.com/beautiful-jekyll/)