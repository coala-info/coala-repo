[ ]
[ ]

[Skip to content](#v-pipe-integration)

[![logo](../../assets/logo.svg)](../.. "sr2silo")

sr2silo

V-Pipe Integration

Initializing search

[sr2silo](https://github.com/cbg-ethz/sr2silo "Go to repository")

* [Home](../..)
* [Usage](../../usage/configuration/)
* [API Reference](../loculus/)
* [Contributing](../../contributing/)

[![logo](../../assets/logo.svg)](../.. "sr2silo")
sr2silo

[sr2silo](https://github.com/cbg-ethz/sr2silo "Go to repository")

* [Home](../..)
* [ ]

  Usage

  Usage
  + [Configuration](../../usage/configuration/)
  + [Multi-Organism Support](../../usage/organisms/)
  + [Deployment](../../usage/deployment/)
  + [Resource Requirements](../../usage/resource_requirements/)
* [x]

  API Reference

  API Reference
  + [Loculus Integration](../loculus/)
  + [Processing](../process/)
  + [Data Schemas](../schema/)
  + [ ]

    V-Pipe Integration

    [V-Pipe Integration](./)

    Table of contents
    - [Sample](#sample)
    - [Sample](#sr2silo.vpipe.Sample)

      * [enrich\_metadata](#sr2silo.vpipe.Sample.enrich_metadata)
      * [get\_metadata](#sr2silo.vpipe.Sample.get_metadata)
      * [set\_metadata](#sr2silo.vpipe.Sample.set_metadata)
* [ ]

  Contributing

  Contributing
  + [Overview](../../contributing/)
  + [Branching Strategy](../../contributing/branching-strategy/)

# V-Pipe Integration

Utilities for working with V-Pipe output and file naming conventions.

## Sample

## `sr2silo.vpipe.Sample`

A sample object for V-Pipe.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `sample_id` | `str` | The sample ID. | *required* |
| `organism` | `str` | The organism identifier (e.g., 'covid', 'rsva'). Optional, defaults to 'covid' for backward compatibility. | `'covid'` |

### `enrich_metadata(timeline)`

Enrich the sample metadata with additional information.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `timeline` | `Path` | The path to the timeline file. | *required* |

### `get_metadata()`

Get the metadata for the sample.

### `set_metadata()`

Get the metadata for the sample.

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)