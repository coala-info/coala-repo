# htseq-clip CWL Generation Report

## htseq-clip_annotation

### Tool Description
annotation: flattens (to BED format) the given annotation file (in GFF format)

### Metadata
- **Docker Image**: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
- **Homepage**: https://github.com/EMBL-Hentze-group/htseq-clip
- **Package**: https://anaconda.org/channels/bioconda/packages/htseq-clip/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/htseq-clip/overview
- **Total Downloads**: 5.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/EMBL-Hentze-group/htseq-clip
- **Stars**: N/A
### Original Help Text
```text
usage: htseq-clip annotation [-h] -g annotation [-o output file] [-u gene id]
                             [-n gene name] [-t gene type] [--splitExons]
                             [--unsorted] [-v Verbose level]

annotation: flattens (to BED format) the given annotation file (in GFF format)

options:
  -h, --help            show this help message and exit
  -g annotation, --gff annotation
                        GFF formatted annotation file, supports gzipped (.gz) files
  -o output file, --output output file
                        output file (.bed[.gz], default: print to console)
  -u gene id, --geneid gene id
                        Gene id attribute in GFF file (default: gene_id for gencode gff files)
  -n gene name, --genename gene name
                        Gene name attribute in GFF file (default: gene_name for gencode gff files)
  -t gene type, --genetype gene type
                        Gene type attribute in GFF file (default: gene_type for gencode gff files)
  --splitExons          use this flag to split exons into exonic features such as 5'UTR, CDS and 3' UTR
  --unsorted            use this flag if the GFF file is unsorted
  -v Verbose level, --verbose Verbose level
                        Allowed choices: debug, info, warn, quiet (default: info)
```


## htseq-clip_createslidingwindows

### Tool Description
htseq-clip: error: argument subparser: invalid choice: 'createslidingwindows' (choose from 'annotation', 'createSlidingWindows', 'mapToId', 'extract', 'count', 'createMatrix', 'createMaxCountMatrix', 'trimAnnotation')

### Metadata
- **Docker Image**: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
- **Homepage**: https://github.com/EMBL-Hentze-group/htseq-clip
- **Package**: https://anaconda.org/channels/bioconda/packages/htseq-clip/overview
- **Validation**: PASS

### Original Help Text
```text
usage: htseq-clip [-h] [-v]
                  {annotation,createSlidingWindows,mapToId,extract,count,createMatrix,createMaxCountMatrix,trimAnnotation}
                  ...
htseq-clip: error: argument subparser: invalid choice: 'createslidingwindows' (choose from 'annotation', 'createSlidingWindows', 'mapToId', 'extract', 'count', 'createMatrix', 'createMaxCountMatrix', 'trimAnnotation')
```


## htseq-clip_maptold

### Tool Description
htseq-clip: error: argument subparser: invalid choice: 'maptold' (choose from 'annotation', 'createSlidingWindows', 'mapToId', 'extract', 'count', 'createMatrix', 'createMaxCountMatrix', 'trimAnnotation')

### Metadata
- **Docker Image**: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
- **Homepage**: https://github.com/EMBL-Hentze-group/htseq-clip
- **Package**: https://anaconda.org/channels/bioconda/packages/htseq-clip/overview
- **Validation**: PASS

### Original Help Text
```text
usage: htseq-clip [-h] [-v]
                  {annotation,createSlidingWindows,mapToId,extract,count,createMatrix,createMaxCountMatrix,trimAnnotation}
                  ...
htseq-clip: error: argument subparser: invalid choice: 'maptold' (choose from 'annotation', 'createSlidingWindows', 'mapToId', 'extract', 'count', 'createMatrix', 'createMaxCountMatrix', 'trimAnnotation')
```


## htseq-clip_extract

### Tool Description
extracts crosslink sites, insertions or deletions

### Metadata
- **Docker Image**: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
- **Homepage**: https://github.com/EMBL-Hentze-group/htseq-clip
- **Package**: https://anaconda.org/channels/bioconda/packages/htseq-clip/overview
- **Validation**: PASS

### Original Help Text
```text
usage: htseq-clip extract [-h] -i input file [-o output file] -e {1,2}
                          [-s {s,i,d,m,e}] [-g offset length] [--ignore]
                          [--ignore_PCR_duplicates]
                          [-q min. alignment quality] [-m min. read length]
                          [-x max. read length] [-l max. read interval]
                          [--primary] [-c cpus] [-f chromosomes list] [-t tmp]
                          [-v Verbose level]

extract:  extracts crosslink sites, insertions or deletions

options:
  -h, --help            show this help message and exit
  -i input file, --input input file
                        input file (.bam, MUST be co-ordinate sorted and indexed)
  -o output file, --output output file
                        output file (.bed, default: print to console)
  -e {1,2}, --mate {1,2}
                        for paired end sequencing, select the read/mate to extract the crosslink sites from.
                         Must be one of: 1, 2
  -s {s,i,d,m,e}, --site {s,i,d,m,e}
                        Crosslink site choices, must be one of: s, i, d, m, e
                         s: start site 
                         i: insertion site 
                         d: deletion site 
                         m: middle site 
                         e: end site (default: e).
  -g offset length, --offset offset length
                        Number of nucleotides to offset for crosslink sites (default: 0)
  --ignore              flag to ignore crosslink sites outside of genome
  --ignore_PCR_duplicates
                        flag to ignore PCR duplicates (only if bam file has PCR duplicate flag in alignment)
  -q min. alignment quality, --minAlignmentQuality min. alignment quality
                        minimum alignment quality (default: 10)
  -m min. read length, --minReadLength min. read length
                        minimum read length (default: 0)
  -x max. read length, --maxReadLength max. read length
                        maximum read length (default: 500)
  -l max. read interval, --maxReadInterval max. read interval
                        maximum read interval length (default: 10000)
  --primary             flag to use only primary positions of multimapping reads
  -c cpus, --cores cpus
                        Number of cores to use for alignment parsing (default: 5)
  -f chromosomes list, --chrom chromosomes list
                        Extract crosslink sites only from chromosomes given in this file (one chromosome per line, default: None)
  -t tmp, --tmp tmp     Path to create and store temp files (default behavior: use folder from "--output" parameter)
  -v Verbose level, --verbose Verbose level
                        Allowed choices: debug, info, warn, quiet (default: info)
```


## htseq-clip_count

### Tool Description
counts the number of crosslink/deletion/insertion sites

### Metadata
- **Docker Image**: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
- **Homepage**: https://github.com/EMBL-Hentze-group/htseq-clip
- **Package**: https://anaconda.org/channels/bioconda/packages/htseq-clip/overview
- **Validation**: PASS

### Original Help Text
```text
usage: htseq-clip count [-h] -i input bed [-o output file] -a annotation
                        [--unstranded] [--copy_tmp] [-t temp. directory]
                        [-v Verbose level]

count: counts the number of crosslink/deletion/insertion sites

options:
  -h, --help            show this help message and exit
  -i input bed, --input input bed
                        extracted crosslink, insertion or deletion sites (.bed[.gz]), see "htseq-clip extract -h"
  -o output file, --output output file
                        output count file (.txt[.gz], default: print to console)
  -a annotation, --ann annotation
                        flattened annotation file (.bed[.gz]) 
                            See "htseq-clip annotation -h" OR sliding window annotation file (.bed[.gz]), see "htseq-clip createSlidingWindows -h"
  --unstranded          crosslink site counting is strand specific by default. 
                            Use this flag for non strand specific crosslink site counting
  --copy_tmp            In certain cases, gzip crashes on while running "htseq-clip count" with a combination of Slurm and Snakemake.
                            Copying files to the local temp. folder seems to get rid of the issue. Use this flag to copy files to a tmp. folder. 
                            Default: use system specific "tmp" folder, use argument "--tmp" to specify a custom one
  -t temp. directory, --tmp temp. directory
                        temp. directory path to copy files (default: None, use system tmp directory)
  -v Verbose level, --verbose Verbose level
                        Allowed choices: debug, info, warn, quiet (default: info)
```


## htseq-clip_createmtrix

### Tool Description
htseq-clip: error: argument subparser: invalid choice: 'createmtrix' (choose from 'annotation', 'createSlidingWindows', 'mapToId', 'extract', 'count', 'createMatrix', 'createMaxCountMatrix', 'trimAnnotation')

### Metadata
- **Docker Image**: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
- **Homepage**: https://github.com/EMBL-Hentze-group/htseq-clip
- **Package**: https://anaconda.org/channels/bioconda/packages/htseq-clip/overview
- **Validation**: PASS

### Original Help Text
```text
usage: htseq-clip [-h] [-v]
                  {annotation,createSlidingWindows,mapToId,extract,count,createMatrix,createMaxCountMatrix,trimAnnotation}
                  ...
htseq-clip: error: argument subparser: invalid choice: 'createmtrix' (choose from 'annotation', 'createSlidingWindows', 'mapToId', 'extract', 'count', 'createMatrix', 'createMaxCountMatrix', 'trimAnnotation')
```


## htseq-clip_createmaxcountmatrix

### Tool Description
htseq-clip: error: argument subparser: invalid choice: 'createmaxcountmatrix' (choose from 'annotation', 'createSlidingWindows', 'mapToId', 'extract', 'count', 'createMatrix', 'createMaxCountMatrix', 'trimAnnotation')

### Metadata
- **Docker Image**: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
- **Homepage**: https://github.com/EMBL-Hentze-group/htseq-clip
- **Package**: https://anaconda.org/channels/bioconda/packages/htseq-clip/overview
- **Validation**: PASS

### Original Help Text
```text
usage: htseq-clip [-h] [-v]
                  {annotation,createSlidingWindows,mapToId,extract,count,createMatrix,createMaxCountMatrix,trimAnnotation}
                  ...
htseq-clip: error: argument subparser: invalid choice: 'createmaxcountmatrix' (choose from 'annotation', 'createSlidingWindows', 'mapToId', 'extract', 'count', 'createMatrix', 'createMaxCountMatrix', 'trimAnnotation')
```


## htseq-clip_trimannotation

### Tool Description
htseq-clip: error: argument subparser: invalid choice: 'trimannotation' (choose from 'annotation', 'createSlidingWindows', 'mapToId', 'extract', 'count', 'createMatrix', 'createMaxCountMatrix', 'trimAnnotation')

### Metadata
- **Docker Image**: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
- **Homepage**: https://github.com/EMBL-Hentze-group/htseq-clip
- **Package**: https://anaconda.org/channels/bioconda/packages/htseq-clip/overview
- **Validation**: PASS

### Original Help Text
```text
usage: htseq-clip [-h] [-v]
                  {annotation,createSlidingWindows,mapToId,extract,count,createMatrix,createMaxCountMatrix,trimAnnotation}
                  ...
htseq-clip: error: argument subparser: invalid choice: 'trimannotation' (choose from 'annotation', 'createSlidingWindows', 'mapToId', 'extract', 'count', 'createMatrix', 'createMaxCountMatrix', 'trimAnnotation')
```


## Metadata
- **Skill**: generated
