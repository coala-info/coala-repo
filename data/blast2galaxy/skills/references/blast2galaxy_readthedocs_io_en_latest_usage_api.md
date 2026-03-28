[ ]
[ ]

[Skip to content](#using-the-python-api)

blast2galaxy Documentation

API Usage

[blast2galaxy](https://github.com/IPK-BIT/blast2galaxy "Go to repository")

blast2galaxy Documentation

[blast2galaxy](https://github.com/IPK-BIT/blast2galaxy "Go to repository")

* [Introduction](..)
* [Installation](../installation/)
* [Configuration](../configuration/)
* [x]

  Usage

  Usage
  + [CLI Usage](../usage_cli/)
  + [ ]

    API Usage

    [API Usage](./)

    Table of contents
    - [Using the Python API](#using-the-python-api)

      * [Exceptions](#exceptions)

        + [Blast2galaxyConfigFileError](#blast2galaxy.errors.Blast2galaxyConfigFileError)
        + [Blast2galaxyError](#blast2galaxy.errors.Blast2galaxyError)
* [Tutorial](../tutorial/)
* [CLI Reference](../cli/)
* [API Reference](../api/)

Table of contents

* [Using the Python API](#using-the-python-api)

  + [Exceptions](#exceptions)

    - [Blast2galaxyConfigFileError](#blast2galaxy.errors.Blast2galaxyConfigFileError)
    - [Blast2galaxyError](#blast2galaxy.errors.Blast2galaxyError)

# API Usage

## Using the Python API

After installation of blast2galaxy the Python API can be imported into your Python application via `import blast2galaxy`.

Note

If using the API the BLAST+ or DIAMOND results are not written to a file but instead are returned from the called API function.

You can then perform BLAST or DIAMOND requests using the configured `default` profile like so:

```
result = blast2galaxy.blastn(
    query = 'dna_sequence.fasta',
    db = 'database_id',
    outfmt = '6'
)
```

A specific profile can be used like so:

```
result = blast2galaxy.blastp(
    profile = 'blastp',
    query = 'protein_sequence.fasta',
    db = 'database_id',
    outfmt = '6'
)
```

Instead of a filename it is also possible to provide the query as a Python string. This is helpful in the situation of an integration with other tools / databases where writing intermediate files for query sequences is not desired.

```
protein_seq = """
>sp|P62805|H4_HUMAN Histone H4 OS=Homo sapiens OX=9606 GN=H4C1 PE=1 SV=2
MSGRGKGGKGLGKGGAKRHRKVLRDNIQGITKPAIRRLARRGGVKRISGLIYEETRGVLK
VFLENVIRDAVTYTEHAKRKTVTAMDVVYALKRQGRTLYGFGG
"""

result = blast2galaxy.blastp(
    profile = 'blastp',
    query_str = protein_seq,
    db = 'database_id',
    outfmt = '6'
)
```

Tip

You can find all possible arguments and parameters in the [API reference](../api/).

### Exceptions

blast2galaxy throws the following exceptions when used in API mode:

#### blast2galaxy.errors.Blast2galaxyConfigFileError

Bases: `[Blast2galaxyError](#blast2galaxy.errors.Blast2galaxyError "blast2galaxy.errors.Blast2galaxyError")`

Raised for an error with the configuration of blast2galaxy

#### blast2galaxy.errors.Blast2galaxyError

Bases: `Exception`

Base class for all exceptions raised by blast2galaxy, used for general errors

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)