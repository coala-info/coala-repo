# transindel CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| transindel_transIndel_build_DNA.py | Failed | tool bug: script writes the BAM then crashes with NameError 'remove' is not defined (exit 1) |
| transindel_transIndel_build_RNA.py | PASS | synthetic data: planted 40 bp deletion; 28 chimeric reads merged into 59M40D41M |
| transindel_transIndel_call.py | PASS |  |

## transindel_transIndel_build_DNA.py

### Tool Description
Build a BAM file for indel calling from a BWA alignment of DNA-seq reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/transindel:2.0--hdfd78af_0
- **Homepage**: https://github.com/cauyrd/transIndel
- **Package**: https://anaconda.org/channels/bioconda/packages/transindel/overview
- **Validation**: PASS

### Original Help Text
```text
usage: transIndel_build_DNA.py [-h] -i INPUT -o OUTPUT [-m MAPQ] [-l LENGTH]
                               [-v]

transIndel_build_DNA.py -i input_bam_file -o output_bam_file [opts]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input BAM file
  -o OUTPUT, --output OUTPUT
                        Output BAM file
  -m MAPQ, --mapq MAPQ  minimal MAPQ of read from BAM file for supporting
                        Indel (default: 15)
  -l LENGTH, --length LENGTH
                        Maximum deletion length to be detected (default:
                        1000000)
  -v, --version         show program's version number and exit

transIndel:a splice-aware algorithm that detects the mid-sized insertions and
large deletions using chimeric alignments from DNA-seq or RNA-seq data.
Author: Rendong Yang <yang4414@umn.edu>, MSI, University of Minnesota, 2014
```

## transindel_transIndel_build_RNA.py

### Tool Description
Build a BAM file for indel calling from a BWA alignment of RNA-seq reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/transindel:2.0--hdfd78af_0
- **Homepage**: https://github.com/cauyrd/transIndel
- **Package**: https://anaconda.org/channels/bioconda/packages/transindel/overview
- **Validation**: PASS

### Original Help Text
```text
usage: transIndel_build_RNA.py [-h] -i INPUT -o OUTPUT -r REF -g GTF
                               [-s SPLICE_BIN] [-m MAPQ] [-l LENGTH] [-v]

transIndel_build_RNA.py -i input_bam_file -o output_bam_file [opts]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input BAM file
  -o OUTPUT, --output OUTPUT
                        Output BAM file
  -r REF, --ref REF     reference genome used for analyzing RNA-seq data
  -g GTF, --gtf GTF     gene annotatino file used for analyzing RNA-seq data
  -s SPLICE_BIN, --splice_bin SPLICE_BIN
                        splice site half bin size (default: 20)
  -m MAPQ, --mapq MAPQ  minimal MAPQ of read from BAM file for supporting
                        Indel (default: 15)
  -l LENGTH, --length LENGTH
                        Maximum deletion length to be detected (default:
                        1000000)
  -v, --version         show program's version number and exit

transIndel:a splice-aware algorithm that detects the mid-sized insertions and
large deletions using chimeric alignments from DNA-seq or RNA-seq data.
Author: Rendong Yang <yang4414@umn.edu>, MSI, University of Minnesota, 2014
```

## Metadata
- **Skill**: generated

## transindel_transIndel_call.py

### Tool Description
Call transcript-supported insertions and deletions (indels) from RNA-seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/transindel:2.0--hdfd78af_0
- **Homepage**: https://github.com/cauyrd/transIndel
- **Package**: https://anaconda.org/channels/bioconda/packages/transindel/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/transindel:2.0--hdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:b6b390b0fc87c4260096d2a04612618dae3f465f5b109b9aad19c270d4388edc: unpack entry: usr/local/include/xcb/randr.h: unpack to regular file: short write: write /tmp/build-temp-1868448486/rootfs/usr/local/include/xcb/randr.h: no space left on device
```

