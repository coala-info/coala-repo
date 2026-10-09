# juicebox_scripts CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| juicebox_scripts_agp2assembly.py | PASS | AGP made by the converter gave back the original assembly file |
| juicebox_scripts_degap_assembly.py | PASS | synthetic data: a hic_gap entry planted in a test assembly was removed correctly |
| juicebox_scripts_juicebox_assembly_converter.py | PASS | fasta, agp and bed identical to the expected files of the tool tests |
| juicebox_scripts_juicebox_assembly_purger.py | PASS | new CWL; output identical to the expected files of the tool tests |
| juicebox_scripts_makeAgpFromFasta.py | PASS | AGP lists every contig of the test FASTA |

## juicebox_scripts_juicebox_assembly_converter.py

### Tool Description
Converts a Juicebox assembly file to other formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/juicebox_scripts:0.1.0gita7ae991--hdfd78af_0
- **Homepage**: https://github.com/phasegenomics/juicebox_scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/juicebox_scripts/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/juicebox_scripts/overview
- **Total Downloads**: 362
- **Last updated**: 2025-05-16
- **GitHub**: https://github.com/phasegenomics/juicebox_scripts
- **Stars**: N/A
### Original Help Text
```text
usage: juicebox_assembly_converter.py [-h] -a ASSEMBLY -f FASTA [-p PREFIX]
                                      [-c] [-s] [-v]

options:
  -h, --help            show this help message and exit
  -a, --assembly ASSEMBLY
                        juicebox assembly file
  -f, --fasta FASTA     the fasta file
  -p, --prefix PREFIX   the prefix to use for writing outputs. Default: the
                        assembly file, minus the file extension
  -c, --contig_mode     ignore scaffold specification and just output contigs.
                        useful when only trying to obtain a fasta reflecting
                        juicebox breaks. Default: False
  -s, --simple_chr_names
                        use simple chromosome names ("ChromosomeX") for
                        scaffolds instead of detailed chromosome names
                        ("PGA_scaffold_X__Y_contigs__length_Z"). Has no effect
                        in contig_mode.
  -v, --verbose         print summary of processing steps to stdout, otherwise
                        silent. Default: True
```


## juicebox_scripts_agp2assembly.py

### Tool Description
N/A

### Metadata
- **Docker Image**: quay.io/biocontainers/juicebox_scripts:0.1.0gita7ae991--hdfd78af_0
- **Homepage**: https://github.com/phasegenomics/juicebox_scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/juicebox_scripts/overview
- **Validation**: PASS

### Original Help Text
```text
agp2assembly.py usage:	agp2assembly.py <input_agp_file> <output_assembly_file>
```


## juicebox_scripts_makeAgpFromFasta.py

### Tool Description
Converts a FASTA file to an AGP file.

### Metadata
- **Docker Image**: quay.io/biocontainers/juicebox_scripts:0.1.0gita7ae991--hdfd78af_0
- **Homepage**: https://github.com/phasegenomics/juicebox_scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/juicebox_scripts/overview
- **Validation**: PASS

### Original Help Text
```text
makeAgpFromFasta.py usage:	makeAgpFromFasta.py <fasta_file> <agp_out_file>
```


## juicebox_scripts_degap_assembly.py

### Tool Description
Removes gaps from an assembly file.

### Metadata
- **Docker Image**: quay.io/biocontainers/juicebox_scripts:0.1.0gita7ae991--hdfd78af_0
- **Homepage**: https://github.com/phasegenomics/juicebox_scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/juicebox_scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/degap_assembly.py", line 6, in <module>
    with open(sys.argv[1]) as file:
              ~~~~~~~~^^^
IndexError: list index out of range
```


## Metadata
- **Skill**: generated

## juicebox_scripts_juicebox_assembly_purger.py

### Tool Description
Removes the given contigs from a Juicebox assembly file.

### Metadata
- **Docker Image**: quay.io/biocontainers/juicebox_scripts:0.1.0gita7ae991--hdfd78af_0
- **Homepage**: https://github.com/phasegenomics/juicebox_scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/juicebox_scripts/overview
- **Validation**: PASS

### Original Help Text
```text
usage: juicebox_assembly_purger.py [-h]
                                   [--exclude_contigs EXCLUDE_CONTIGS [EXCLUDE_CONTIGS ...]]
                                   [--exclude_file EXCLUDE_FILE]
                                   [--logging {verbose,silent}]
                                   input_assembly output_assembly

positional arguments:
  input_assembly
  output_assembly

options:
  -h, --help            show this help message and exit
  --exclude_contigs EXCLUDE_CONTIGS [EXCLUDE_CONTIGS ...]
                        Names of contigs to exclude
  --exclude_file EXCLUDE_FILE
                        Path to file of contigs to exclude (with contig names
                        in first whitespace-delimited column, one per line)
  --logging {verbose,silent}
                        Set logging level (Default: verbose)
```
