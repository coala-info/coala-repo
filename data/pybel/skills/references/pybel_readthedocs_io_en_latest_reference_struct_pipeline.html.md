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
* [Operations](operators.html)
* Pipeline
  + [Transformation Decorators](#module-pybel.struct.pipeline.decorators)
  + [Exceptions](#module-pybel.struct.pipeline.exc)
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
* Pipeline
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/struct/pipeline.rst)

---

# Pipeline[](#pipeline "Permalink to this headline")

*class* pybel.Pipeline(*protocol=None*)[[source]](../../_modules/pybel/struct/pipeline/pipeline.html#Pipeline)[](#pybel.Pipeline "Permalink to this definition")
:   Build and runs analytical pipelines on BEL graphs.

    Example usage:

    ```
    >>> from pybel import BELGraph
    >>> from pybel.struct.pipeline import Pipeline
    >>> from pybel.struct.mutation import enrich_protein_and_rna_origins, prune_protein_rna_origins
    >>> graph = BELGraph()
    >>> example = Pipeline()
    >>> example.append(enrich_protein_and_rna_origins)
    >>> example.append(prune_protein_rna_origins)
    >>> result = example.run(graph)
    ```

    Initialize the pipeline with an optional pre-defined protocol.

    Parameters
    :   **protocol** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`Dict`](https://docs.python.org/3/library/typing.html#typing.Dict "(in Python v3.10)")]]) – An iterable of dictionaries describing how to transform a network

    *static* from\_functions(*functions*)[[source]](../../_modules/pybel/struct/pipeline/pipeline.html#Pipeline.from_functions)[](#pybel.Pipeline.from_functions "Permalink to this definition")
    :   Build a pipeline from a list of functions.

        Parameters
        :   **functions** (*iter**[**(**(*[*pybel.BELGraph*](datamodel.html#pybel.BELGraph "pybel.BELGraph")*)* *-> pybel.BELGraph**) or* *(**(*[*pybel.BELGraph*](datamodel.html#pybel.BELGraph "pybel.BELGraph")*)* *-> None**) or* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")*]*) – A list of functions or names of functions

        Example with function:

        ```
        >>> from pybel.struct.pipeline import Pipeline
        >>> from pybel.struct.mutation import remove_associations
        >>> pipeline = Pipeline.from_functions([remove_associations])
        ```

        Equivalent example with function names:

        ```
        >>> from pybel.struct.pipeline import Pipeline
        >>> pipeline = Pipeline.from_functions(['remove_associations'])
        ```

        Lookup by name is possible for built in functions, and those that have been registered correctly using one of
        the four decorators:

        1. `pybel.struct.pipeline.transformation()`,
        2. `pybel.struct.pipeline.in_place_transformation()`,
        3. `pybel.struct.pipeline.uni_transformation()`,
        4. `pybel.struct.pipeline.uni_in_place_transformation()`,

        Return type
        :   [`Pipeline`](#pybel.Pipeline "pybel.struct.pipeline.pipeline.Pipeline")

    append(*name*, *\*args*, *\*\*kwargs*)[[source]](../../_modules/pybel/struct/pipeline/pipeline.html#Pipeline.append)[](#pybel.Pipeline.append "Permalink to this definition")
    :   Add a function (either as a reference, or by name) and arguments to the pipeline.

        Parameters
        :   * **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)") *or* *(**pybel.BELGraph -> pybel.BELGraph**)*) – The name of the function
            * **args** – The positional arguments to call in the function
            * **kwargs** – The keyword arguments to call in the function

        Return type
        :   [`Pipeline`](#pybel.Pipeline "pybel.struct.pipeline.pipeline.Pipeline")

        Returns
        :   This pipeline for fluid query building

        Raises
        :   [**MissingPipelineFunctionError**](#pybel.struct.pipeline.exc.MissingPipelineFunctionError "pybel.struct.pipeline.exc.MissingPipelineFunctionError") – If the function is not registered

    extend(*protocol*)[[source]](../../_modules/pybel/struct/pipeline/pipeline.html#Pipeline.extend)[](#pybel.Pipeline.extend "Permalink to this definition")
    :   Add another pipeline to the end of the current pipeline.

        Parameters
        :   **protocol** ([`Union`](https://docs.python.org/3/library/typing.html#typing.Union "(in Python v3.10)")[[`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`Dict`](https://docs.python.org/3/library/typing.html#typing.Dict "(in Python v3.10)")], [`Pipeline`](#pybel.Pipeline "pybel.struct.pipeline.pipeline.Pipeline")]) – An iterable of dictionaries (or another Pipeline)

        Return type
        :   [`Pipeline`](#pybel.Pipeline "pybel.struct.pipeline.pipeline.Pipeline")

        Returns
        :   This pipeline for fluid query building

        Example:
        >>> p1 = Pipeline.from\_functions([‘enrich\_protein\_and\_rna\_origins’])
        >>> p2 = Pipeline.from\_functions([‘remove\_pathologies’])
        >>> p1.extend(p2)

    run(*graph*, *universe=None*)[[source]](../../_modules/pybel/struct/pipeline/pipeline.html#Pipeline.run)[](#pybel.Pipeline.run "Permalink to this definition")
    :   Run the contained protocol on a seed graph.

        Parameters
        :   * **graph** ([*pybel.BELGraph*](datamodel.html#pybel.BELGraph "pybel.BELGraph")) – The seed BEL graph
            * **universe** ([*pybel.BELGraph*](datamodel.html#pybel.BELGraph "pybel.BELGraph")) – Allows just-in-time setting of the universe in case it wasn’t set before.
              Defaults to the given network.

        Returns
        :   The new graph is returned if not applied in-place

        Return type
        :   [pybel.BELGraph](datamodel.html#pybel.BELGraph "pybel.BELGraph")

    to\_json()[[source]](../../_modules/pybel/struct/pipeline/pipeline.html#Pipeline.to_json)[](#pybel.Pipeline.to_json "Permalink to this definition")
    :   Return this pipeline as a JSON list.

        Return type
        :   [`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")

    dumps(*\*\*kwargs*)[[source]](../../_modules/pybel/struct/pipeline/pipeline.html#Pipeline.dumps)[](#pybel.Pipeline.dumps "Permalink to this definition")
    :   Dump this pipeline as a JSON string.

        Return type
        :   [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")

    dump(*file*, *\*\*kwargs*)[[source]](../../_modules/pybel/struct/pipeline/pipeline.html#Pipeline.dump)[](#pybel.Pipeline.dump "Permalink to this definition")
    :   Dump this protocol to a file in JSON.

        Return type
        :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

    *static* from\_json(*data*)[[source]](../../_modules/pybel/struct/pipeline/pipeline.html#Pipeline.from_json)[](#pybel.Pipeline.from_json "Permalink to this definition")
    :   Build a pipeline from a JSON list.

        Return type
        :   [`Pipeline`](#pybel.Pipeline "pybel.struct.pipeline.pipeline.Pipeline")

    *static* load(*file*)[[source]](../../_modules/pybel/struct/pipeline/pipeline.html#Pipeline.load)[](#pybel.Pipeline.load "Permalink to this definition")
    :   Load a protocol from JSON contained in file.

        Return type
        :   [`Pipeline`](#pybel.Pipeline "pybel.struct.pipeline.pipeline.Pipeline")

        Returns
        :   The pipeline represented by the JSON in the file

        Raises
        :   [**MissingPipelineFunctionError**](#pybel.struct.pipeline.exc.MissingPipelineFunctionError "pybel.struct.pipeline.exc.MissingPipelineFunctionError") – If any functions are not registered

    *static* loads(*s*)[[source]](../../_modules/pybel/struct/pipeline/pipeline.html#Pipeline.loads)[](#pybel.Pipeline.loads "Permalink to this definition")
    :   Load a protocol from a JSON string.

        Parameters
        :   **s** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – A JSON string

        Return type
        :   [`Pipeline`](#pybel.Pipeline "pybel.struct.pipeline.pipeline.Pipeline")

        Returns
        :   The pipeline represented by the JSON in the file

        Raises
        :   [**MissingPipelineFunctionError**](#pybel.struct.pipeline.exc.MissingPipelineFunctionError "pybel.struct.pipeline.exc.MissingPipelineFunctionError") – If any functions are not registered

    *static* union(*pipelines*)[[source]](../../_modules/pybel/struct/pipeline/pipeline.html#Pipeline.union)[](#pybel.Pipeline.union "Permalink to this definition")
    :   Take the union of multiple pipelines.

        Parameters
        :   **pipelines** ([`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`Pipeline`](#pybel.Pipeline "pybel.struct.pipeline.pipeline.Pipeline")]) – A list of pipelines

        Return type
        :   [`Pipeline`](#pybel.Pipeline "pybel.struct.pipeline.pipeline.Pipeline")

        Returns
        :   The union of the results from multiple pipelines

    *static* intersection(*pipelines*)[[source]](../../_modules/pybel/struct/pipeline/pipeline.html#Pipeline.intersection)[](#pybel.Pipeline.intersection "Permalink to this definition")
    :   Take the intersection of the results from multiple pipelines.

        Parameters
        :   **pipelines** ([`Iterable`](https://docs.python.org/3/library/typing.html#typing.Iterable "(in Python v3.10)")[[`Pipeline`](#pybel.Pipeline "pybel.struct.pipeline.pipeline.Pipeline")]) – A list of pipelines

        Return type
        :   [`Pipeline`](#pybel.Pipeline "pybel.struct.pipeline.pipeline.Pipeline")

        Returns
        :   The intersection of results from multiple pipelines

## Transformation Decorators[](#module-pybel.struct.pipeline.decorators "Permalink to this headline")

This module contains the functions for decorating transformation functions.

A transformation function takes in a [`pybel.BELGraph`](datamodel.html#pybel.BELGraph "pybel.BELGraph") and either returns None (in-place) or a new
[`pybel.BELGraph`](datamodel.html#pybel.BELGraph "pybel.BELGraph") (out-of-place).

pybel.struct.pipeline.decorators.in\_place\_transformation(*func*)[](#pybel.struct.pipeline.decorators.in_place_transformation "Permalink to this definition")
:   A decorator for functions that modify BEL graphs in-place

pybel.struct.pipeline.decorators.uni\_in\_place\_transformation(*func*)[](#pybel.struct.pipeline.decorators.uni_in_place_transformation "Permalink to this definition")
:   A decorator for functions that require a “universe” graph and modify BEL graphs in-place

pybel.struct.pipeline.decorators.uni\_transformation(*func*)[](#pybel.struct.pipeline.decorators.uni_transformation "Permalink to this definition")
:   A decorator for functions that require a “universe” graph and create new BEL graphs from old BEL graphs

pybel.struct.pipeline.decorators.transformation(*func*)[](#pybel.struct.pipeline.decorators.transformation "Permalink to this definition")
:   A decorator for functions that create new BEL graphs from old BEL graphs

pybel.struct.pipeline.decorators.get\_transformation(*name*)[[source]](../../_modules/pybel/struct/pipeline/decorators.html#get_transformation)[](#pybel.struct.pipeline.decorators.get_transformation "Permalink to this definition")
:   Get a transformation function and error if its name is not registered.

    Parameters
    :   **name** ([`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")) – The name of a function to look up

    Returns
    :   A transformation function

    Raises
    :   [**MissingPipelineFunctionError**](#pybel.struct.pipeline.exc.MissingPipelineFunctionError "pybel.struct.pipeline.exc.MissingPipelineFunctionError") – If the given function name is not registered

## Exceptions[](#module-pybel.struct.pipeline.exc "Permalink to this headline")

Exceptions for the `pybel.struct.pipeline` module.

*exception* pybel.struct.pipeline.exc.MissingPipelineFunctionError[[source]](../../_modules/pybel/struct/pipeline/exc.html#MissingPipelineFunctionError)[](#pybel.struct.pipeline.exc.MissingPipelineFunctionError "Permalink to this definition")
:   Raised when trying to run the pipeline with a function that isn’t registered.

*exception* pybel.struct.pipeline.exc.MetaValueError[[source]](../../_modules/pybel/struct/pipeline/exc.html#MetaValueError)[](#pybel.struct.pipeline.exc.MetaValueError "Permalink to this definition")
:   Raised when getting an invalid meta value.

*exception* pybel.struct.pipeline.exc.MissingUniverseError[[source]](../../_modules/pybel/struct/pipeline/exc.html#MissingUniverseError)[](#pybel.struct.pipeline.exc.MissingUniverseError "Permalink to this definition")
:   Raised when running a universe function without a universe being present.

*exception* pybel.struct.pipeline.exc.DeprecationMappingError[[source]](../../_modules/pybel/struct/pipeline/exc.html#DeprecationMappingError)[](#pybel.struct.pipeline.exc.DeprecationMappingError "Permalink to this definition")
:   Raised when applying the deprecation function annotation and the given name already is being used.

*exception* pybel.struct.pipeline.exc.PipelineNameError[[source]](../../_modules/pybel/struct/pipeline/exc.html#PipelineNameError)[](#pybel.struct.pipeline.exc.PipelineNameError "Permalink to this definition")
:   Raised when a second function tries to use the same name.

[Previous](operators.html "Operations")
[Next](query.html "Query")

---

© Copyright 2016-2022, Charles Tapley Hoyt.
Revision `ed66f013`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](http