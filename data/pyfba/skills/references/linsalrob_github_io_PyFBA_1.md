# [PyFBA 0.951 documentation](# )

![sampledoc](static/PyFBA.png)

* [PyFBA Documentation](api.html "Next document")
  →

* PyFBA

### Table Of Contents

* Welcome to PyFBA
  + [About PyFBA](#about-pyfba)
  + [Installing PyFBA](#installing-pyfba)
  + [Getting Started with PyFBA](#getting-started-with-pyfba)
  + [Explore the API](#explore-the-api)
  + [You can also find what you are looking for directly:](#you-can-also-find-what-you-are-looking-for-directly)

#### Next topic

[PyFBA Documentation](api.html "next chapter")

[Show page source](sources/index.txt)

### Quick search

Enter search terms or a module, class or function name.

# Welcome to PyFBA[¶](#welcome-to-pyfba "Permalink to this headline")

A python interface for Flux Balance Analysis

## About PyFBA[¶](#about-pyfba "Permalink to this headline")

PyFBA is a Python flux-balance-analysis package that allows you to build models from genomes, gapfill models, and run
flux-balance-analysis on that model. The aim of PyFBA is to provide an extensible, Python-based platform for your
FBA work.

PyFBA is being developed by Daniel Cuevas, Taylor O’Connell, and Rob Edwards in [Rob’s bioinformatics
group](http://edwards.sdsu.edu/research) at [San Diego State University](http://www.sdsu.edu) together with help from
Janaka Edirisinghe, Chris Henry, Ross Overbeek and others at [Argonne National Labs](http://www.theseed.org/).

## Installing PyFBA[¶](#installing-pyfba "Permalink to this headline")

To use PyFBA you need Python 2.7 or greater, and you need to install the GNU GLPK and a Python
wrapper for that program, [pyGLPK](https://github.com/bradfordboyle/pyglpk) available from github. See the [installation](installation.html) page for more details.

We also leverage the [Model SEED](https://github.com/ModelSEED/ModelSEEDDatabase.git) repository to get all the latest biochemistry tables. You should install that
somewhere on your machine, and set a ModelSEEDDatabase environment variable that points to that directory so we know
where you have installed it.

Our [installation](installation.html) page has detailed instructions on installing PyFBA and getting everything running.

## Getting Started with PyFBA[¶](#getting-started-with-pyfba "Permalink to this headline")

Once you have installed GLPK, PyGLPK, and PyFBA, you will most likely want to build a model from a genome, gap fill that
model, and test it for growth on different media. We have detailed instructions on [getting started](getting_started.html) to that walk you
through the step-by-step procedures that you need to use to run flux balance analysis on your own genome.

## Explore the API[¶](#explore-the-api "Permalink to this headline")

We have developed an extensive API that is centered around two concepts:
:   * Getting your FBA up and running easily
    * Allowing you to extend, update, and adapt the API to meet your requirements

To explore the API, check out the details:

* [PyFBA Documentation](api.html)
  + [The metabolism data](api.html#the-metabolism-data)
  + [The FBA modules](api.html#the-fba-modules)
  + [Filters for manipulating data](api.html#filters-for-manipulating-data)
  + [Gapfilling](api.html#gapfilling)
  + [The parsing modules](api.html#the-parsing-modules)

## You can also find what you are looking for directly:[¶](#you-can-also-find-what-you-are-looking-for-directly "Permalink to this headline")

* [Index](genindex.html)
* [Module Index](py-modindex.html)
* [Search Page](search.html)

* [PyFBA Documentation](api.html "Next document")
  →

* PyFBA

© 2015, Daniel Cuevas, Taylor O'Connell and Robert Edwards.
Created using [Sphinx](http://sphinx-doc.org/)
1.3.1
with the [better](http://github.com/irskep/sphinx-better-theme) theme.