# ucsc-fatotwobit CWL Generation Report

## ucsc-fatotwobit

### Tool Description
Convert DNA from fasta to 2bit format

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-fatotwobit:482--hdc0a859_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-fatotwobit/overview
- **Validation**: PASS

### Original Help Text
```text
faToTwoBit - Convert DNA from fasta to 2bit format
usage:
   faToTwoBit in.fa [in2.fa in3.fa ...] out.2bit
options:
   -long            use 64-bit offsets for index.   Allow for twoBit to contain more than 4Gb of sequence. 
                    NOT COMPATIBLE WITH OLDER CODE.
   -noMask          Ignore lower-case masking in fa file.
   -stripVersion    Strip off version number after '.' for GenBank accessions.
   -ignoreDups      Convert first sequence only if there are duplicate sequence
                    names.  Use 'twoBitDup' to find duplicate sequences.
   -namePrefix=XX.  add XX. to start of sequence name in 2bit.
```
## Metadata
- **Skill**: generated

## ucsc-fatotwobit_twoBitInfo

### Tool Description
The provided text does not contain help information for the tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity) failing to fetch the OCI image.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-fatotwobit:482--hdc0a859_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-fatotwobit/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/ucsc-fatotwobit:482--hdc0a859_0 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

