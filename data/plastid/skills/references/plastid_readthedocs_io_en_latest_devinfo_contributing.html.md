[plastid](../index.html)

latest

Getting started

* [Getting started](../quickstart.html)
* [Tour](../tour.html)
* [Installation](../installation.html)
* [Demo dataset](../test_dataset.html)
* [List of command-line scripts](../scriptlist.html)

User manual

* [Tutorials](../examples.html)
* [Module documentation](../generated/plastid.html)
* [Frequently asked questions](../FAQ.html)
* [Glossary of terms](../glossary.html)
* [References](../zreferences.html)

Developer info

* Contributing
  + [Workflow](#workflow)
    - [Download the test dataset](#download-the-test-dataset)
    - [Start with a ticket](#start-with-a-ticket)
    - [Create a fork](#create-a-fork)
    - [Test](#test)
    - [Document](#document)
    - [Submit](#submit)
  + [Document formatting](#document-formatting)
    - [Docstring & module documenation](#docstring-module-documenation)
* [Entrypoints](entrypoints.html)

Other information

* [Citing `plastid`](../citing.html)
* [License](../license.html)
* [Change log](../CHANGES.html)
* [Related resources](../related.html)
* [Contact](../contact.html)

[plastid](../index.html)

* »
* Contributing
* [Edit on GitHub](https://github.com/joshuagryphon/plastid/blob/master/docs/source/devinfo/contributing.rst)

---

# Contributing[¶](#contributing "Permalink to this headline")

We welcome contributions! But we are new at this, so please be patient. Right
now, we (try to) follow these conventions:

## Workflow[¶](#workflow "Permalink to this headline")

### Download the test dataset[¶](#download-the-test-dataset "Permalink to this headline")

Get the [test dataset](https://www.dropbox.com/s/np3wlfvp6gx8tb8/2022-05-04.plastid-test-data.tar.bz2?dl=0) and unpack it into `plastid/test/`. The archive will
create a folder called data and you’ll be good to go.

### Start with a ticket[¶](#start-with-a-ticket "Permalink to this headline")

Before submitting a patch, please open a ticket. This will allow public
discussion of the best way to solve an issue or design a feature, and allows us
to keep logical records of everything.

### Create a fork[¶](#create-a-fork "Permalink to this headline")

Rather than push changes to our main repository, create a fork, and, if appropriate,
a topic branch. Build & test your changes there, merge into the `develop` branch of
your fork, then submit a pull request.

### Test[¶](#test "Permalink to this headline")

We advocate test-driven development. Feature additions will not be accepted without
companion tests, and, where appropriate, test datasets. Before submitting a change,
please:

1. Write new tests. Consider using the existing test dataset.
2. Run your new tests, make sure they pass
3. Run the existing tests.

   > * If they pass, great!
   > * If they fail because of an intentional design change in an object’s behavior,
   >   make corresponding changes to the test dataset and discuss this heavily
   >   in the update- this will probably require a version bump.
   > * If they fail otherwise, fix your submission so the old tests pass.

### Document[¶](#document "Permalink to this headline")

1. Document everything heavily, updating module & object docstrings where
   appropriate, as well as any [Tutorials](../examples.html) that might be affected
   by the change or addition.
2. If you use technical terms, please check if a synonym of your term is already defined
   in the [glossary](../glossary.html), and then use that. If no synonym is present, please
   add the [glossary](../glossary.html), and refer to it using the `:term:` directive.

### Submit[¶](#submit "Permalink to this headline")

Send a pull request referring to the ticket above, along with a description
of your patch. We’ll merge it into `develop`, and add you to the list
of contributors.

## Document formatting[¶](#document-formatting "Permalink to this headline")

Code should be formatted as described in [**PEP 8**](https://peps.python.org/pep-0008/), noting especially to use
four spaces for indentation.

### Docstring & module documenation[¶](#docstring-module-documenation "Permalink to this headline")

Docstrings & documentation should be formatted in [reStructuredText](http://docutils.sourceforge.net/rst.html) using
the most human-readable raw form possible. This means:

> * Format docstrings for [numpydoc](https://github.com/numpy/numpy/blob/master/doc/HOWTO_DOCUMENT.rst.txt), as described in the
>   [numpy documentation guide](https://github.com/numpy/numpy/blob/master/doc/HOWTO_DOCUMENT.rst.txt)
> * Follow [**PEP 257**](https://peps.python.org/pep-0257/) for docstring style
> * Refer to classes defined in [`plastid`](../generated/plastid.html#module-plastid "plastid") in docstrings using the shortcut |ClassName|
>   rather than as :py:class:`package.module.ClassName`, because the shortcuts are
>   easier to read.
> * Similarly, refer to command-line scripts as |modname|, where modname
>   is the name of the module, excluding the extension. e.g. |metagene| for
>   :mod:`plastid.bin.metagene`.
> * Decorate any function that you don’t want to be put in the online
>   documentation with the [`skipdoc()`](../generated/plastid.util.services.decorators.html#plastid.util.services.decorators.skipdoc "plastid.util.services.decorators.skipdoc")
>   decorator
> * Module docstrings for command-line scripts should have a section called
>   *Output files*, and, where appropriate, examples of how to call the script.

[Previous](../zreferences.html "References")
[Next](entrypoints.html "Extending plastid")

---

© Copyright 2014-2022, Joshua G. Dunn.
Revision `d97f239d`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).