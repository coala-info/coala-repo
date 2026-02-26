# scte CWL Generation Report

## scte_scTE_build

### Tool Description
Build genome annotation index for scTE

### Metadata
- **Docker Image**: quay.io/biocontainers/scte:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/JiekaiLab/scTE
- **Package**: https://anaconda.org/channels/bioconda/packages/scte/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scte/overview
- **Total Downloads**: 2.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/JiekaiLab/scTE
- **Stars**: N/A
### Original Help Text
```text
usage: scTE_build [-h] [-te TEFILE [TEFILE ...]]
                  [-gene GENEFILE [GENEFILE ...]]
                  [-m [{inclusive,exclusive,nointron}]] [-o [OUT]] -g
                  [{hg38,mm10}]

Build genome annotation index for scTE

required arguments:
  -g [{hg38,mm10}], --genome [{hg38,mm10}]
                        Possible Genomes: mm10 (mouse), hg38 (human)

optional arguments:
  -h, --help            show this help message and exit
  -te TEFILE [TEFILE ...]
                        Six columns bed file for transposable elements
                        annotation. Need the -gene option.
  -gene GENEFILE [GENEFILE ...]
                        Gtf file for genes annotation. Need the -te option.
                        Mutalluy exclusive to -x option
  -m [{inclusive,exclusive,nointron}], --mode [{inclusive,exclusive,nointron}]
                        How to count TEs expression: inclusive (inclued all
                        reads that can map to TEs), or exclusive (exclued the
                        reads that can map to the exon of protein coding genes
                        and lncRNAs), or nointron (exclude the reads that can
                        map to the exons and intron of genes). DEFAULT:
                        exclusive
  -o [OUT], --out [OUT]
                        Output file prefix, Default: the genome name

Example: scTE_build -g mm10 -te Data/TE.bed -gene Data/Gene.gtf
```


## scte_scTE

### Tool Description
hahaha...

### Metadata
- **Docker Image**: quay.io/biocontainers/scte:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/JiekaiLab/scTE
- **Package**: https://anaconda.org/channels/bioconda/packages/scte/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scTE [-h] [--min_genes INT] [--min_counts INT] [--expect-cells INT]
            [-f [input file format]] [-CB [{True,False}]]
            [-UMI [{True,False}]] [--keeptmp [{True,False}]]
            [--hdf5 [{True,False}]] [-p INT] [-v] -i INPUT [INPUT ...] -x
            ANNOGLB [ANNOGLB ...] -g [genome] -o [OUT]

hahaha...

required arguments:
  -i INPUT [INPUT ...], --input INPUT [INPUT ...]
                        Input file: BAM/SAM file from CellRanger or STARsolo,
                        the file must be sorted by chromosome position
  -x ANNOGLB [ANNOGLB ...]
                        The filename of the index for the reference genome
                        annotation.
  -g [genome], --genome [genome]
                        "hg38" for human, "mm10" for mouse
  -o [OUT], --out [OUT]
                        Output file prefix

optional arguments:
  -h, --help            show this help message and exit
  --min_genes INT       Minimum number of genes expressed required for a cell
                        to pass filtering. Default: 200
  --min_counts INT      Minimum number of counts required for a cell to pass
                        filtering. Default: 2*min_genes
  --expect-cells INT    Expected number of cells. Default: 10000
  -f [input file format], --format [input file format]
                        Input file format: BAM or SAM. DEFAULT: BAM
  -CB [{True,False}]    Set to false to ignore for cell barcodes, it is useful
                        for SMART-seq. If you set CB=False, it also will set
                        UMI=False by default, Default: True
  -UMI [{True,False}]   Set to false to ignore for UMI, it is useful for
                        SMART-seq. Default: True
  --keeptmp [{True,False}]
                        Keep the _scTEtmp file, which is useful for debugging.
                        Default: False
  --hdf5 [{True,False}]
                        Save the output as .h5ad formatted file instead of csv
                        file. Default: False
  -p INT, --thread INT  Number of threads to use, Default: 1
  -v, --version         show program's version number and exit

Example: scTE <-i scRNA.sorted.bam> <-g mm10> <-o out> [--min_genes 200]
[--min_counts 400] [-p -10] <-x mm10.exclusive.idx>
```

