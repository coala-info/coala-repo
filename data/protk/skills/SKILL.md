---
name: protk
description: Protk (Proteomics Toolkit) is a suite of Ruby-based command-line tools designed to provide a unified interface for disparate third-party proteomics software.
homepage: https://github.com/iracooke/protk
---

# protk

## Overview

Protk (Proteomics Toolkit) is a suite of Ruby-based command-line tools designed to provide a unified interface for disparate third-party proteomics software. It streamlines the transition between mass spectrometry search engines, statistical inference tools, and downstream data analysis. By wrapping complex tools like the Trans-Proteomic Pipeline (TPP) and various search engines, it allows researchers to build consistent pipelines for peptide identification, protein quantification, and proteogenomics.

## Installation and Setup

Protk requires Ruby 2.0+ and libxml2. It is most easily managed via Bioconda or RubyGems.

- **Conda**: `conda install bioconda::protk`
- **RubyGems**: `gem install protk`

### Dependency Management
Many Protk commands rely on third-party binaries. Use the built-in setup tool to install these dependencies into a local environment (defaulting to `~/.protk/tools`).

```bash
# Install common dependencies
protk_setup.rb tpp omssa msgfplus pwiz
```

**Expert Tip**: Set the `PROTK_INSTALL_DIR` environment variable to change the default installation and database root from `~/.protk` to a high-capacity storage volume.

## Common CLI Patterns

All Protk tools follow a standard naming convention ending in `.rb`. Running any command without arguments displays its help menu.

### 1. Database Management
Before running searches, manage your protein databases using `manage_db.rb`.

```bash
# List available databases
manage_db.rb list

# Add a new FASTA database
manage_db.rb add --db-name my_db --fasta-file proteins.fasta
```

### 2. MS/MS Search Execution
Protk provides wrappers for several major search engines.

- **X!Tandem**: `tandem_search.rb [options] input.mzML`
- **MS-GF+**: `msgfplus_search.rb [options] input.mzML`
- **Mascot**: `mascot_search.rb [options] input.mzML` (Requires Mascot server access)

### 3. Inference and Validation
After searching, use the TPP-based wrappers to perform statistical validation.

- **Peptide Prophet**: `peptide_prophet.rb [options] search_results.pepXML`
- **iProphet**: `interprophet.rb [options] file1.pepXML file2.pepXML` (Combines results from multiple engines)
- **Protein Prophet**: `protein_prophet.rb [options] validated_peptides.pepXML`

### 4. Data Conversion and Export
Protk excels at converting complex XML formats into human-readable or genomic formats.

- **Tabular Export**: `pepxml_to_table.rb input.pepXML` or `protxml_to_table.rb input.protXML`
- **Genomic Mapping**: `protxml_to_gff.rb input.protXML` (Maps peptides to genomic coordinates)
- **Decoy Generation**: `make_decoy.rb input.fasta` (Creates decoy sequences for FDR estimation)

## Best Practices

- **Path Fallbacks**: Protk first looks for tools in `$PROTK_INSTALL_DIR/tools`. If not found, it falls back to your system `$PATH`. Ensure your environment is correctly sourced if using manual installations.
- **Memory Management**: For large-scale searches (especially MS-GF+), ensure the Java heap size is appropriately configured if the wrapper allows, or monitor system memory closely.
- **Database Integrity**: Always use `manage_db.rb` to register databases rather than pointing directly to FASTA files when possible, as this ensures Protk can correctly track database indices and decoy prefixes.
- **Proteogenomics**: When using `sixframe.rb` for DNA translation, ensure your input DNA sequences are in standard FASTA format to avoid parsing errors during the six-frame translation process.

## Reference documentation
- [github_com_iracooke_protk.md](./references/github_com_iracooke_protk.md)
- [anaconda_org_channels_bioconda_packages_protk_overview.md](./references/anaconda_org_channels_bioconda_packages_protk_overview.md)