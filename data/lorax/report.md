# lorax CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| lorax_amplicon | PASS | synthetic data: simulated PacBio toy set from the longshot repo with a made-up amplicon BED; copy numbers near 2 and no discordant reads, as expected |
| lorax_components | PASS |  |
| lorax_convert | Failed | tool bug: the output is plain SAM text and the CIGAR misses the trailing soft clip, so samtools rejects the records |
| lorax_ecov | PASS | synthetic data: handmade GAF walking real edges of a real graph; edge supports 8, 5 and 3 match |
| lorax_extract | PASS |  |
| lorax_gfa2dot | PASS |  |
| lorax_ncov | PASS | node coverage matches the GAF match counts per segment (minigraph alignments of real haplotype sequences) |
| lorax_pct | PASS |  |
| lorax_repeat | PASS |  |
| lorax_stats | PASS |  |
| lorax_telomere | PASS |  |
| lorax_tithreads | Not completed | ran on a real tumor and normal pair (5 percent chr22 subset) but found no templated insertion threads, so the output has only headers and cannot be checked |

## lorax_tithreads

### Tool Description
Tells you the ploidy of a tumor sample based on its BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/lorax
- **Package**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-07-02
- **GitHub**: https://github.com/tobiasrausch/lorax
- **Stars**: N/A
### Original Help Text
```text
Usage: lorax tithreads [OPTIONS] -g <ref.fa> -m <control.bam> <tumor.bam>

Options:
  -? [ --help ]                       show help message
  -q [ --qual ] arg (=1)              min. mapping quality
  -c [ --clip ] arg (=25)             min. clipping length
  -s [ --split ] arg (=3)             min. split-read support
  -p [ --ploidy ] arg (=2)            ploidy
  -l [ --chrlen ] arg (=40000000)     min. chromosome length
  -i [ --minsize ] arg (=100)         min. segment size
  -j [ --maxsize ] arg (=10000)       max. segment size
  -n [ --contam ] arg (=0)            max. fractional tumor-in-normal 
                                      contamination
  -e [ --entropy ] arg (=1.79999995)  min. sequence entropy
  -d [ --sd ] arg (=3)                SD for coverage deviation
  -g [ --genome ] arg                 genome fasta file
  -m [ --matched ] arg                matched control BAM
  -o [ --outprefix ] arg (=out)       output prefix
```


## lorax_amplicon

### Tool Description
Amplicon analysis tool

### Metadata
- **Docker Image**: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/lorax
- **Package**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lorax amplicon [OPTIONS] -g <ref.fa> -b amplicons.bed -s NA12878 -v <snps.bcf> <tumor.bam>

Options:
  -? [ --help ]                   show help message
  -q [ --quality ] arg (=10)      min. sequence quality
  -c [ --minclip ] arg (=100)     min. clipping length
  -n [ --wincov ] arg (=1000)     coverage window length
  -u [ --uncertain ] arg (=1000)  breakpoint uncertainty (in bp)
  -p [ --ploidy ] arg (=2)        ploidy
  -s [ --sample ] arg (=NA12878)  sample name (as in VCF/BCF file)
  -v [ --vcffile ] arg            input VCF/BCF file
  -b [ --bedfile ] arg            amplicon regions in BED format
  -g [ --genome ] arg             genome fasta file
  -o [ --outprefix ] arg (=out)   output prefix
```


## lorax_pct

### Tool Description
Calculate and output statistics about the alignment of a sample to a reference genome or pan-genome graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/lorax
- **Package**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
Linear reference genome: lorax pct [OPTIONS] -r <ref.fa> <sample.bam>
Pan-genome graph: lorax pct [OPTIONS] <sample.gaf.gz>

Generic options:
  -? [ --help ]                      show help message
  -r [ --reference ] arg             genome fasta file
  -o [ --outfile ] arg (="out.tsv")  output statistics
```


## lorax_extract

### Tool Description
Extracts reads from a BAM file based on a list of reads and a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/lorax
- **Package**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lorax extract [OPTIONS] -g <genome.fa> -r <reads.lst> <contig.bam>

Generic options:
  -? [ --help ]                         show help message
  -g [ --genome ] arg                   reference fasta file
  -r [ --reads ] arg                    list of reads
  -o [ --outfile ] arg (="out.match.gz")
                                        gzipped match file
  -f [ --fafile ] arg (="out.fa.gz")    gzipped fasta/q file
  -a [ --hashes ]                       list of reads are hashes
  -q [ --fastq ]                        output fastq
```


## lorax_telomere

### Tool Description
Identify telomeric repeats in BAM or FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/lorax
- **Package**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lorax telomere [OPTIONS] -g <ref.fa> <tumor.bam>
       lorax telomere [OPTIONS] <reads.fasta>

Options:
  -? [ --help ]                         show help message
  -c [ --minclip ] arg (=18)            min. clipping length
  -m [ --movavg ] arg (=51)             rolling average window
  -s [ --medsize ] arg (=501)           rolling median window
  -t [ --thres ] arg (=0.34999999999999998)
                                        repeat threshold
  -l [ --chrlen ] arg (=40000000)       min. chromosome length
  -r [ --repeats ] arg (=TTAGGG,TCAGGG,TGAGGG,TTGGGG)
                                        repeat units
  -g [ --genome ] arg                   genome fasta file
  -o [ --outprefix ] arg (=out)         output file prefix
```


## lorax_repeat

### Tool Description
Finds tandem repeats in a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/lorax
- **Package**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lorax repeat [OPTIONS] <ref.fa>

Options:
  -? [ --help ]                         show help message
  -l [ --chrlen ] arg (=40000000)       min. chromosome length
  -r [ --repeats ] arg (=TTAGGG,TCAGGG,TGAGGG,TTGGGG)
                                        repeat units
  -p [ --period ] arg (=3)              repeat period
  -w [ --window ] arg (=1000)           window length
  -e [ --chrend ] arg (=0)              chromosome end window [0: deactivate]
  -o [ --outfile ] arg (="out.tsv")     output file
  -n [ --nomix ]                        do not mix repeat units
```


## lorax_stats

### Tool Description
Basic statistics of a pan-genome graph (GFA).

### Metadata
- **Docker Image**: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/lorax
- **Package**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
lorax stats [OPTIONS] <pangenome.hg38.gfa.gz>

Generic options:
  -? [ --help ]          show help message
  -o [ --outfile ] arg   output file
```

## lorax_components

### Tool Description
Connected components of a pan-genome graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/lorax
- **Package**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
lorax components [OPTIONS] <pangenome.hg38.gfa.gz>

Generic options:
  -? [ --help ]          show help message
  -p [ --prefix ] arg    output prefix to split graph into components
  -o [ --outfile ] arg   output file
```

## lorax_gfa2dot

### Tool Description
Convert a pan-genome graph (GFA) to dot (graphviz) format.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/lorax
- **Package**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: loraxgfa2dot [OPTIONS] <pangenome.hg38.gfa.gz>
Convert entire graph: lorax gfa2dot [OPTIONS] -s all <pangenome.hg38.gfa.gz>
Convert a subgraph: lorax gfa2dot [OPTIONS] -s s103 -r 1 <pangenome.hg38.gfa.gz>
Convert a connected component: lorax gfa2dot [OPTIONS] -s comp -c 20 <pangenome.hg38.gfa.gz>

Generic options:
  -? [ --help ]                show help message
  -r [ --radius ] arg (=1)     radius around selected node
  -c [ --component ] arg (=0)  select a component of the graph
  -s [ --segment ] arg (=all)  segment to plot (all: all segments, comp: 
                               connected component of the graph)
  -o [ --outfile ] arg         output dot file
```

## lorax_convert

### Tool Description
Convert a pan-genome graph alignment (GAF) to BAM.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/lorax
- **Package**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
Using BAM/CRAM: lorax convert [OPTIONS] -g <pangenome.gfa.gz> -r <genome.fasta> -a <align.bam> <sample.gaf.gz>
Using FASTQ: lorax convert [OPTIONS] -g <pangenome.gfa.gz> -f <reads.fa.gz> <sample.gaf.gz>

Generic options:
  -? [ --help ]                       show help message
  -c [ --chunk ] arg (=500000)        chunk size [0: all at once]
  -g [ --graph ] arg                  GFA pan-genome graph
  -r [ --reference ] arg              FASTA reference
  -a [ --align ] arg                  BAM/CRAM file
  -f [ --fastq ] arg                  FASTA/FASTQ file
  -s [ --sequences ] arg (="out.fa")  output sequences
  -o [ --outfile ] arg                output alignments
```

## lorax_ncov

### Tool Description
Node coverage of a pan-genome graph from graph alignments (GAF).

### Metadata
- **Docker Image**: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/lorax
- **Package**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
lorax ncov [OPTIONS] -g <pangenome.gfa.gz> <sample.gaf.gz>

Generic options:
  -? [ --help ]          show help message
  -g [ --graph ] arg     GFA pan-genome graph
  -o [ --outfile ] arg   output statistics
  -n [ --name ] arg      sample name
```

## lorax_ecov

### Tool Description
Edge coverage of a pan-genome graph from graph alignments (GAF).

### Metadata
- **Docker Image**: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/lorax
- **Package**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
lorax ecov [OPTIONS] -g <pangenome.hg38.gfa.gz> <sample.gaf>

Generic options:
  -? [ --help ]          show help message
  -g [ --graph ] arg     GFA pan-genome graph
  -o [ --outfile ] arg   output statistics
  -n [ --name ] arg      sample name
```

## Metadata
- **Skill**: generated
