# fade CWL Generation Report

## fade_annotate

### Tool Description
performs re-alignment of soft-clips and annotates bam records with bitflag (rs) and realignment tags (am)

### Metadata
- **Docker Image**: quay.io/biocontainers/fade:0.6.0--h9ee0642_0
- **Homepage**: https://github.com/blachlylab/fade
- **Package**: https://anaconda.org/channels/bioconda/packages/fade/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fade/overview
- **Total Downloads**: 8.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/blachlylab/fade
- **Stars**: N/A
### Original Help Text
```text
Fragmentase Artifact Detection and Elimination
version: v0.6.0

annotate: performs re-alignment of soft-clips and annotates bam records with bitflag (rs) and realignment tags (am)
usage: fade annotate [options] <input BAM/SAM> <Indexed fasta reference>

-t     --threads extra threads for parsing the bam file
    --min-length Minimum number of bases for a soft-clip to be considered for artifact detection
-w --window-size Number of bases considered outside of read or mate region for re-alignment
-b         --bam output bam
-u        --ubam output uncompressed bam
-h        --help This help information.
```


## fade_out

### Tool Description
Fragmentase Artifact Detection and Elimination. Removes all reads and mates for reads containing the artifact (used after annotate) or hard clips out artifact sequence from reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/fade:0.6.0--h9ee0642_0
- **Homepage**: https://github.com/blachlylab/fade
- **Package**: https://anaconda.org/channels/bioconda/packages/fade/overview
- **Validation**: PASS

### Original Help Text
```text
Fragmentase Artifact Detection and Elimination
version: v0.6.0

out: removes all read and mates for reads contain the artifact (used after annotate)
     or, with the -c flag, hard clips out artifact sequence from reads
     it is reccomended that the input SAM/BAM be queryname sorted
usage: fade out [options] <input BAM/SAM>

-c    --clip clip reads instead of filtering them
-t --threads extra threads for parsing the bam file
-b     --bam output bam
-u    --ubam output uncompressed bam
-h    --help This help information.
```


## fade_stats

### Tool Description
reports extended information about all artifact reads (used after annotate)

### Metadata
- **Docker Image**: quay.io/biocontainers/fade:0.6.0--h9ee0642_0
- **Homepage**: https://github.com/blachlylab/fade
- **Package**: https://anaconda.org/channels/bioconda/packages/fade/overview
- **Validation**: PASS

### Original Help Text
```text
Fragmentase Artifact Detection and Elimination
version: v0.6.0

stats: reports extended information about all artifact reads (used after annotate)
usage: ./fade stats [options] <annotated BAM/SAM>  

-t --threads threads for parsing the bam file
-h    --help This help information.
```


## fade_stats-clip

### Tool Description
reports extended information about all soft-clipped reads (used after annotate)

### Metadata
- **Docker Image**: quay.io/biocontainers/fade:0.6.0--h9ee0642_0
- **Homepage**: https://github.com/blachlylab/fade
- **Package**: https://anaconda.org/channels/bioconda/packages/fade/overview
- **Validation**: PASS

### Original Help Text
```text
Fragmentase Artifact Detection and Elimination
version: v0.6.0

stats-clip: reports extended information about all soft-clipped reads (used after annotate)
usage: ./fade stats-clip [options] <annotated BAM/SAM> 

-t --threads threads for parsing the bam file
-h    --help This help information.
```


## fade_extract

### Tool Description
extracts artifacts into a mapped SAM/BAM (used after annotate)

### Metadata
- **Docker Image**: quay.io/biocontainers/fade:0.6.0--h9ee0642_0
- **Homepage**: https://github.com/blachlylab/fade
- **Package**: https://anaconda.org/channels/bioconda/packages/fade/overview
- **Validation**: PASS

### Original Help Text
```text
Fragmentase Artifact Detection and Elimination
version: v0.6.0

extract: extracts artifacts into a mapped SAM/BAM (used after annotate)
usage: ./fade extract [options] <annotated BAM/SAM> 

-t --threads extra threads for parsing the bam file
-b     --bam output bam
-u    --ubam output uncompressed bam
-h    --help This help information.
```

