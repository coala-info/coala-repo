[PyBEL
![Logo](../../_static/PyBEL-square-100.png)](../../index.html)

latest

Getting Started

* [Overview](../../introduction/overview.html)
* [Installation](../../introduction/installation.html)

Data Structure

* [Data Model](datamodel.html)
* [Example Networks](examples.html)
* [Filters](filters.html)
* [Grouping](grouping.html)
* Operations
* [Pipeline](pipeline.html)
* [Query](query.html)
* [Summary](summary.html)

Mutations

* [Mutations](../mutations/mutations.html)
* [Collapse](../mutations/collapse.html)
* [Deletion](../mutations/deletion.html)
* [Expansion](../mutations/expansion.html)
* [Induction](../mutations/induction.html)
* [Induction and Expansion](../mutations/induction_expansion.html)
* [Inference](../mutations/inference.html)
* [Metadata](../mutations/metadata.html)

Conversion

* [Input and Output](../io.html)

Database

* [Manager](../database/manager.html)
* [Models](../database/models.html)

Topic Guide

* [Cookbook](../../topics/cookbook.html)
* [Command Line Interface](../../topics/cli.html)

Reference

* [Constants](../constants.html)
* [Parsers](../parser.html)
* [Internal Domain Specific Language](../dsl.html)
* [Logging Messages](../logging.html)

Project

* [References](../../meta/references.html)
* [Current Issues](../../meta/postmortem.html)
* [Technology](../../meta/technology.html)

[PyBEL](../../index.html)

* »
* Operations
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/struct/operators.rst)

---

# Operations[](#operations "Permalink to this headline")

This page outlines operations that can be done to BEL graphs.

pybel.struct.left\_full\_join(*g*, *h*)[[source]](../../_modules/pybel/struct/operations.html#left_full_join)[](#pybel.struct.left_full_join "Permalink to this definition")
:   Add all nodes and edges from `h` to `g`, in-place for `g`.

    Parameters
    :   * **g** ([*pybel.BELGraph*](datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph
        * **h** ([*pybel.BELGraph*](datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph

    Example usage:

    ```
    >>> import pybel
    >>> g = pybel.from_bel_script('...')
    >>> h = pybel.from_bel_script('...')
    >>> left_full_join(g, h)
    ```

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

pybel.struct.left\_outer\_join(*g*, *h*)[[source]](../../_modules/pybel/struct/operations.html#left_outer_join)[](#pybel.struct.left_outer_join "Permalink to this definition")
:   Only add components from the `h` that are touching `g`.

    Algorithm:

    1. Identify all weakly connected components in `h`
    2. Add those that have an intersection with the `g`

    Parameters
    :   * **g** ([*BELGraph*](datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph
        * **h** ([*BELGraph*](datamodel.html#pybel.BELGraph "pybel.BELGraph")) – A BEL graph

    Example usage:

    ```
    >>> import pybel
    >>> g = pybel.from_bel_script('...')
    >>> h = pybel.from_bel_script('...')
    >>> left_outer_join(g, h)
    ```

    Return type
    :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

pybel.struct.union(*graphs*, *use\_tqdm=False*)[[source]](../../_modules/pybel/struct/operations.html#union)[](#pybel.struct.union "Permalink to this definition")
:   Take the union over a collection of graphs into a new graph.

    Assumes iterator is longer than 2, but not infinite.

    Parameters
    :   * **graphs** (*iter**[*[*BELGraph*](datamodel.html#pybel.BELGraph "pybel.BELGraph")*]*) – An iterator over BEL graphs. Can’t be infinite.
        * **use\_tqdm** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – Should a progress bar be displayed?

    Returns
    :   A merged graph

    Return type
    :   [BELGraph](datamodel.html#pybel.BELGraph "pybel.BELGraph")

    Example usage:

    ```
    >>> import pybel
    >>> g = pybel.from_bel_script('...')
    >>> h = pybel.from_bel_script('...')
    >>> k = pybel.from_bel_script('...')
    >>> merged = union([g, h, k])
    ```

[Previous](grouping.html "Grouping")
[Next](pipeline.html "Pipeline")

---

© Copyright 2016-2022, Charles Tapley Hoyt.
Revision `ed66f013`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).