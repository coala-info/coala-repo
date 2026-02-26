# shiptv CWL Generation Report

## shiptv

### Tool Description
create an HTML tree visualization with optional metadata highlighting

### Metadata
- **Docker Image**: quay.io/biocontainers/shiptv:0.4.1--pyh5e36f6f_0
- **Homepage**: https://github.com/peterk87/shiptv
- **Package**: https://anaconda.org/channels/bioconda/packages/shiptv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/shiptv/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/peterk87/shiptv
- **Stars**: N/A
### Original Help Text
```text
Usage: shiptv [OPTIONS]

  shiptv - create an HTML tree visualization with optional metadata
  highlighting

  Typical usage:

  $ shiptv --newick tree.nwk --metadata tree-metadata.tsv --output-html
  tree.html

  Note: The metadata for reference genomes can be extracted from the
  specified Genbank file.

Options:
  -n, --newick PATH               Phylogenetic tree Newick file  [required]
  -o, --output-html PATH          Output HTML tree path  [default: shiptv-
                                  tree.html]

  -N, --output-newick PATH        Output Newick file
  -r, --ref-genomes-genbank PATH  Reference genome sequences Genbank file
  -M, --output-metadata-table PATH
                                  Output metadata table path
  --leaflist PATH                 Optional leaf names to select from
                                  phylogenetic tree for pruned tree
                                  visualization. One leaf name per line.

  --genbank-metadata-fields PATH  Optional fields to extract from Genbank
                                  source metadata. One field per line.

  -m, --metadata PATH             Optional tab-delimited metadata for user
                                  samples to join with metadata derived from
                                  reference genome sequences Genbank file.
                                  Sample IDs must be in the first column.

  --metadata-fields-in-order PATH
                                  Optional list of fields in order to output
                                  in metadata table and HTML tree
                                  visualization. One field per line.

  --fix-metadata / --no-fix-metadata
                                  Try to automatically fix metadata from
                                  reference Genbank file.  [default: True]

  -C, --collapse-support FLOAT    Collapse internal branches below specified
                                  bootstrap support value (default -1 for no
                                  collapsing)  [default: -1.0]

  --highlight-user-samples / --no-highlight-user-samples
                                  Highlight user samples with metadata field
                                  in tree.  [default: False]

  --outgroup TEXT                 Tree outgroup taxa
  --midpoint-root / --no-midpoint-root
                                  Set midpoint root  [default: False]
  --verbose / --no-verbose        Verbose logs  [default: False]
  --version / --no-version        Print "shiptv version 0.4.1" and exit
  --install-completion            Install completion for the current shell.
  --show-completion               Show completion for the current shell, to
                                  copy it or customize the installation.

  --help                          Show this message and exit.

  shiptv version 0.4.1; Python 3.9.4
```

