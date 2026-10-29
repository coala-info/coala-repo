# yahs CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| yahs | PASS |  |
| yahs_agp_to_fasta | PASS |  |
| yahs_juicer_post | PASS |  |
| yahs_juicer_pre | PASS |  |

## yahs

### Tool Description
Scaffold contigs using Hi-C data

### Metadata
- **Docker Image**: quay.io/biocontainers/yahs:1.2.2--he4a0461_0
- **Homepage**: https://github.com/c-zhou/yahs
- **Package**: https://anaconda.org/channels/bioconda/packages/yahs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/yahs/overview
- **Total Downloads**: 18.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/c-zhou/yahs
- **Stars**: N/A
### Original Help Text
```text
Usage: yahs [options] <contigs.fa> <hic.bed>|<hic.bam>|<hic.pa5>|<hic.bin>
Options:
    -a FILE                AGP file (for rescaffolding) [none]
    -r INT[,INT,...]       list of resolutions in ascending order [automate]
    -R INT                 rounds to run at each resoultion level [1]
    -e STR                 restriction enzyme cutting sites [none]
    -l INT                 minimum length of a contig to scaffold [0]
    -q INT                 minimum mapping quality [10]

    --no-contig-ec         do not do contig error correction
    --no-scaffold-ec       do not do scaffold error correction
    --no-mem-check         do not do memory check at runtime
    --file-type   STR      input file type BED|BAM|PA5|BIN, file name extension is ignored if set
    --read-length          read length (required for PA5 format input) [150]
    --telo-motif  STR      telomeric sequence motif

    -o STR                 prefix of output files [yahs.out]
    -v INT                 verbose level [0]
    -?                     print long help with extra option list
    --version              show version number
```

## yahs_agp_to_fasta

### Tool Description
Build a scaffold FASTA file from an AGP file and the contig FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/yahs:1.2.2--he4a0461_0
- **Homepage**: https://github.com/c-zhou/yahs
- **Package**: https://anaconda.org/channels/bioconda/packages/yahs/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: agp_to_fasta [options] <scaffolds.agp> <contigs.fa>
Options:
    -l INT            line width [60]
    -u                allow sequence components with unknown orientations
    -o STR            output to file [stdout]
    --version         show version number
```

## yahs_juicer_pre

### Tool Description
Generate files compatible with the Juicebox toolset.

### Metadata
- **Docker Image**: quay.io/biocontainers/yahs:1.2.2--he4a0461_0
- **Homepage**: https://github.com/c-zhou/yahs
- **Package**: https://anaconda.org/channels/bioconda/packages/yahs/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: juicer pre [options] <hic.bed>|<hic.bam>|<hic.pa5>|<hic.bin> <scaffolds.agp> <contigs.fa.fai>
Options:
    -a                preprocess for assembly mode
    -q INT            minimum mapping quality [10]
    -o STR            output file prefix (required for '-a' mode) [stdout]
    --file-type STR   input file type BED|BAM|PA5|BIN, file name extension is ignored if set
    --version         show version number
```

## yahs_juicer_post

### Tool Description
Generate assembly files after Juicebox curation.

### Metadata
- **Docker Image**: quay.io/biocontainers/yahs:1.2.2--he4a0461_0
- **Homepage**: https://github.com/c-zhou/yahs
- **Package**: https://anaconda.org/channels/bioconda/packages/yahs/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: juicer post [options] <review.assembly> <liftover.agp> <contigs.fa[.fai]>
Options:
    -o STR            output file prefix (required for scaffolds FASTA output) [stdout]
    --seq-ctype STR   AGP output sequence component type [W]
    --gap-ctype STR   AGP output gap component type [U]
    --gap-link  STR   AGP output gap linkage evidence [proximity_ligation]
    --gap-size  INT   AGP output gap size between sequence component [100]
    --version         show version number
```

