---
name: emboss-test
description: EMBOSS is a comprehensive, open-source package containing over 200 applications tailored for molecular biology and bioinformatics.
homepage: http://emboss.open-bio.org/
---

# emboss-test

## Overview

EMBOSS is a comprehensive, open-source package containing over 200 applications tailored for molecular biology and bioinformatics. It provides a unified command-line interface where all tools follow a consistent parameter syntax defined by Ajax Command Definition (ACD) files. Use this skill to streamline sequence analysis workflows, handle diverse file formats automatically, and manage the integration of third-party tools under the EMBASSY collection.

## Installation and Verification

Install the suite using Conda for the most straightforward setup:

```bash
conda install bioconda::emboss
```

To verify a successful installation and check the current version, use:

```bash
embossversion
```

If the command is not found, ensure the installation path (typically `/usr/local/emboss/bin` or your Conda environment bin) is added to your `PATH` environment variable.

## Sequence Addressing (USA)

EMBOSS uses the Uniform Sequence Address (USA) mechanism to specify sequence inputs. This allows for transparent access to local files and remote databases.

- **File-based**: `format::filename` or `filename` (e.g., `fasta::sequence.fasta`)
- **Database-based**: `database:entry` (e.g., `swissprot:p12345`)
- **Specific ranges**: Use the format `usa[start:end]` to process sub-sequences.

## Configuration and Environment

### Site and User Settings
- **Global Configuration**: Edit `emboss.default` (usually in `.../share/EMBOSS/`) for site-wide database definitions and defaults.
- **User Configuration**: Create a `.embossrc` file in your home directory for personal customizations and testing new database definitions.

### Common Environment Variables
- `PATH`: Must include the EMBOSS `bin` directory.
- `LD_LIBRARY_PATH`: May need to include the EMBOSS `lib` directory if the system cannot find `libnucleus`.

## Managing Biological Databases

Several EMBOSS applications require specific data files to be extracted and indexed before use. Run these utilities after installation to enable full functionality:

- **Restriction Enzymes**: Run `rebaseextract` after downloading `withrefm` and `proto` files from REBASE.
- **Amino Acid Indices**: Run `aaindexextract` after downloading `aaindex1` from AAINDEX.
- **Protein Patterns**: Run `prosextract` for PROSITE data and `printsextract` for PRINTS data.
- **Transcription Factors**: Run `jaspextract` for JASPAR data.

## Best Practices for CLI Usage

- **Command Validation**: EMBOSS automatically validates input before execution. If a required parameter is missing, the tool will prompt you interactively.
- **Format Detection**: Most tools automatically detect input sequence formats. To improve efficiency or override defaults, specify the format explicitly using the `type::` prefix in the USA.
- **Memory Management**: EMBOSS handles large sequences dynamically. There are no hard-coded sequence length limits; the suite is limited only by available system memory.
- **Updates**: Check `ftp://emboss.open-bio.org/pub/EMBOSS/fixes/` for source code patches between major annual releases.

## Reference documentation

- [EMBOSS Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_emboss_overview.md)
- [Post-installation and Configuration](./references/emboss_open-bio_org_html_adm_ch01s06.html.md)
- [Key Features and USA Mechanism](./references/emboss_open-bio_org_html_use_ch01s03.html.md)
- [Introduction to EMBOSS](./references/emboss_open-bio_org_html_use_pr02s01.html.md)