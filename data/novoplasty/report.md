# novoplasty CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| novoplasty_NOVOPlasty4.3.5.pl | PASS | Galaxy test data (mito, 2000 read pairs): circularized assembly of 16689 bp |
| novoplasty_filter_reads.pl | PASS | SARS-CoV-2 test reads from nf-core filtered against the genome |

## novoplasty_filter_reads.pl

### Tool Description
Filter paired-end fastq reads sharing k-mers with a reference sequence, for NOVOPlasty.

### Metadata
- **Docker Image**: quay.io/biocontainers/novoplasty:4.3.5--pl5321hdfd78af_0
- **Homepage**: https://github.com/ndierckx/NOVOPlasty
- **Package**: https://anaconda.org/channels/bioconda/packages/novoplasty/overview
- **Validation**: PASS

### Original Help Text
```text
You need to give a reference sequence and forward/reverse read files!
Usage: perl filter_reads.pl -1 forward_reads.fastq -2 reverse_reads.fastq -ref reference_sequence.fasta -out project_name
```


## Metadata
- **Skill**: generated

## novoplasty_NOVOPlasty4.3.5.pl

### Tool Description
NOVOPlasty is a de novo assembler for organelle genomes (mitochondria and chloroplasts). It reads a configuration file to perform the assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/novoplasty:4.3.5--pl5321hdfd78af_0
- **Homepage**: https://github.com/ndierckx/NOVOPlasty
- **Package**: https://anaconda.org/channels/bioconda/packages/novoplasty/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/novoplasty:4.3.5--pl5321hdfd78af_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-4146559036: no space left on device
```

