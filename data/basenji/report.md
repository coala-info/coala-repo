# basenji CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| basenji_basenji_motifs.py | Failed | image problem: basenji_motifs.py crashes at start unless the HG38 environment variable is set, and it also reads an undefined split_label option; CWL flags were rewritten from the help. |
| basenji_basenji_sat_bed.py | PASS |  |
| basenji_basenji_sat_vcf.py | PASS |  |

## basenji_basenji_sat_bed.py

### Tool Description
Perform an in silico saturation mutagenesis of sequences in a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/basenji:0.6--pyhdfd78af_0
- **Homepage**: https://github.com/calico/basenji
- **Package**: https://anaconda.org/channels/bioconda/packages/basenji/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/basenji/overview
- **Total Downloads**: 10.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/calico/basenji
- **Stars**: N/A

### Original Help Text
```text
Usage: basenji_sat_bed.py [options] <params_file> <model_file> <bed_file>

Options:
  -h, --help         show this help message and exit
  -d MUT_DOWN        Nucleotides downstream of center sequence to mutate
                     [Default: 0]
  -f GENOME_FASTA    Genome FASTA for sequences [Default: none]
  -l MUT_LEN         Length of center sequence to mutate [Default: 0]
  -o OUT_DIR         Output directory [Default: sat_mut]
  --plots            Make heatmap plots [Default: False]
  -p PROCESSES       Number of processes, passed by multi script
  --rc               Ensemble forward and reverse complement predictions
                     [Default: False]
  --shifts=SHIFTS    Ensemble prediction shifts [Default: 0]
  --stats=SAD_STATS  Comma-separated list of stats to save. [Default: sum]
  -t TARGETS_FILE    File specifying target indexes and labels in table format
  -u MUT_UP          Nucleotides upstream of center sequence to mutate
                     [Default: 0]
```

## basenji_basenji_sat_vcf.py

### Tool Description
Perform an in silico saturated mutagenesis of the sequences surrounding variants given in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/basenji:0.6--pyhdfd78af_0
- **Homepage**: https://github.com/calico/basenji
- **Package**: https://anaconda.org/channels/bioconda/packages/basenji/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/basenji/overview
- **Total Downloads**: 10.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/calico/basenji
- **Stars**: N/A

### Original Help Text
```text
Usage: basenji_sat_vcf.py [options] <params_file> <model_file> <vcf_file>

Options:
  -h, --help          show this help message and exit
  -d MUT_DOWN         Nucleotides downstream of center sequence to mutate
                      [Default: 0]
  -f FIGURE_WIDTH     Figure width [Default: 20]
  --f1=GENOME1_FASTA  Genome FASTA which which major allele sequences will be
                      drawn
  --f2=GENOME2_FASTA  Genome FASTA which which minor allele sequences will be
                      drawn
  -l MUT_LEN          Length of centered sequence to mutate [Default: 200]
  -o OUT_DIR          Output directory [Default: sat_vcf]
  --rc                Ensemble forward and reverse complement predictions
                      [Default: False]
  --shifts=SHIFTS     Ensemble prediction shifts [Default: 0]
  --stats=SAD_STATS   Comma-separated list of stats to save. [Default: sum]
  -t TARGETS_FILE     File specifying target indexes and labels in table
                      format
  -u MUT_UP           Nucleotides upstream of center sequence to mutate
                      [Default: 0]
```

## Metadata
- **Skill**: generated

## basenji_basenji_motifs.py

### Tool Description
Analyze and visualize motifs identified by a trained Basenji model.

### Metadata
- **Docker Image**: quay.io/biocontainers/basenji:0.6--pyhdfd78af_0
- **Homepage**: https://github.com/calico/basenji
- **Package**: https://anaconda.org/channels/bioconda/packages/basenji/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/basenji:0.6--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:94c399ed1dd3ee1af742bfc75f0651ec77e215a437f344170b60c6df2e7e6a8f: unpack entry: usr/local/bin/python3.9: unpack to regular file: short write: write /scratch/21813747/build-temp-3494775948/rootfs/usr/local/bin/python3.9: no space left on device
```

