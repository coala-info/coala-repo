# dnaapler CWL Generation Report

## dnaapler_all

### Tool Description
Run dnaapler on all contigs in the input file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/dnaapler
- **Package**: https://anaconda.org/channels/bioconda/packages/dnaapler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dnaapler/overview
- **Total Downloads**: 31.8K
- **Last updated**: 2025-08-21
- **GitHub**: https://github.com/gbouras13/dnaapler
- **Stars**: N/A
### Original Help Text
```text
Usage: dnaapler all [OPTIONS]

Options:
  -h, --help               Show this message and exit.
  -V, --version            Show the version and exit.
  -i, --input PATH         Path to input file in FASTA or GFA format
                           [required]
  -o, --output PATH        Output directory   [default: output.dnaapler]
  -t, --threads INTEGER    Number of threads to use with MMseqs2  [default: 1]
  -p, --prefix TEXT        Prefix for output files  [default: dnaapler]
  -f, --force              Force overwrites the output directory
  -e, --evalue TEXT        E-value for MMseqs2  [default: 1e-10]
  --ignore TEXT            Text file listing contigs (one per row) that are to
                           be ignored OR comma separated list of contig names
                           to ignore OR '-' to read from stdin
  --db, --database TEXT    Lets you choose a subset of databases rather than
                           all 4. Must be one of: 'all', 'dnaa', 'repa',
                           terl', 'cog1474', 'dnaa,repa', 'dnaa,terl',
                           'repa,terl',  'dnaA,cog1474', 'cog1474,terl',
                           'cog1474,repa', 'dnaa,cog1474,repa',
                           'dnaa,cog1474,terl' or 'cog1474,repa,terl'
                           [default: all]
  -c, --custom_db PATH     FASTA file with amino acids that will be used as a
                           custom MMseqs2 database to reorient your sequence
                           however you want.
  -a, --autocomplete TEXT  Choose an option to autocomplete reorientation if
                           MMseqs2 based approach fails. Must be one of: none,
                           mystery, largest, or nearest [default: none]
  --seed_value INTEGER     Random seed to ensure reproducibility.  [default:
                           13]
```


## dnaapler_archaeal

### Tool Description
A tool for analyzing and annotating archaeal genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/dnaapler
- **Package**: https://anaconda.org/channels/bioconda/packages/dnaapler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dnaapler [OPTIONS] COMMAND [ARGS]...

Error: No such command 'archaeal'.
```


## dnaapler_archaea

### Tool Description
Run dnaapler on archaea genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/dnaapler
- **Package**: https://anaconda.org/channels/bioconda/packages/dnaapler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dnaapler archaea [OPTIONS]

Options:
  -h, --help               Show this message and exit.
  -V, --version            Show the version and exit.
  -i, --input PATH         Path to input file in FASTA or GFA format
                           [required]
  -o, --output PATH        Output directory   [default: output.dnaapler]
  -t, --threads INTEGER    Number of threads to use with MMseqs2  [default: 1]
  -p, --prefix TEXT        Prefix for output files  [default: dnaapler]
  -f, --force              Force overwrites the output directory
  -e, --evalue TEXT        E-value for MMseqs2  [default: 1e-10]
  -a, --autocomplete TEXT  Choose an option to autocomplete reorientation if
                           MMseqs2 based approach fails. Must be one of: none,
                           mystery, largest, or nearest [default: none]
  --seed_value INTEGER     Random seed to ensure reproducibility.  [default:
                           13]
```


## dnaapler_bulk

### Tool Description
Reorient sequences in bulk

### Metadata
- **Docker Image**: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/dnaapler
- **Package**: https://anaconda.org/channels/bioconda/packages/dnaapler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dnaapler bulk [OPTIONS]

Options:
  -h, --help             Show this message and exit.
  -V, --version          Show the version and exit.
  -i, --input PATH       Path to input file in FASTA or GFA format  [required]
  -o, --output PATH      Output directory   [default: output.dnaapler]
  -t, --threads INTEGER  Number of threads to use with MMseqs2  [default: 1]
  -p, --prefix TEXT      Prefix for output files  [default: dnaapler]
  -f, --force            Force overwrites the output directory
  -e, --evalue TEXT      E-value for MMseqs2  [default: 1e-10]
  -m, --mode TEXT        Choose an mode to reorient in bulk. Must be one of:
                         chromosome, plasmid, phage or custom [default:
                         chromosome]
  -c, --custom_db PATH   FASTA file with amino acids that will be used as a
                         custom MMseqs2 database to reorient your sequence
                         however you want. Must be specified if -m custom is
                         specified.
```


## dnaapler_chromosome

### Tool Description
This command is part of the dnaapler tool and is used for processing chromosome-related data.

### Metadata
- **Docker Image**: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/dnaapler
- **Package**: https://anaconda.org/channels/bioconda/packages/dnaapler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dnaapler chromosome [OPTIONS]

Options:
  -h, --help               Show this message and exit.
  -V, --version            Show the version and exit.
  -i, --input PATH         Path to input file in FASTA or GFA format
                           [required]
  -o, --output PATH        Output directory   [default: output.dnaapler]
  -t, --threads INTEGER    Number of threads to use with MMseqs2  [default: 1]
  -p, --prefix TEXT        Prefix for output files  [default: dnaapler]
  -f, --force              Force overwrites the output directory
  -e, --evalue TEXT        E-value for MMseqs2  [default: 1e-10]
  -a, --autocomplete TEXT  Choose an option to autocomplete reorientation if
                           MMseqs2 based approach fails. Must be one of: none,
                           mystery, largest, or nearest [default: none]
  --seed_value INTEGER     Random seed to ensure reproducibility.  [default:
                           13]
```


## dnaapler_replication

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/dnaapler
- **Package**: https://anaconda.org/channels/bioconda/packages/dnaapler/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: dnaapler [OPTIONS] COMMAND [ARGS]...

Error: No such command 'replication'.
```


## dnaapler_citation

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/dnaapler
- **Package**: https://anaconda.org/channels/bioconda/packages/dnaapler/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Dnaapler has been published in JOSS. If you use Dnaapler in your work, please cite it as follows:

George Bouras, Susanna R. Grigson, Bhavya Papudeshi, Vijini Mallawaarachchi, Michael J. Roach (2024). Dnaapler: A tool to reorient circular microbial genomes. Journal of Open Source Software, 9(93), 5968, https://doi.org/10.21105/joss.05968

Additionally, please consider citing the dependencies:

Altschul S.F., Gish W., Miller W., Myers E.W., Lipman D.J. Basic local alignment search tool. J Mol Biol. 1990 Oct 5;215(3):403-10. doi: 10.1016/S0022-2836(05)80360-2. PMID: 2231712.

Larralde, M., (2022). Pyrodigal: Python bindings and interface to Prodigal, an efficient method for gene prediction in prokaryotes. Journal of Open Source Software, 7(72), 4296, https://doi.org/10.21105/joss.04296.

Hyatt, D., Chen, GL., LoCascio, P.F. et al. Prodigal: prokaryotic gene recognition and translation initiation site identification. BMC Bioinformatics 11, 119 (2010). https://doi.org/10.1186/1471-2105-11-119.
```


## dnaapler_custom

### Tool Description
Custom reorientation of sequences using a custom MMseqs2 database.

### Metadata
- **Docker Image**: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/dnaapler
- **Package**: https://anaconda.org/channels/bioconda/packages/dnaapler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dnaapler custom [OPTIONS]

Options:
  -h, --help               Show this message and exit.
  -V, --version            Show the version and exit.
  -i, --input PATH         Path to input file in FASTA or GFA format
                           [required]
  -o, --output PATH        Output directory   [default: output.dnaapler]
  -t, --threads INTEGER    Number of threads to use with MMseqs2  [default: 1]
  -p, --prefix TEXT        Prefix for output files  [default: dnaapler]
  -f, --force              Force overwrites the output directory
  -e, --evalue TEXT        E-value for MMseqs2  [default: 1e-10]
  -c, --custom_db PATH     FASTA file with amino acids that will be used as a
                           custom MMseqs2 database to reorient your sequence
                           however you want.  [required]
  -a, --autocomplete TEXT  Choose an option to autocomplete reorientation if
                           MMseqs2 based approach fails. Must be one of: none,
                           mystery, largest, or nearest [default: none]
  --seed_value INTEGER     Random seed to ensure reproducibility.  [default:
                           13]
```


## dnaapler_largest

### Tool Description
Finds the largest contig in a FASTA or GFA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/dnaapler
- **Package**: https://anaconda.org/channels/bioconda/packages/dnaapler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dnaapler largest [OPTIONS]

Options:
  -h, --help             Show this message and exit.
  -V, --version          Show the version and exit.
  -i, --input PATH       Path to input file in FASTA or GFA format  [required]
  -o, --output PATH      Output directory   [default: output.dnaapler]
  -t, --threads INTEGER  Number of threads to use with MMseqs2  [default: 1]
  -p, --prefix TEXT      Prefix for output files  [default: dnaapler]
  -f, --force            Force overwrites the output directory
```


## dnaapler_by

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/dnaapler
- **Package**: https://anaconda.org/channels/bioconda/packages/dnaapler/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: dnaapler [OPTIONS] COMMAND [ARGS]...

Error: No such command 'by'.
```


## dnaapler_mystery

### Tool Description
Mystery tool for dnaapler

### Metadata
- **Docker Image**: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/dnaapler
- **Package**: https://anaconda.org/channels/bioconda/packages/dnaapler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dnaapler mystery [OPTIONS]

Options:
  -h, --help             Show this message and exit.
  -V, --version          Show the version and exit.
  -i, --input PATH       Path to input file in FASTA or GFA format  [required]
  -o, --output PATH      Output directory   [default: output.dnaapler]
  -t, --threads INTEGER  Number of threads to use with MMseqs2  [default: 1]
  -p, --prefix TEXT      Prefix for output files  [default: dnaapler]
  -f, --force            Force overwrites the output directory
  --seed_value INTEGER   Random seed to ensure reproducibility.  [default: 13]
```


## dnaapler_nearest

### Tool Description
Find the nearest reference genome for each input sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/dnaapler
- **Package**: https://anaconda.org/channels/bioconda/packages/dnaapler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dnaapler nearest [OPTIONS]

Options:
  -h, --help             Show this message and exit.
  -V, --version          Show the version and exit.
  -i, --input PATH       Path to input file in FASTA or GFA format  [required]
  -o, --output PATH      Output directory   [default: output.dnaapler]
  -t, --threads INTEGER  Number of threads to use with MMseqs2  [default: 1]
  -p, --prefix TEXT      Prefix for output files  [default: dnaapler]
  -f, --force            Force overwrites the output directory
```


## dnaapler_pyrodigal

### Tool Description
A tool for analyzing DNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/dnaapler
- **Package**: https://anaconda.org/channels/bioconda/packages/dnaapler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dnaapler [OPTIONS] COMMAND [ARGS]...

Error: No such command 'pyrodigal'.
```


## dnaapler_phage

### Tool Description
Run dnaapler on phage genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/dnaapler
- **Package**: https://anaconda.org/channels/bioconda/packages/dnaapler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dnaapler phage [OPTIONS]

Options:
  -h, --help               Show this message and exit.
  -V, --version            Show the version and exit.
  -i, --input PATH         Path to input file in FASTA or GFA format
                           [required]
  -o, --output PATH        Output directory   [default: output.dnaapler]
  -t, --threads INTEGER    Number of threads to use with MMseqs2  [default: 1]
  -p, --prefix TEXT        Prefix for output files  [default: dnaapler]
  -f, --force              Force overwrites the output directory
  -e, --evalue TEXT        E-value for MMseqs2  [default: 1e-10]
  -a, --autocomplete TEXT  Choose an option to autocomplete reorientation if
                           MMseqs2 based approach fails. Must be one of: none,
                           mystery, largest, or nearest [default: none]
  --seed_value INTEGER     Random seed to ensure reproducibility.  [default:
                           13]
```


## dnaapler_subunit

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/dnaapler
- **Package**: https://anaconda.org/channels/bioconda/packages/dnaapler/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: dnaapler [OPTIONS] COMMAND [ARGS]...

Error: No such command 'subunit'.
```


## dnaapler_plasmid

### Tool Description
Runs the plasmid detection pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/dnaapler
- **Package**: https://anaconda.org/channels/bioconda/packages/dnaapler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dnaapler plasmid [OPTIONS]

Options:
  -h, --help               Show this message and exit.
  -V, --version            Show the version and exit.
  -i, --input PATH         Path to input file in FASTA or GFA format
                           [required]
  -o, --output PATH        Output directory   [default: output.dnaapler]
  -t, --threads INTEGER    Number of threads to use with MMseqs2  [default: 1]
  -p, --prefix TEXT        Prefix for output files  [default: dnaapler]
  -f, --force              Force overwrites the output directory
  -e, --evalue TEXT        E-value for MMseqs2  [default: 1e-10]
  -a, --autocomplete TEXT  Choose an option to autocomplete reorientation if
                           MMseqs2 based approach fails. Must be one of: none,
                           mystery, largest, or nearest [default: none]
  --seed_value INTEGER     Random seed to ensure reproducibility.  [default:
                           13]
```


## dnaapler_initiation

### Tool Description
A tool for analyzing DNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/dnaapler
- **Package**: https://anaconda.org/channels/bioconda/packages/dnaapler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dnaapler [OPTIONS] COMMAND [ARGS]...

Error: No such command 'initiation'.
```


## Metadata
- **Skill**: generated
