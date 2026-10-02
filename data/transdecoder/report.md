# transdecoder CWL Generation Report

## transdecoder

### Tool Description
The provided text does not contain help information or usage instructions; it is a system error log indicating a failure to build a container image due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2
- **Homepage**: https://transdecoder.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/transdecoder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/transdecoder/overview
- **Total Downloads**: 217.7K
- **Last updated**: 2025-07-16
- **GitHub**: https://github.com/TransDecoder/TransDecoder
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:eb2f22bad72b0ecfa91e041a4248c3b0d22812b6597f1f7c44051bfc034415d3: unpack entry: usr/local/bin/x86_64-conda-linux-gnu-size: unpack to regular file: short write: write /tmp/build-temp-1917251742/rootfs/usr/local/bin/x86_64-conda-linux-gnu-size: no space left on device
```


## Metadata
- **Skill**: generated

## transdecoder_TransDecoder.LongOrfs

### Tool Description
Transcriptome Protein Prediction - identify candidate open reading frames (ORFs) within transcripts

### Metadata
- **Docker Image**: quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2
- **Homepage**: https://transdecoder.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/transdecoder/overview
- **Validation**: PASS

### Original Help Text
```text
########################################################################################
#             ______                 ___                  __
#            /_  __/______ ____ ___ / _ \___ _______  ___/ /__ ____
#             / / / __/ _ `/ _\(_-</ // / -_) __/ _ \/ _  / -_) __/
#            /_/ /_/ \_,_/_//_/___/____/\__/\__/\___/\_,_/\__/_/   .LongOrfs
#                                                       
########################################################################################
#
#  Transdecoder.LongOrfs|http://transdecoder.github.io> - Transcriptome Protein Prediction
#
#
#  Required:
#
#    -t <string>                            transcripts.fasta
#
#  Optional:
#
#   --gene_trans_map <string>              gene-to-transcript identifier mapping file (tab-delimited, gene_id<tab>trans_id<return> ) 
#
#   -m <int>                               minimum protein length (default: 100)
# 
#   -S                                     strand-specific (only analyzes top strand)
#
#   --output_dir | -O  <string>            path to intended output directory
#
#   --version                              show version tag (5.7.1)
#
#   --genetic_code | -G <string>                            genetic code (default: universal; see PerlDoc; options: Euplotes, Tetrahymena, Candida, Acetabularia)
#                                              Genetic Codes (derived from: https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi)#  
Acetabularia
Candida
Ciliate
Dasycladacean
Euplotid
Hexamita
Mesodinium
Mitochondrial-Ascidian
Mitochondrial-Chlorophycean
Mitochondrial-Echinoderm
Mitochondrial-Flatworm
Mitochondrial-Invertebrates
Mitochondrial-Protozoan
Mitochondrial-Pterobranchia
Mitochondrial-Scenedesmus_obliquus
Mitochondrial-Thraustochytrium
Mitochondrial-Trematode
Mitochondrial-Vertebrates
Mitochondrial-Yeast
Pachysolen_tannophilus
Peritrich
SR1_Gracilibacteria
Tetrahymena
Universal 
#
#   --complete_orfs_only                   yields only complete ORFs (peps start with Met (M), end with stop (*))
#
#########################################################################################
```
## transdecoder_TransDecoder.Predict

### Tool Description
The provided text does not contain help information for TransDecoder.Predict; it contains error logs related to a container runtime failure (no space left on device).

### Metadata
- **Docker Image**: quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2
- **Homepage**: https://transdecoder.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/transdecoder/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:eb2f22bad72b0ecfa91e041a4248c3b0d22812b6597f1f7c44051bfc034415d3: unpack entry: usr/local/bin/x86_64-conda-linux-gnu-size: unpack to regular file: short write: write /tmp/build-temp-3661732720/rootfs/usr/local/bin/x86_64-conda-linux-gnu-size: no space left on device
```

