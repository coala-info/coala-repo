# pan-plaster CWL Generation Report

## pan-plaster

### Tool Description
FAIL to generate CWL: pan-plaster not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/pan-plaster:1.2.1--hdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/plaster
- **Package**: https://anaconda.org/channels/bioconda/packages/pan-plaster/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pan-plaster/overview
- **Total Downloads**: 15.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: pan-plaster not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: pan-plaster not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## pan-plaster_plaster

### Tool Description
A tool for constructing pangenomes and aligning genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pan-plaster:1.2.1--hdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/plaster
- **Package**: https://anaconda.org/channels/bioconda/packages/pan-plaster/overview
- **Validation**: PASS
### Original Help Text
```text
usage: plaster [-h] [-r] [-a] [-t TEMPLATE] [-o OUTPUT] [-w WORK_DIR]
               [-p THREADS] [-l LENGTH] [-f MAX_FRAG_LEN] [-i ID_CUTOFF] [-k]
               [-v] [--version]
               input-files [input-files ...]

positional arguments:
  input-files           a list of input fasta file names. If there is one
                        file, it is assumed that this file contains a list of
                        input files separated by a newline

optional arguments:
  -h, --help            show this help message and exit
  -r, --realign         Realign all input genomes to the resulting pangenome
                        to get a more accurate fragment mapping
  -a, --align-only      Used with --template. Does not append to pangenome,
                        just produces tsv alignment.
  -t TEMPLATE, --template TEMPLATE
                        seed genome to use
  -o OUTPUT, --output OUTPUT
                        output pan-genome fasta and metadata file stem (does
                        not include file extension)
  -w WORK_DIR, --work-dir WORK_DIR
                        Directory to save nucmer outputs.
  -p THREADS, --threads THREADS
                        Number of threads
  -l LENGTH, --length LENGTH
                        Minimum length of sequence attached to the pan-genome
  -f MAX_FRAG_LEN, --max-frag-len MAX_FRAG_LEN
                        Maximum fragment length
  -i ID_CUTOFF, --id-cutoff ID_CUTOFF
                        Minimum identity to record alignment in metadata
  -k, --keep-tmp        Keep intermediate files
  -v, --verbose         Print verbose output
  --version             show program's version number and exit
```

