# rhinotype CWL Generation Report

## rhinotype

### Tool Description
Rhinotype — a CLI tool for assigning rhinovirus genotypes based on VP1 or VP4/2 genomic regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/rhinotype:2.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/omicscodeathon/rhinotype
- **Package**: https://anaconda.org/channels/bioconda/packages/rhinotype/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rhinotype/overview
- **Total Downloads**: 39
- **Last updated**: 2026-01-03
- **GitHub**: https://github.com/omicscodeathon/rhinotype
- **Stars**: N/A
### Original Help Text
```text
usage: rhinotype --input FILE --region {Vp1,Vp4/2} --threshold {VALUE} [--model MODEL] [--threads {VALUE}]

Rhinotype — a CLI tool for assigning rhinovirus genotypes based on VP1 or VP4/2 genomic regions.

options:
  -h, --help            show this help message and exit
  --input INPUT         Path to user FASTA file
  --region {Vp1,Vp4/2}  Genomic region (e.g., Vp1 or Vp4/2)
  --model {p-distance,jc69,k2p,tn93}
                        Evolutionary model to use (default: p-distance). Options: p-distance, jc69, k2p, tn93
  -t, --threshold THRESHOLD
                        The p-distance threshold for genotyping (e.g., 0.105). Default: 0.105 if not specified.
  --threads, -T THREADS
                        Select the number of threads mafft to use for alignment

Examples:
  rhinotype --input my_sequences.fasta --region Vp1 --model p-distance --threshold 0.105 --threads 2
  rhinotype --input my_sequences.fasta --region Vp4/2 --model k2p --threshold 0.405

Models supported: p-distance, jc69, k2p, tn93
```

