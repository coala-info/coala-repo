# gapless CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gapless_extend | PASS | synthetic data: planted 100 bp gaps in a real bacterial genome (nf-core test data) with real nanopore reads |
| gapless_finish | PASS | synthetic data: planted 100 bp gaps in a real bacterial genome (nf-core test data) with real nanopore reads |
| gapless_gapless.sh | Failed | image problem: minimap2, racon and seqtk are missing in the image, so the pipeline crashes at the scaffold step |
| gapless_scaffold | PASS | synthetic data: planted 100 bp gaps in a real genome with real nanopore reads; the --stats plot option crashes in the image and --minLenBreak is rejected by the tool |
| gapless_split | PASS | synthetic data: planted 100 bp gaps in a real bacterial genome (nf-core test data) |
| gapless_visualize | Failed | tool bug: it loads a font from the relative path Pillow/Tests/fonts/FreeMono.ttf, which does not exist, so no PDF is written |

## gapless_gapless.sh

### Tool Description
Improves input assembly with reads in {long_reads}.fq using gapless, minimap2, racon and seqtk

### Metadata
- **Docker Image**: quay.io/biocontainers/gapless:0.4--hdfd78af_0
- **Homepage**: https://github.com/schmeing/gapless
- **Package**: https://anaconda.org/channels/bioconda/packages/gapless/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gapless/overview
- **Total Downloads**: 2.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/schmeing/gapless
- **Stars**: N/A
### Original Help Text
```text
Usage: gapless.sh [OPTIONS] {long_reads}.fq
Improves input assembly with reads in {long_reads}.fq using gapless, minimap2, racon and seqtk
  -h -?                    Display this help and exit
  -i [STRING]              Input assembly (fasta)
  -j [INT]                 Number of threads [4]
  -n [INT]                 Number of iterations [3]
  -o [STRING]              Output directory (improved assembly is written to gapless.fa in this directory) [gapless_run]
  -r                       Restart at the start iteration and overwrite instead of incorporat already present files
  -s [INT]                 Start iteration (Previous runs must be present in output directory) [1]
  -t [STRING]              Type of long reads ('pb_clr','pb_hifi','nanopore')
```


## gapless_split

### Tool Description
Splits scaffolds into contigs.

### Metadata
- **Docker Image**: quay.io/biocontainers/gapless:0.4--hdfd78af_0
- **Homepage**: https://github.com/schmeing/gapless
- **Package**: https://anaconda.org/channels/bioconda/packages/gapless/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gapless.py split [OPTIONS] {assembly}.fa
Splits scaffolds into contigs.
  -h, --help                Display this help and exit
  -n, --minN [int]          Minimum number of N's to split at that position (1)
  -o, --output FILE.fa      File to which the split sequences should be written to ({assembly}_split.fa)
```

## gapless_scaffold

### Tool Description
Scaffolds contigs and assigns reads to gaps.

### Metadata
- **Docker Image**: quay.io/biocontainers/gapless:0.4--hdfd78af_0
- **Homepage**: https://github.com/schmeing/gapless
- **Package**: https://anaconda.org/channels/bioconda/packages/gapless/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gapless.py scaffold [OPTIONS] {assembly}.fa {mapping}.paf {repeat}.paf
Scaffolds contigs and assigns reads to gaps.
  -h, --help                Display this help and exit
  -p, --prefix FILE         Prefix for output files ({assembly})
  -s, --stats FILE.pdf      Output file for plots with statistics regarding input parameters (deactivated)
      --minLenBreak INT     Minimum length for a read to diverge from a contig to consider a contig break (600)
      --minMapLength INT    Minimum length of individual mappings of reads (400)
      --minMapQ INT         Minimum mapping quality of reads (20)
```

## gapless_extend

### Tool Description
Extend scaffold ends with reads reaching over the ends.

### Metadata
- **Docker Image**: quay.io/biocontainers/gapless:0.4--hdfd78af_0
- **Homepage**: https://github.com/schmeing/gapless
- **Package**: https://anaconda.org/channels/bioconda/packages/gapless/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gapless.py extend -p {prefix} {all_vs_all}.paf
Extend scaffold ends with reads reaching over the ends.
  -h, --help                Display this help and exit
  -p, --prefix FILE         Prefix for output files of scaffolding step (mandatory)
      --minLenBreak INT     Minimum length for two reads to diverge to consider them incompatible for this contig (1000)
```

## gapless_finish

### Tool Description
Creates previously defined scaffolds.

### Metadata
- **Docker Image**: quay.io/biocontainers/gapless:0.4--hdfd78af_0
- **Homepage**: https://github.com/schmeing/gapless
- **Package**: https://anaconda.org/channels/bioconda/packages/gapless/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gapless.py finish [OPTIONS] -s {scaffolds}.csv {assembly}.fa {reads}.fq
Creates previously defined scaffolds. Only providing necessary reads increases speed and substantially reduces memory requirements.
  -h, --help                Display this help and exit
  -f, --format FORMAT       Format of {reads}.fq (fasta/fastq) (Default: fastq if not determinable from read ending)
  -H, --hap INT             Haplotype starting from 0 written to {output} (default: mixed)
  --hap[1-9] INT            Haplotypes starting from 0 written to {out[1-9]} (default: mixed)
  -o, --output FILE.fa      Output file for modified assembly ({assembly}_gapless.fa)
  --out[1-9] FILE.fa        Additional output files for modified assembly (deactivated)
  -p, --polishing FILE.fa   Input file for polishing read information
  -s, --scaffolds FILE.csv  Csv file from previous steps describing the scaffolding (mandatory)
```

## gapless_visualize

### Tool Description
Visualizes specified regions to manually inspect breaks or joins.

### Metadata
- **Docker Image**: quay.io/biocontainers/gapless:0.4--hdfd78af_0
- **Homepage**: https://github.com/schmeing/gapless
- **Package**: https://anaconda.org/channels/bioconda/packages/gapless/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gapless.py visualize [OPTIONS] -o {output}.pdf {mapping}.paf {scaffold}:{start}-{end} [{scaffold}:{start}-{end} ...]
Visualizes specified regions to manually inspect breaks or joins.
  -h, --help                Display this help and exit
  -o, --output FILE.pdf     Output file for visualization (mandatory)
      --keepAllSubreads     Shows all subreads instead of only the best
      --minLenBreak INT     Minimum length for a read to diverge from a contig to consider a contig break (600)
      --minMapLength INT    Minimum length of individual mappings of reads (400)
      --minMapQ INT         Minimum mapping quality of reads (20)
```

## Metadata
- **Skill**: generated
