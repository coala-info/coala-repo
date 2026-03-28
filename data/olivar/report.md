# olivar CWL Generation Report

## olivar_build

### Tool Description
Build an Olivar reference file from a FASTA sequence and/or an MSA.

### Metadata
- **Docker Image**: quay.io/biocontainers/olivar:1.3.3--pyhdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/olivar
- **Package**: https://anaconda.org/channels/bioconda/packages/olivar/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/olivar/overview
- **Total Downloads**: 17.5K
- **Last updated**: 2026-01-15
- **GitHub**: https://github.com/treangenlab/Olivar
- **Stars**: N/A
### Original Help Text
```text
usage: olivar build [-h] [--fasta fasta-file] [--var <string>]
                    [--msa msa-fasta] [--db <string>] [--output <string>]
                    [--title <string>] [--threads <int>] [--align]
                    [--min-var <float>] [--deg]

options:
  -h, --help            show this help message and exit
  --fasta fasta-file, -f fasta-file
                        Optional, Path to the FASTA reference sequence. The
                        sequence should be high-quality and contain no
                        degenerate bases
  --var <string>, -v <string>
                        Optional, path to the csv file of SNP coordinates and
                        frequencies. Required columns: "START", "STOP",
                        "FREQ". "FREQ" is considered as 1.0 if empty.
                        Coordinates are 1-based.
  --msa msa-fasta, -m msa-fasta
                        Optional, Path to the MSA file in FASTA format.
  --db <string>, -d <string>
                        Optional, path to the BLAST database. Note that this
                        path should end with the name of the BLAST database
                        (e.g., "example_input/Human/GRCh38_primary").
  --output <string>, -o <string>
                        Output directory (output to current directory by
                        default).
  --title <string>, -t <string>
                        Name of the Olivar reference file [FASTA record ID].
  --threads <int>, -p <int>
                        Number of threads [1].
  --align, -a           Control whether do alignment or not.
  --min-var <float>     Minimum frequency threshold for sequence variations
                        generated from the input MSA.
  --deg                 Control whether use degenerate mode or not. This mode
                        only works with MSA input (--msa).
```


## olivar_tiling

### Tool Description
Primer design for tiling experiments.

### Metadata
- **Docker Image**: quay.io/biocontainers/olivar:1.3.3--pyhdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/olivar
- **Package**: https://anaconda.org/channels/bioconda/packages/olivar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: olivar tiling [-h] [--output <string>] [--title <string>]
                     [--max-amp-len <int>] [--min-amp-len <int>]
                     [--w-egc <float>] [--w-lc <float>] [--w-ns <float>]
                     [--w-var <float>] [--w-sensi <float>] [--w-combi <float>]
                     [--temperature <float>] [--salinity <float>]
                     [--dg-max <float>] [--min-gc <float>] [--max-gc <float>]
                     [--min-complexity <float>] [--max-len <int>]
                     [--check-var] [--fp-prefix <DNA>] [--rp-prefix <DNA>]
                     [--seed <int>] [--threads <int>] [--iterMul <int>]
                     [--deg]
                     olvr-path

positional arguments:
  olvr-path             Path to the Olivar reference file (.olvr), or the
                        directory of reference files for multiple targets

options:
  -h, --help            show this help message and exit
  --output <string>, -o <string>
                        Output path (output to current directory by default).
  --title <string>, -t <string>
                        Name of design [olivar-design].
  --max-amp-len <int>   Maximum amplicon length [420].
  --min-amp-len <int>   Minimum amplicon length. 0.9*{max-amp-len} if not
                        provided. Minimum 120.
  --w-egc <float>       Weight for extreme GC content [1.0].
  --w-lc <float>        Weight for low sequence complexity [1.0].
  --w-ns <float>        Weight for non-specificity [1.0].
  --w-var <float>       Weight for variations [1.0].
  --w-sensi <float>     Weight for sensitivity [1.0].
  --w-combi <float>     Weight for combinations [1.0].
  --temperature <float>
                        PCR annealing temperature [60.0].
  --salinity <float>    Concentration of monovalent ions in units of molar
                        [0.18].
  --dg-max <float>      Maximum free energy change of a primer in kcal/mol
                        [-11.8].
  --min-gc <float>      Minimum GC content of a primer [0.2].
  --max-gc <float>      Maximum GC content of a primer [0.75].
  --min-complexity <float>
                        Minimum sequence complexity of a primer [0.4].
  --max-len <int>       Maximum length of a primer [36].
  --check-var           Filter out primer candidates with variations within
                        5nt of 3' end. NOT recommended when a lot of
                        variations are provided, since this would
                        significantly reduce the number of primer candidates.
  --fp-prefix <DNA>     Prefix of forward primer.
  --rp-prefix <DNA>     Prefix of reverse primer.
  --seed <int>          Random seed for optimizing primer design regions and
                        primer dimer [10].
  --threads <int>, -p <int>
                        Number of threads [1].
  --iterMul <int>       Multiplier of iterations during PDR optimization.
  --deg                 Control whether use degenerate mode or not.
```


## olivar_Olivar

### Tool Description
olivar: error: argument subparser_name: invalid choice: 'Olivar' (choose from build, tiling, save, specificity, sensitivity)

### Metadata
- **Docker Image**: quay.io/biocontainers/olivar:1.3.3--pyhdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/olivar
- **Package**: https://anaconda.org/channels/bioconda/packages/olivar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: olivar [-h] [--version] {build,tiling,save,specificity,sensitivity} ...
olivar: error: argument subparser_name: invalid choice: 'Olivar' (choose from build, tiling, save, specificity, sensitivity)
```


## olivar_save

### Tool Description
Saves an Olivar design to a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/olivar:1.3.3--pyhdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/olivar
- **Package**: https://anaconda.org/channels/bioconda/packages/olivar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: olivar save [-h] [--output <string>] olvd-file

positional arguments:
  olvd-file             Path to the Olivar design file (.olvd)

options:
  -h, --help            show this help message and exit
  --output <string>, -o <string>
                        Output path (output to current directory by default).
```


## olivar_specificity

### Tool Description
Calculate primer specificity using BLAST.

### Metadata
- **Docker Image**: quay.io/biocontainers/olivar:1.3.3--pyhdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/olivar
- **Package**: https://anaconda.org/channels/bioconda/packages/olivar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: olivar specificity [-h] [--pool <int>] [--db <string>]
                          [--output <string>] [--title <string>]
                          [--max-amp-len <int>] [--temperature <float>]
                          [--threads <int>]
                          csv-file

positional arguments:
  csv-file              Path to the csv file of a primer pool. Required
                        columns: "amplicon_id" (amplicon name), "fP" (sequence
                        of forward primer), "rP" (sequence of reverse primer).

options:
  -h, --help            show this help message and exit
  --pool <int>          Primer pool number [1].
  --db <string>, -d <string>
                        Optional, path to the BLAST database. Note that this
                        path should end with the name of the BLAST database
                        (e.g., "example_input/Human/GRCh38_primary").
  --output <string>, -o <string>
                        Output path (output to current directory by default).
  --title <string>, -t <string>
                        Name of validation [olivar-specificity].
  --max-amp-len <int>   Maximum length of predicted non-specific amplicon
                        [1500]. Ignored is no BLAST database is provided.
  --temperature <float>
                        PCR annealing temperature [60.0].
  --threads <int>, -p <int>
                        Number of threads [1].
```


## olivar_sensitivity

### Tool Description
Check the sensitivity of existing primer pools against an MSA of target sequences, and visualize the MSA and primer alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/olivar:1.3.3--pyhdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/olivar
- **Package**: https://anaconda.org/channels/bioconda/packages/olivar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: olivar sensitivity [-h] [--msa msa-fasta] [--pool <int>]
                          [--temperature <float>] [--sodium <float>]
                          [--output <string>] [--title <string>]
                          [--threads <int>] [--align]
                          csv-file

Check the sensitivity of existing primer pools against an MSA of target sequences, and visualize the MSA and primer alignments.

positional arguments:
  csv-file              Path to the csv file of a primer pool. Required columns: "amplicon_id" (amplicon name), "fP" (sequence of forward primer), "rP" (sequence of reverse primer).

options:
  -h, --help            show this help message and exit
  --msa msa-fasta, -m msa-fasta
                        Path to the MSA file in FASTA format.
  --pool <int>          Primer pool number [1].
  --temperature <float>
                        Annealing temperature in Degree Celsius [60.0].
  --sodium <float>, -s <float>
                        The sum of the concentrations of monovalent ions (Na+, K+, NH4+), in molar [0.18].
  --output <string>, -o <string>
                        Output path (output to current directory by default).
  --title <string>, -t <string>
                        Name of validation [olivar-sensitivity].
  --threads <int>, -p <int>
                        Number of threads [1].
  --align, -a           Control whether do alignment or not.
```


## olivar_an

### Tool Description
olivar: error: argument subparser_name: invalid choice: 'an' (choose from build, tiling, save, specificity, sensitivity)

### Metadata
- **Docker Image**: quay.io/biocontainers/olivar:1.3.3--pyhdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/olivar
- **Package**: https://anaconda.org/channels/bioconda/packages/olivar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: olivar [-h] [--version] {build,tiling,save,specificity,sensitivity} ...
olivar: error: argument subparser_name: invalid choice: 'an' (choose from build, tiling, save, specificity, sensitivity)
```


## olivar_primer

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/olivar:1.3.3--pyhdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/olivar
- **Package**: https://anaconda.org/channels/bioconda/packages/olivar/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: olivar [-h] [--version] {build,tiling,save,specificity,sensitivity} ...
olivar: error: argument subparser_name: invalid choice: 'primer' (choose from build, tiling, save, specificity, sensitivity)
```


## Metadata
- **Skill**: generated
