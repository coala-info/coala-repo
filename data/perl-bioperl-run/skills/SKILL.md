---
name: perl-bioperl-run
description: BioPerl-Run provides a consistent object-oriented interface to execute and manage dozens of external bioinformatics binaries through Perl. Use when user asks to run external tools like BLAST or ClustalW, manage command-line arguments for genomic pipelines, or parse output from bioinformatics software into BioPerl objects.
homepage: http://metacpan.org/pod/BioPerl-Run
metadata:
  docker_image: "quay.io/biocontainers/perl-bioperl-run:1.007003--pl5321hdfd78af_0"
---

# perl-bioperl-run

## Overview
BioPerl-Run is a specialized extension of the BioPerl project that provides a consistent object-oriented interface to dozens of external bioinformatics binaries. Instead of manually constructing system calls and parsing raw text files, this toolkit allows you to treat external programs as "Factory" objects. It handles the complexities of temporary file management, command-line argument formatting, and environment variable configuration, making it essential for building robust genomic pipelines.

## Installation and Environment
Install the toolkit via Bioconda to ensure all dependencies and common wrapped binaries are available:
```bash
conda install -c bioconda perl-bioperl-run
```

Most wrappers require the underlying binary to be in your PATH or defined via environment variables (e.g., `BLASTDIR`, `CLUSTALDIR`).

## Core Usage Patterns

### 1. The Factory Pattern
Every tool in BioPerl-Run follows a "Factory" pattern. You initialize a factory object with parameters, then call a method (usually `run` or a tool-specific verb like `align`) on your data.

```perl
use Bio::Tools::Run::Alignment::Clustalw;

# Initialize the wrapper with command-line flags
my $factory = Bio::Tools::Run::Alignment::Clustalw->new(
    -matrix => 'BLOSUM',
    -gapopen => 10
);

# Execute the tool on a Bio::Seq object or a file
my $aln = $factory->align($seq_array_ref);
```

### 2. Handling BLAST with StandAloneBlastPlus
For local BLAST searches, `Bio::Tools::Run::StandAloneBlastPlus` is the modern standard within this suite.

```perl
use Bio::Tools::Run::StandAloneBlastPlus;

my $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
    -db_name => 'swissprot',
    -db_dir  => '/path/to/indices'
);

my $result = $fac->blastp(-query => $seq_obj);
```

### 3. Parameter Management
- **Method calls**: Most wrappers allow you to change parameters after object creation using `$factory->parameter_name($value)`.
- **Program availability**: Always verify the binary is executable in the current environment using `$factory->executable`.

## Expert Tips
- **Temporary Files**: BioPerl-Run creates many temporary files. Use `Bio::Root::IO->save_tempfiles(1)` during debugging to inspect the exact input/output files sent to the external binary.
- **Output Parsing**: The primary advantage of BioPerl-Run is that it returns BioPerl objects (like `Bio::SimpleAlign` or `Bio::Search::Result::GenericResult`) rather than raw text, allowing immediate downstream processing.
- **Error Trapping**: Wrap factory executions in `eval {}` blocks, as wrappers will throw exceptions (via `throw`) if the external binary returns a non-zero exit code or if files are missing.

## Reference documentation
- [BioPerl-Run MetaCPAN](./references/metacpan_org_pod_BioPerl-Run.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-bioperl-run_overview.md)