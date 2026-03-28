[PyBEL
![Logo](../_static/PyBEL-square-100.png)](../index.html)

latest

Getting Started

* [Overview](../introduction/overview.html)
* [Installation](../introduction/installation.html)

Data Structure

* [Data Model](../reference/struct/datamodel.html)
* [Example Networks](../reference/struct/examples.html)
* [Filters](../reference/struct/filters.html)
* [Grouping](../reference/struct/grouping.html)
* [Operations](../reference/struct/operators.html)
* [Pipeline](../reference/struct/pipeline.html)
* [Query](../reference/struct/query.html)
* [Summary](../reference/struct/summary.html)

Mutations

* [Mutations](../reference/mutations/mutations.html)
* [Collapse](../reference/mutations/collapse.html)
* [Deletion](../reference/mutations/deletion.html)
* [Expansion](../reference/mutations/expansion.html)
* [Induction](../reference/mutations/induction.html)
* [Induction and Expansion](../reference/mutations/induction_expansion.html)
* [Inference](../reference/mutations/inference.html)
* [Metadata](../reference/mutations/metadata.html)

Conversion

* [Input and Output](../reference/io.html)

Database

* [Manager](../reference/database/manager.html)
* [Models](../reference/database/models.html)

Topic Guide

* [Cookbook](cookbook.html)
* Command Line Interface
  + [pybel](#pybel)
    - [compile](#pybel-compile)
    - [insert](#pybel-insert)
    - [machine](#pybel-machine)
    - [manage](#pybel-manage)
      * [drop](#pybel-manage-drop)
      * [edges](#pybel-manage-edges)
      * [examples](#pybel-manage-examples)
      * [namespaces](#pybel-manage-namespaces)
      * [networks](#pybel-manage-networks)
      * [nodes](#pybel-manage-nodes)
      * [summarize](#pybel-manage-summarize)
    - [neo](#pybel-neo)
    - [parse](#pybel-parse)
    - [serialize](#pybel-serialize)
    - [summarize](#pybel-summarize)
    - [upload](#pybel-upload)
    - [warnings](#pybel-warnings)

Reference

* [Constants](../reference/constants.html)
* [Parsers](../reference/parser.html)
* [Internal Domain Specific Language](../reference/dsl.html)
* [Logging Messages](../reference/logging.html)

Project

* [References](../meta/references.html)
* [Current Issues](../meta/postmortem.html)
* [Technology](../meta/technology.html)

[PyBEL](../index.html)

* »
* Command Line Interface
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/topics/cli.rst)

---

# Command Line Interface[](#command-line-interface "Permalink to this headline")

Note

The command line wrapper might not work on Windows. Use `python3 -m pybel` if it has issues.

PyBEL automatically installs the command `pybel`. This command can be used to easily compile BEL documents
and convert to other formats. See `pybel --help` for usage details. This command makes logs of all conversions
and warnings to the directory `~/.pybel/`.

## pybel[](#pybel "Permalink to this headline")

PyBEL CLI on /home/docs/checkouts/readthedocs.org/user\_builds/pybel/envs/latest/bin/python

```
pybel [OPTIONS] COMMAND [ARGS]...
```

Options

--version[](#cmdoption-pybel-version "Permalink to this definition")
:   Show the version and exit.

-c, --connection <connection>[](#cmdoption-pybel-c "Permalink to this definition")
:   Database connection string.

    Default
    :   sqlite:////home/docs/.data/pybel/pybel\_0.14.0\_cache.db

### compile[](#pybel-compile "Permalink to this headline")

Compile a BEL script to a graph.

```
pybel compile [OPTIONS] PATH
```

Options

--allow-naked-names[](#cmdoption-pybel-compile-allow-naked-names "Permalink to this definition")
:   Enable lenient parsing for naked names

--disallow-nested[](#cmdoption-pybel-compile-disallow-nested "Permalink to this definition")
:   Disable lenient parsing for nested statements

--disallow-unqualified-translocations[](#cmdoption-pybel-compile-disallow-unqualified-translocations "Permalink to this definition")
:   Disallow unqualified translocations

--no-identifier-validation[](#cmdoption-pybel-compile-no-identifier-validation "Permalink to this definition")
:   Turn off identifier validation

--no-citation-clearing[](#cmdoption-pybel-compile-no-citation-clearing "Permalink to this definition")
:   Turn off citation clearing

-r, --required-annotations <required\_annotations>[](#cmdoption-pybel-compile-r "Permalink to this definition")
:   Specify multiple required annotations

--upgrade-urls[](#cmdoption-pybel-compile-upgrade-urls "Permalink to this definition")

--skip-tqdm[](#cmdoption-pybel-compile-skip-tqdm "Permalink to this definition")

-v, --verbose[](#cmdoption-pybel-compile-v "Permalink to this definition")

Arguments

PATH[](#cmdoption-pybel-compile-arg-PATH "Permalink to this definition")
:   Required argument

### insert[](#pybel-insert "Permalink to this headline")

Insert a graph to the database.

```
pybel insert [OPTIONS] path
```

Arguments

path[](#cmdoption-pybel-insert-arg-path "Permalink to this definition")
:   Required argument

### machine[](#pybel-machine "Permalink to this headline")

Get content from the INDRA machine and upload to BEL Commons.

```
pybel machine [OPTIONS] [AGENTS]...
```

Options

--local[](#cmdoption-pybel-machine-local "Permalink to this definition")
:   Upload to local database.

--host <host>[](#cmdoption-pybel-machine-host "Permalink to this definition")
:   URL of BEL Commons.

Arguments

AGENTS[](#cmdoption-pybel-machine-arg-AGENTS "Permalink to this definition")
:   Optional argument(s)

### manage[](#pybel-manage "Permalink to this headline")

Manage the database.

```
pybel manage [OPTIONS] COMMAND [ARGS]...
```

#### drop[](#pybel-manage-drop "Permalink to this headline")

Drop the database.

```
pybel manage drop [OPTIONS]
```

Options

--yes[](#cmdoption-pybel-manage-drop-yes "Permalink to this definition")
:   Confirm the action without prompting.

#### edges[](#pybel-manage-edges "Permalink to this headline")

Manage edges.

```
pybel manage edges [OPTIONS] COMMAND [ARGS]...
```

##### ls[](#pybel-manage-edges-ls "Permalink to this headline")

List edges.

```
pybel manage edges ls [OPTIONS]
```

Options

--offset <offset>[](#cmdoption-pybel-manage-edges-ls-offset "Permalink to this definition")

--limit <limit>[](#cmdoption-pybel-manage-edges-ls-limit "Permalink to this definition")

#### examples[](#pybel-manage-examples "Permalink to this headline")

Load examples to the database.

```
pybel manage examples [OPTIONS]
```

Options

-v, --debug[](#cmdoption-pybel-manage-examples-v "Permalink to this definition")

#### namespaces[](#pybel-manage-namespaces "Permalink to this headline")

Manage namespaces.

```
pybel manage namespaces [OPTIONS] COMMAND [ARGS]...
```

##### drop[](#pybel-manage-namespaces-drop "Permalink to this headline")

Drop a namespace by URL.

```
pybel manage namespaces drop [OPTIONS] URL
```

Arguments

URL[](#cmdoption-pybel-manage-namespaces-drop-arg-URL "Permalink to this definition")
:   Required argument

##### insert[](#pybel-manage-namespaces-insert "Permalink to this headline")

Add a namespace by URL.

```
pybel manage namespaces insert [OPTIONS] URL
```

Arguments

URL[](#cmdoption-pybel-manage-namespaces-insert-arg-URL "Permalink to this definition")
:   Required argument

##### ls[](#pybel-manage-namespaces-ls "Permalink to this headline")

List cached namespaces.

```
pybel manage namespaces ls [OPTIONS]
```

Options

-u, --url <url>[](#cmdoption-pybel-manage-namespaces-ls-u "Permalink to this definition")
:   Specific resource URL to list

-i, --namespace-id <namespace\_id>[](#cmdoption-pybel-manage-namespaces-ls-i "Permalink to this definition")
:   Specific resource URL to list

#### networks[](#pybel-manage-networks "Permalink to this headline")

Manage networks.

```
pybel manage networks [OPTIONS] COMMAND [ARGS]...
```

##### drop[](#pybel-manage-networks-drop "Permalink to this headline")

Drop a network by its identifier or drop all networks.

```
pybel manage networks drop [OPTIONS]
```

Options

-n, --network-id <network\_id>[](#cmdoption-pybel-manage-networks-drop-n "Permalink to this definition")
:   Identifier of network to drop

-y, --yes[](#cmdoption-pybel-manage-networks-drop-y "Permalink to this definition")
:   Drop all networks without confirmation if no identifier is given

##### ls[](#pybel-manage-networks-ls "Permalink to this headline")

List network names, versions, and optionally, descriptions.

```
pybel manage networks ls [OPTIONS]
```

#### nodes[](#pybel-manage-nodes "Permalink to this headline")

Manage nodes.

```
pybel manage nodes [OPTIONS] COMMAND [ARGS]...
```

##### prune[](#pybel-manage-nodes-prune "Permalink to this headline")

Prune nodes not belonging to any edges.

```
pybel manage nodes prune [OPTIONS]
```

#### summarize[](#pybel-manage-summarize "Permalink to this headline")

Summarize the contents of the database.

```
pybel manage summarize [OPTIONS]
```

### neo[](#pybel-neo "Permalink to this headline")

Upload to neo4j.

```
pybel neo [OPTIONS] path
```

Options

--connection <connection>[](#cmdoption-pybel-neo-connection "Permalink to this definition")
:   Connection string for neo4j upload.

--password <password>[](#cmdoption-pybel-neo-password "Permalink to this definition")

Arguments

path[](#cmdoption-pybel-neo-arg-path "Permalink to this definition")
:   Required argument

### parse[](#pybel-parse "Permalink to this headline")

Parse a single BEL statement and pring JSON output.

```
pybel parse [OPTIONS] TEXT
```

Options

--pprint[](#cmdoption-pybel-parse-pprint "Permalink to this definition")

Arguments

TEXT[](#cmdoption-pybel-parse-arg-TEXT "Permalink to this definition")
:   Required argument

### serialize[](#pybel-serialize "Permalink to this headline")

Serialize a graph to various formats.

```
pybel serialize [OPTIONS] path
```

Options

--tsv <tsv>[](#cmdoption-pybel-serialize-tsv "Permalink to this definition")
:   Path to output a TSV file.

--edgelist <edgelist>[](#cmdoption-pybel-serialize-edgelist "Permalink to this definition")
:   Path to output a edgelist file.

--sif <sif>[](#cmdoption-pybel-serialize-sif "Permalink to this definition")
:   Path to output an SIF file.

--gsea <gsea>[](#cmdoption-pybel-serialize-gsea "Permalink to this definition")
:   Path to output a GRP file for gene set enrichment analysis.

--graphml <graphml>[](#cmdoption-pybel-serialize-graphml "Permalink to this definition")
:   Path to output a GraphML file. Use .graphml for Cytoscape.

--nodelink <nodelink>[](#cmdoption-pybel-serialize-nodelink "Permalink to this definition")
:   Path to output a node-link JSON file.

--bel <bel>[](#cmdoption-pybel-serialize-bel "Permalink to this definition")
:   Output canonical BEL.

Arguments

path[](#cmdoption-pybel-serialize-arg-path "Permalink to this definition")
:   Required argument

### summarize[](#pybel-summarize "Permalink to this headline")

Summarize a graph.

```
pybel summarize [OPTIONS] path
```

Arguments

path[](#cmdoption-pybel-summarize-arg-path "Permalink to this definition")
:   Required argument

### upload[](#pybel-upload "Permalink to this headline")

Upload a graph to BEL Commons.

```
pybel upload [OPTIONS] path
```

Options

--host <host>[](#cmdoption-pybel-upload-host "Permalink to this definition")
:   URL of BEL Commons.

--user <user>[](#cmdoption-pybel-upload-user "Permalink to this definition")
:   User for BEL Commons

    Default
    :   <function \_get\_user at 0x7f425d9c7160>

--password <password>[](#cmdoption-pybel-upload-password "Permalink to this definition")
:   Password for BEL Commons

    Default
    :   <function \_get\_password at 0x7f425d9c71f0>

Arguments

path[](#cmdoption-pybel-upload-arg-path "Permalink to this definition")
:   Required argument

### warnings[](#pybel-warnings "Permalink to this headline")

List warnings from a graph.

```
pybel warnings [OPTIONS] path
```

Arguments

path[](#cmdoption-pybel-warnings-arg-path "Permalink to this definition")
:   Required argument

[Previous](cookbook.html "Cookbook")
[Next](../reference/constants.html "Constants")

---

© Copyright 2016-2022, Charles Tapley Hoyt.
Revision `ed66f013`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).