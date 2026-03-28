* [Home](index.html)
* Get it
* [Docs](contents.html)
* [Extend/Develop](http://github.com/prophyle/prophyle)

[ProPhyle

DNA sequence classification](index.html)

### Navigation

* [index](genindex.html "General Index")
* [next](standard_db.html "4. Building a standard database") |
* [previous](requirements.html "2. Requirements") |
* [ProPhyle home](index.html) |
* [Documentation](contents.html) »
* 3. Installing ProPhyle

### [Table of Contents](contents.html)

* 3. Installing ProPhyle
  + [3.1. Installing ProPhyle using Bioconda](#installing-prophyle-using-bioconda)
  + [3.2. Installing ProPhyle using PIP](#installing-prophyle-using-pip)
  + [3.3. Running ProPhyle directly from the repository](#running-prophyle-directly-from-the-repository)
    - [Adjusting the PATH variable](#adjusting-the-path-variable)
    - [Installing dependencies](#installing-dependencies)

#### Previous topic

[2. Requirements](requirements.html "previous chapter")

#### Next topic

[4. Building a standard database](standard_db.html "next chapter")

### This Page

* [Show Source](_sources/install.rst.txt)

### Quick search

# 3. Installing ProPhyle[¶](#installing-prophyle "Link to this heading")

ProPhyle is written in Python, C and C++. It is distributed as a Python package
and all C/C++ programs are compiled upon the first execution
of the main program. ProPhyle requires a Unix operating system and the following dependencies:

* Python 3.3+ with the [ETE3 library](http://etetoolkit.org/)
* GCC 4.8+
* ZLib

There are multiple ways of installation:

* [Installing ProPhyle using Bioconda](#installing-prophyle-using-bioconda)
* [Installing ProPhyle using PIP](#installing-prophyle-using-pip)
* [Running ProPhyle directly from the repository](#running-prophyle-directly-from-the-repository)

## 3.1. Installing ProPhyle using Bioconda[¶](#installing-prophyle-using-bioconda "Link to this heading")

To set-up Bioconda, install
[Miniconda](https://conda.io/miniconda.html)
or another Conda distribution, and
add [Bioconda channels](https://bioconda.github.io/)

```
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda
```

You may either create a separate Conda environment
(which is the recommended approach)

```
conda create -n prophyle prophyle
source activate prophyle
```

or install ProPhyle directly to your main environment

```
conda install prophyle
```

## 3.2. Installing ProPhyle using PIP[¶](#installing-prophyle-using-pip "Link to this heading")

There are three options of installing ProPhyle using PIP.

1. From PyPI

   > ```
   > pip install -U prophyle
   > ```
2. From Git

   > ```
   > pip install -U git+https://github.com/prophyle/prophyle
   > ```
3. From PyPI to the current directory

   > ```
   > pip install --user prophyle
   > export PYTHONUSERBASE=`pwd`
   > export PATH=$PATH:`pwd`/bin
   > ```

## 3.3. Running ProPhyle directly from the repository[¶](#running-prophyle-directly-from-the-repository "Link to this heading")

It also is possible to run ProPhyle directly from the repository, by calling
the main script

```
prophyle/prophyle/prophyle.py
```

or its alias

```
prophyle/prophyle/prophyle
```

ProPhyle will then automatically adjust all paths of the auxiliary programs.

Note that ProPhyle uses submodules, therefore the repository needs to
be clonned with the –recursive option

```
git clone --recursive http://github.com/prophyle/prophyle
```

### Adjusting the PATH variable[¶](#adjusting-the-path-variable "Link to this heading")

The ProPhyle path can be prepended to the $PATH variable so that ProPhyle
can be executed in the same way as if it was installed using PIP

```
export PATH=$(pwd)/prophyle/prophyle:$PATH
```

### Installing dependencies[¶](#installing-dependencies "Link to this heading")

When run from the repository,
some of the ProPhyle dependencies, listed in requirements.txt, might
be missing in the system.
It is possible to install them either using BioConda

```
cat prophyle/requirements.txt | perl -pe 's/==.*//g' | xargs conda install
```

or using PIP

```
cat prophyle/requirements.txt | xargs pip install
```

### Navigation

* [index](genindex.html "General Index")
* [next](standard_db.html "4. Building a standard database") |
* [previous](requirements.html "2. Requirements") |
* [ProPhyle home](index.html) |
* [Documentation](contents.html) »
* 3. Installing ProPhyle

© Copyright 2015-2024, Karel Břinda, Kamil Salikhov, Simone Pignotti, Gregory Kucherov.
Created using [Sphinx](https://www.sphinx-doc.org/) 8.0.2.