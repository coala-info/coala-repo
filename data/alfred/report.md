# alfred CWL Generation Report

## alfred_qc

### Tool Description
Quality control for aligned sequencing reads

### Metadata
- **Docker Image**: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/alfred
- **Package**: https://anaconda.org/channels/bioconda/packages/alfred/overview
- **Validation**: PASS
- **manual**: https://www.gear-genomics.com/docs/alfred/cli/

- **Conda**: https://anaconda.org/channels/bioconda/packages/alfred/overview
- **Total Downloads**: 179.4K
- **Last updated**: 2025-08-22
- **GitHub**: https://github.com/tobiasrausch/alfred
- **Stars**: N/A
### Original Help Text
```text
Usage: alfred qc [OPTIONS] -r <ref.fa> -j <qc.json.gz> <aligned.bam>

Generic options:
  -? [ --help ]            show help message
  -r [ --reference ] arg   reference fasta file (required)
  -b [ --bed ] arg         bed file with target regions (optional)
  -a [ --name ] arg        sample name (optional, otherwise SM tag is used)
  -j [ --jsonout ] arg     gzipped json output file
  -o [ --outfile ] arg     gzipped tsv output file
  -m [ --meancov ]         report mean coverage as float instead of median 
                           integer coverage
  -s [ --secondary ]       evaluate secondary alignments
  -u [ --supplementary ]   evaluate supplementary alignments

Read-group options:
  -g [ --rg ] arg          only analyze this read group (optional)
  -i [ --ignore ]          ignore read-groups
```


## alfred_count_dna

### Tool Description
Count DNA coverage and fragments from aligned BAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/alfred
- **Package**: https://anaconda.org/channels/bioconda/packages/alfred/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: alfred count_dna [OPTIONS] <aligned.bam>

Generic options:
  -? [ --help ]                        show help message
  -m [ --map-qual ] arg (=10)          min. mapping quality
  -o [ --outfile ] arg (="cov.gz")     coverage output file
  -f [ --fragments ] arg               count illumina PE fragments using lower 
                                       and upper bound on insert size, i.e. -f 
                                       0,10000

Window options:
  -s [ --window-size ] arg (=10000)    window size
  -t [ --window-offset ] arg (=10000)  window offset
  -n [ --window-num ] arg (=0)         #windows per chr, used if #n>0
  -i [ --interval-file ] arg           interval file, used if present
```


## alfred_count_rna

### Tool Description
RNA-seq counting tool for GTF/GFF3 or BED files

### Metadata
- **Docker Image**: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/alfred
- **Package**: https://anaconda.org/channels/bioconda/packages/alfred/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: alfred count_rna [OPTIONS] -g <hg19.gtf.gz> <aligned.bam>
Usage: alfred count_rna [OPTIONS] -b <hg19.bed.gz> <aligned.bam>

Generic options:
  -? [ --help ]                         show help message
  -m [ --map-qual ] arg (=10)           min. mapping quality
  -s [ --stranded ] arg (=0)            strand-specific counting (0: 
                                        unstranded, 1: stranded, 2: reverse 
                                        stranded)
  -n [ --normalize ] arg (=raw)         normalization [raw|fpkm|fpkm_uq]
  -o [ --outfile ] arg (="gene.count")  output file
  -a [ --ambiguous ]                    count ambiguous readsd

GTF/GFF3 input file options:
  -g [ --gtf ] arg                      gtf/gff3 file
  -i [ --id ] arg (=gene_id)            gtf/gff3 attribute
  -f [ --feature ] arg (=exon)          gtf/gff3 feature

BED input file options, columns chr, start, end, name [, score, strand, gene_biotype]:
  -b [ --bed ] arg                      bed file
```


## alfred_count_jct

### Tool Description
Count exon-exon junction reads from aligned BAM files using GTF/GFF3 or BED annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/alfred
- **Package**: https://anaconda.org/channels/bioconda/packages/alfred/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: alfred count_jct [OPTIONS] -g <hg19.gtf.gz> <aligned.bam>

Generic options:
  -? [ --help ]                         show help message
  -m [ --map-qual ] arg (=10)           min. mapping quality
  -s [ --stranded ] arg (=0)            strand-specific counting (0: 
                                        unstranded, 1: stranded, 2: reverse 
                                        stranded)
  -o [ --outintra ] arg (="intra.tsv")  intra-gene exon-exon junction reads
  -p [ --outinter ] arg (="inter.tsv")  inter-gene exon-exon junction reads
  -n [ --outnovel ] arg                 output file for not annotated 
                                        intra-chromosomal junction reads

GTF/GFF3 input file options:
  -g [ --gtf ] arg                      gtf/gff3 file
  -i [ --id ] arg (=gene_id)            gtf/gff3 attribute
  -f [ --feature ] arg (=exon)          gtf/gff3 feature

BED input file options, columns chr, start, end, name [, score, strand]:
  -b [ --bed ] arg                      bed file
```


## alfred_tracks

### Tool Description
Generate track files from aligned BAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/alfred
- **Package**: https://anaconda.org/channels/bioconda/packages/alfred/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: alfred tracks [OPTIONS] <aligned.bam>

Generic options:
  -? [ --help ]                         show help message
  -m [ --map-qual ] arg (=10)           min. mapping quality
  -n [ --normalize ] arg (=30000000)    #pairs to normalize to (0: no 
                                        normalization)
  -c [ --covtype ] arg (=0)             coverage type (0: sequencing coverage, 
                                        1: spanning coverage, 2: footprinting)

Resolution options (bedgraph/bed format):
  -r [ --resolution ] arg (=0.200000003)
                                        fractional resolution ]0,1]

Output options:
  -o [ --outfile ] arg (="track.gz")    track file
  -f [ --format ] arg (=bedgraph)       output format [bedgraph|bed|wiggle|raw]
```


## alfred_annotate

### Tool Description
Annotate peaks with GTF/GFF3, BED, or motif information.

### Metadata
- **Docker Image**: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/alfred
- **Package**: https://anaconda.org/channels/bioconda/packages/alfred/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: alfred annotate [OPTIONS] -g <hg19.gtf.gz> <peaks.bed>
Usage: alfred annotate [OPTIONS] -b <hg19.bed.gz> <peaks.bed>
Usage: alfred annotate [OPTIONS] -m <motif.jaspar.gz> -r <genome.fa> <peaks.bed>

Generic options:
  -? [ --help ]                         show help message
  -d [ --distance ] arg (=0)            max. distance (0: overlapping features 
                                        only)
  -u [ --outgene ] arg (="gene.bed")    gene/motif-level output
  -o [ --outfile ] arg (="anno.bed")    annotated peaks output
  -n [ --nearest ]                      nearest feature only

GTF/GFF3 annotation file options:
  -g [ --gtf ] arg                      gtf/gff3 file
  -i [ --id ] arg (=gene_name)          gtf/gff3 attribute
  -f [ --feature ] arg (=gene)          gtf/gff3 feature

BED annotation file options, columns chr, start, end, name:
  -b [ --bed ] arg                      bed file

Motif annotation file options:
  -m [ --motif ] arg                    motif file in jaspar or raw format
  -r [ --reference ] arg                reference file
  -q [ --quantile ] arg (=0.949999988)  motif quantile score [0,1]
  -p [ --position ] arg                 gzipped output file of motif hits
  -x [ --exclude ]                      exclude overlapping hits of the same 
                                        motif
```


## alfred_spaced_motif

### Tool Description
Identify and join spaced motifs from motif hits

### Metadata
- **Docker Image**: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/alfred
- **Package**: https://anaconda.org/channels/bioconda/packages/alfred/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: alfred spaced_motif [OPTIONS] <motif.hits.gz>

Generic options:
  -? [ --help ]                         show help message
  -m [ --motif1 ] arg (=Heptamer)       motif1 name
  -n [ --motif2 ] arg (=Nonamer)        motif2 name
  -l [ --spacer-low ] arg (=11)         min. spacer length
  -h [ --spacer-high ] arg (=13)        max. spacer length
  -o [ --outfile ] arg (="joined.bed.gz")
                                        joined motif hits
```


## alfred_split

### Tool Description
Split unphased BAM files into haplotype-specific BAM files using phased variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/alfred
- **Package**: https://anaconda.org/channels/bioconda/packages/alfred/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: alfred split [OPTIONS] -r <ref.fa> -s NA12878 -v <snps.bcf> <unphased.bam>

Generic options:
  -? [ --help ]                   show help message
  -m [ --map-qual ] arg (=10)     min. mapping quality
  -r [ --reference ] arg          reference fasta file
  -p [ --hap1 ] arg (="h1.bam")   haplotype1 output file
  -q [ --hap2 ] arg (="h2.bam")   haplotype2 output file
  -s [ --sample ] arg (=NA12878)  sample name (as in BCF)
  -v [ --vcffile ] arg            input phased VCF/BCF file
  -a [ --assign ]                 assign unphased reads randomly
  -i [ --interleaved ]            single haplotype-tagged BAM
```


## alfred_consensus

### Tool Description
Generate consensus sequences from BAM or FASTA files

### Metadata
- **Docker Image**: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/alfred
- **Package**: https://anaconda.org/channels/bioconda/packages/alfred/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: alfred consensus [OPTIONS] <input.bam|input.fa.gz>

Generic options:
  -? [ --help ]                         show help message
  -f [ --format ] arg (=bam)            input format [bam|fasta]
  -d [ --called ] arg (=0.5)            fraction of reads required for 
                                        consensus
  -t [ --seqtype ] arg (=ill)           seq. type [ill|ont|pacbio|custom]

BAM input options:
  -q [ --mapqual ] arg (=10)            min. mapping quality
  -p [ --position ] arg (=chr4:500500)  position to generate consensus
  -w [ --window ] arg                   window around pos that reads need to 
                                        span
  -z [ --genome ] arg                   genome [req. for CRAM decoding]
  -s [ --secondary ]                    consider secondary alignments
  -r [ --trimreads ]                    trim reads to window

Alignment scoring options for 'custom' sequencing type:
  -g [ --gapopen ] arg (=-10)           gap open
  -e [ --gapext ] arg (=-1)             gap extension
  -m [ --match ] arg (=5)               match
  -n [ --mismatch ] arg (=-4)           mismatch

Output options:
  -u [ --outformat ] arg (=v)           output format [v|h]
  -a [ --alignment ] arg (="al.fa.gz")  vertical/horizontal alignment
  -c [ --consensus ] arg (="cs.fa.gz")  consensus
```


## alfred_pwalign

### Tool Description
Pairwise sequence alignment of two FASTA files

### Metadata
- **Docker Image**: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/alfred
- **Package**: https://anaconda.org/channels/bioconda/packages/alfred/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: alfred pwalign [OPTIONS] <seq1.fasta> <seq2.fasta>

Generic options:
  -? [ --help ]                         show help message
  -g [ --gapopen ] arg (=-10)           gap open
  -e [ --gapext ] arg (=-1)             gap extension
  -m [ --match ] arg (=5)               match
  -n [ --mismatch ] arg (=-4)           mismatch
  -p [ --endsfree1 ]                    leading/trailing gaps free for seq1
  -q [ --endsfree2 ]                    leading/trailing gaps free for seq2
  -l [ --local ]                        local alignment
  -k [ --ambiguous ]                    allow IUPAC ambiguity codes

Output options:
  -f [ --format ] arg (=h)              output format [v|h]
  -a [ --alignment ] arg (="al.fa.gz")  vertical/horizontal alignment
```


## alfred_pwedit

### Tool Description
Pairwise sequence alignment and editing tool

### Metadata
- **Docker Image**: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/alfred
- **Package**: https://anaconda.org/channels/bioconda/packages/alfred/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: alfred pwedit [OPTIONS] <target.fasta> <query.fasta>

Generic options:
  -? [ --help ]                         show help message
  -m [ --mode ] arg (=infix)            alignment mode [global|prefix|infix]
  -r [ --revcomp ]                      reverse complement query

Output options:
  -f [ --format ] arg (=h)              output format [v|h]
  -a [ --alignment ] arg (="al.fa.gz")  vertical/horizontal alignment
```


## alfred_bam2match

### Tool Description
Extract matches from a BAM file against a reference genome

### Metadata
- **Docker Image**: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/alfred
- **Package**: https://anaconda.org/channels/bioconda/packages/alfred/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: alfred bam2match [OPTIONS] -r <ref.fa> <contig.bam>

Generic options:
  -? [ --help ]                       show help message
  -m [ --map-qual ] arg (=0)          min. mapping quality
  -r [ --reference ] arg              reference fasta file
  -o [ --outfile ] arg (="match.gz")  gzipped output file
```


## alfred_ase

### Tool Description
Allele-specific expression analysis using alfred

### Metadata
- **Docker Image**: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/alfred
- **Package**: https://anaconda.org/channels/bioconda/packages/alfred/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: alfred ase [OPTIONS] -r <ref.fa> -s NA12878 -v <snps.bcf> -a <ase.tsv> <input.bam>

Generic options:
  -? [ --help ]                    show help message
  -m [ --map-qual ] arg (=10)      min. mapping quality
  -b [ --base-qual ] arg (=10)     min. base quality
  -r [ --reference ] arg           reference fasta file
  -s [ --sample ] arg (=NA12878)   sample name
  -a [ --ase ] arg (="as.tsv.gz")  allele-specific output file
  -v [ --vcffile ] arg             input (phased) BCF file
  -p [ --phased ]                  BCF file is phased and BAM is haplo-tagged
  -f [ --full ]                    output all het. input SNPs
```


## alfred_replication

### Tool Description
Alfred replication analysis tool for analyzing replication timing using BAM files and a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/alfred
- **Package**: https://anaconda.org/channels/bioconda/packages/alfred/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: alfred replication [OPTIONS] -r <ref.fa> -o outprefix <g1b.bam> <s1.bam> <s2.bam> <s3.bam> <s4.bam> <g2.bam>

Generic options:
  -? [ --help ]                   show help message
  -q [ --qual ] arg (=1)          min. mapping quality
  -w [ --window ] arg (=50000)    sliding window size
  -s [ --step ] arg (=1000)       window offset (step size)
  -r [ --reference ] arg          reference fasta file (required)
  -o [ --outprefix ] arg (=pref)  output file prefix
```


## alfred_telmotif

### Tool Description
Identify telomeric motifs in sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/alfred
- **Package**: https://anaconda.org/channels/bioconda/packages/alfred/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: alfred telmotif [OPTIONS] -r <ref.fa> -o outprefix <input.bam>

Generic options:
  -? [ --help ]                         show help message
  -q [ --quality ] arg (=20)            min. sequence quality
  -w [ --wsize ] arg (=1000)            window size
  -r [ --reference ] arg                reference fasta file (required)
  -o [ --outfile ] arg (="neotelomere.bed")
                                        output file
```


## alfred_barcode

### Tool Description
Generate Hamming-distanced barcodes for sequencing experiments.

### Metadata
- **Docker Image**: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/alfred
- **Package**: https://anaconda.org/channels/bioconda/packages/alfred/overview
- **Validation**: PASS

### Original Help Text
```text
[2026-Feb-24 15:58:58] alfred barcode 
[2026-Feb-24 15:58:58] Loaded/Generated 4096 barcode candidates
[2026-Feb-24 15:58:58] Removed 3016 barcodes because of low entropy
[2026-Feb-24 15:58:58] Iteration 1: Removed 3556 because of low entropy or hamming distance
[2026-Feb-24 15:58:58] Iteration 2: Removed 3826 because of low entropy or hamming distance
[2026-Feb-24 15:58:58] Iteration 3: Removed 3959 because of low entropy or hamming distance
[2026-Feb-24 15:58:58] Iteration 4: Removed 4022 because of low entropy or hamming distance
[2026-Feb-24 15:58:58] Iteration 5: Removed 4048 because of low entropy or hamming distance
[2026-Feb-24 15:58:58] Iteration 6: Removed 4060 because of low entropy or hamming distance
[2026-Feb-24 15:58:58] Iteration 7: Removed 4065 because of low entropy or hamming distance
[2026-Feb-24 15:58:58] Iteration 8: Removed 4067 because of low entropy or hamming distance
[2026-Feb-24 15:58:58] Iteration 9: Removed 4067 because of low entropy or hamming distance
[2026-Feb-24 15:58:58] Done.
```


## alfred_bcsplit

### Tool Description
Split FASTQ files based on barcodes and UMIs

### Metadata
- **Docker Image**: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/alfred
- **Package**: https://anaconda.org/channels/bioconda/packages/alfred/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: alfred bcsplit [OPTIONS] -i index.fq.gz -b bar.tsv reads.fq.gz

Generic options:
  -? [ --help ]                         show help message
  -a [ --hamming ] arg (=0)             max. hamming distance to barcode
  -n [ --ncount ] arg (=0)              max. number of Ns per barcode
  -b [ --barcodes ] arg                 barcode file [barcode, id]
  -i [ --idxfile ] arg                  input index FASTQ file
  -p [ --pattern ] arg (=BBBBBBBBUUUUUU)
                                        index read pattern [U: UMI, B: Barcode,
                                        N: Ignore]
  -o [ --outprefix ] arg (=split)       output prefix
```


## Metadata
- **Skill**: generated
