[ ]
[ ]

[Skip to content](#multi-organism-support)

[![logo](../../assets/logo.svg)](../.. "sr2silo")

sr2silo

Multi-Organism Support

Initializing search

[sr2silo](https://github.com/cbg-ethz/sr2silo "Go to repository")

* [Home](../..)
* [Usage](../configuration/)
* [API Reference](../../api/loculus/)
* [Contributing](../../contributing/)

[![logo](../../assets/logo.svg)](../.. "sr2silo")
sr2silo

[sr2silo](https://github.com/cbg-ethz/sr2silo "Go to repository")

* [Home](../..)
* [x]

  Usage

  Usage
  + [Configuration](../configuration/)
  + [ ]

    Multi-Organism Support

    [Multi-Organism Support](./)

    Table of contents
    - [Supported Organisms](#supported-organisms)
    - [Reference Resolution](#reference-resolution)
    - [Usage](#usage)
    - [Adding New Organisms](#adding-new-organisms)
    - [Workflow Integration](#workflow-integration)
    - [Troubleshooting](#troubleshooting)
  + [Deployment](../deployment/)
  + [Resource Requirements](../resource_requirements/)
* [ ]

  API Reference

  API Reference
  + [Loculus Integration](../../api/loculus/)
  + [Processing](../../api/process/)
  + [Data Schemas](../../api/schema/)
  + [V-Pipe Integration](../../api/vpipe/)
* [ ]

  Contributing

  Contributing
  + [Overview](../../contributing/)
  + [Branching Strategy](../../contributing/branching-strategy/)

# Multi-Organism Support

sr2silo supports processing samples from multiple organisms with organism-specific reference sequences.

## Supported Organisms

| Organism | Identifier | Description |
| --- | --- | --- |
| COVID-19 | `covid` | SARS-CoV-2 / Severe acute respiratory syndrome coronavirus 2 |
| RSV-A | `rsva` | Respiratory Syncytial Virus A |

## Reference Resolution

sr2silo resolves reference sequences in the following priority order:

1. **Local References** (fastest): `resources/references/{organism}/`
2. **LAPIS Instance**: Fetched from specified `--lapis-url` if available
3. **Fallback**: Local references as final fallback if LAPIS fetch fails

This allows for both static local references and dynamic references from a LAPIS instance.

## Usage

For detailed usage, see:

```
sr2silo process-from-vpipe --help
```

The `--organism` parameter specifies which organism to process. Can also be set via `ORGANISM` environment variable (CLI argument takes precedence).

## Adding New Organisms

To add support for a new organism:

1. **Add reference files** to `resources/references/{organism_id}/`:
2. `nuc_ref.fasta` - Nucleotide reference sequence(s)
3. `aa_ref.fasta` - Amino acid reference sequences for gene annotations
4. **Use GenBank parser** (if starting from GenBank format):

   ```
   python scripts/extract_gbk_references.py \
       reference.gbk \
       --nuc-output resources/references/{organism_id}/nuc_ref.fasta \
       --aa-output resources/references/{organism_id}/aa_ref.fasta
   ```
5. **Update configuration** (optional):
6. Update workflow `config.yaml` with your new organism ID
7. Update documentation with organism details
8. **Test** (optional):
9. Add test fixtures in `tests/conftest.py`
10. Add parameterized tests in `tests/test_main.py`

## Workflow Integration

Specify organism in `workflow/config.yaml`:

```
ORGANISM: "covid"  # or "rsva"
```

## Troubleshooting

**Reference files not found:**
- Verify files exist: `ls resources/references/{organism}/`
- Check organism identifier spelling
- Use `--lapis-url` to fetch from LAPIS
- Generate from GenBank: `python scripts/extract_gbk_references.py --help`

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)