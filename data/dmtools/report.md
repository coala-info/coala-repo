# dmtools CWL Generation Report

## dmtools_index

### Tool Description
Index a genome for dmtools.

### Metadata
- **Docker Image**: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
- **Homepage**: https://github.com/ZhouQiangwei/dmtools
- **Package**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Total Downloads**: 776
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ZhouQiangwei/dmtools
- **Stars**: N/A
### Original Help Text
```text
Command Format :  dmtools index [options] -g genome.fa

Usage: dmtools index -g genome.fa
	-g|--genome           genome fasta file
	--taps                alignment TAPS reads with bwa mem
	-h|--help
```


## dmtools_align

### Tool Description
Align reads to a genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
- **Homepage**: https://github.com/ZhouQiangwei/dmtools
- **Package**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Validation**: PASS

### Original Help Text
```text
Command Format :  dmtools align [options] -g genome.fa -1 te1.fq -2 te2.fq -g genome.fa -o meth.bam

Usage: dmtools align -1 te1.fq -2 te2.fq -g genome.fa -o meth.bam
	 [align] mode paramaters, required
	-g|--genome           genome fasta file
	-i                    input file, support .fq/.fastq and .gz/.gzip format. if paired-end. please use -1, -2
	-1                    input file left end, if single-end. please use -i
	-2                    input file right end
	--fastp               fastp program location for fastq preprocess.
	                      if --fastp is not defined, the input file should be clean data.
	-o|--out              Prefix of bam output file
	 [align] mode paramaters, options
	-p                    [int] threads
	--taps                alignment TAPS reads with bwa mem
	-h|--help
```


## dmtools_bam2dm

### Tool Description
Convert BAM files to DM format for methylation ratio and chromatin accessibility analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
- **Homepage**: https://github.com/ZhouQiangwei/dmtools
- **Package**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Validation**: PASS

### Original Help Text
```text
Command Format :  dmtools bam2dm [options] -g genome.fa -b <BamfileSorted> -o <methratio dm outfile prefix>

Usage: dmtools bam2dm -C -S --Cx -g genome.fa -b align.sort.bam -o meth.dm
   or: dmtools bam2dm -C -S -g genome.fa -b test.sort.bam -o meth.dm --NoMe (meth.dm file for methylation level, methdm.gch.dm for chromatin accessibility)
	 [bam2dm] mode paramaters, required
	-g|--genome           genome fasta file
	-b|--binput           Bam format file, sorted by chrom.
	-o|--out              Prefix of methratio.dm output file
	 [bam2dm] mode paramaters, options
	-n|--Nmismatch        Number of mismatches, default 0.06 percentage of read length. [0-1]
	-Q                    caculate the methratio while read QulityScore >= Q. default:20
	-c|--coverage         >= <INT> coverage. default:4
	--maxcoverage         <= <INT> coverage. default:500
	-nC                   >= <INT> nCs per region. default:1
	-r|--remove_dup       REMOVE_DUP, default:false
	--mrtxt               print prefix.methratio.txt file
	--cf                  context filter for print results, C, CG, CHG, CHH, default: C
	--NoMe                data type for NoMe-seq
	[DM format] paramaters
	--zl                  The maximum number of zoom levels. [0-10], default: 2
	-C                    print coverage in DM file
	-S                    print strand in DM file
	--Cx                  print context in DM file
	-E                    print end in DM file
	--Id                  print ID in DM file
	-h|--help
```


## dmtools_mr2dm

### Tool Description
Convert methylation ratio files to DM format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
- **Homepage**: https://github.com/ZhouQiangwei/dmtools
- **Package**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Validation**: PASS

### Original Help Text
```text
Command Format :  dmtools mr2dm [opnions] -g genome.fa.fai -m methratio.txt -o outmeth.dm

Usage: dmtools mr2dm -C -S --Cx -g genome.fa.fai -m meth.txt -o meth.dm
	 [mr2dm] mode paramaters, required
	-g                    chromosome size file.
	-m                    methratio file
	-o|--outdm            output DM file
	 [mr2dm] mode paramaters, options
	-C                    print coverage
	-S                    print strand
	--Cx                  print context
	-E                    print end
	--Id                  print ID
	--CF                  coverage filter, >=[int], default 4.
	--sort Y/N            make chromsize file and meth file in same coordinate, default Y
	--zl                  The maximum number of zoom levels. [0-10]
	-f                    file format. methratio, bedmethyl, bismark or bedsimple [default methratio]
	  methratio           chrom start strand context meth_reads cover
	  bedmethyl           chrom start end name * strand * * * coverage meth_reads
	  bismark             chrom start strand coverC coverT context
	  bedsimple           chrom start end id strand context meth_reads coverage
	  simpleme            chrom start value coverage strand context
	--pcontext            CG/CHG/CHH/C, needed when bedmethyl format, default C
	--fcontext            CG/CHG/CHH/ALL, only convert provide context in methratio file or bedsimple, default ALL
	--sv                  add strand information to meth level. eg 0.5, -0.5
	Note. meth ratio file must be sorted by chrom and coordinate. ex. sort -k1,1 -k2,2n
	-h|--help
```


## dmtools_view

### Tool Description
View mode parameters

### Metadata
- **Docker Image**: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
- **Homepage**: https://github.com/ZhouQiangwei/dmtools
- **Package**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Validation**: PASS

### Original Help Text
```text
Command Format :  dmtools view [opnions] -i meth.dm

Usage:
	 [view] mode paramaters, required
	-i                    input DM file
	 [view] mode paramaters, options
	-o                    output file [stdout]
	-r                    region for view, can be seperated by space. chr1:1-2900 chr2:1-200
	--chr                 chromosome for view
	--bed                 bed file for view, format: chrom start end (strand).
	--strand              [0/1/2] strand for show, 0 represent '+' positive strand, 1 '-' negative strand, 2 '.' all information
	--context             [0/1/2/3] context for show, 0 represent 'C/ALL' context, 1 'CG' context, 2 'CHG' context, 3 'CHH' context.
	--mincover            >= minumum coverage show, default: 0
	--maxcover            <= maximum coverage show, default: 10000
	--outformat           txt or dm format [txt]
	--zl                  The maximum number of zoom levels. [0-10], valid for dm out
	-h|--help
```


## dmtools_merge

### Tool Description
Merge multiple DM files

### Metadata
- **Docker Image**: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
- **Homepage**: https://github.com/ZhouQiangwei/dmtools
- **Package**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Validation**: PASS

### Original Help Text
```text
Command Format :  dmtools merge [opnions] -i meth.dm,meth2.dm,...

Usage:
	 [merge] mode paramaters, required
	-i                    input DM files
	 [merge] mode paramaters, options
	-o                    output file
	--method              method for merge overlap sites, weighted/ mean, [weighted]
	--mincover            >= minumum coverage show, default: 0
	--maxcover            <= maximum coverage show, default: 10000
	--outformat           txt or dm format [txt]
	--zl                  The maximum number of zoom levels. [0-10], valid for dm out
	-h|--help
```


## dmtools_ebsrate

### Tool Description
Calculate bisulfite conversion rate from DM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
- **Homepage**: https://github.com/ZhouQiangwei/dmtools
- **Package**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Validation**: PASS

### Original Help Text
```text
Command Format :  dmtools ebsrate -i meth.dm

Usage:
	 [view] mode paramaters, required
	-i                    input DM file
	-o                    output file
	--bsmode              chg, chh or chr mode, suggest chg/chh for human, mouse etc.
	--chr                 chromosome level used for calculate bisulfite convertion rate, default, chrM and chrC
	-h|--help
```


## dmtools_viewheader

### Tool Description
View header of a DM file

### Metadata
- **Docker Image**: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
- **Homepage**: https://github.com/ZhouQiangwei/dmtools
- **Package**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Validation**: PASS

### Original Help Text
```text
Command Format :  dmtools viewheader -i meth.dm

Usage:
	 [view] mode paramaters, required
	-i                    input DM file
	-h|--help
```


## dmtools_overlap

### Tool Description
Calculate overlap between two DM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
- **Homepage**: https://github.com/ZhouQiangwei/dmtools
- **Package**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Validation**: PASS

### Original Help Text
```text
Command Format :  dmtools overlap [opnions] -i meth1.dm -i2 meth2.dm

Usage:
	 [overlap] mode paramaters, required
	-i                    input DM file
	-i2                   input DM file2
	 [overlap] mode paramaters, options
	-r                    region for view, can be seperated by space. chr1:1-2900 chr2:1-200
	--bed                 bed file for view, format: chrom start end [strand].
	 [overlap] mode paramaters
	--dmfiles             input DM files, seperated by comma. This is no need if you provide -i and -i2.
	-h|--help
```


## dmtools_regionstats

### Tool Description
Calculate methylation statistics for regions in a DM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
- **Homepage**: https://github.com/ZhouQiangwei/dmtools
- **Package**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Validation**: PASS

### Original Help Text
```text
Command Format :  dmtools regionstats [opnions] -i dm --bed bedfile

Usage:
	 [regionstats] mode paramaters, required
	-i                    input DM file
	--bed                 bed file for view, format: chrom start end [strand].
	--gtf                 gtf file for view, format: chrom * * start end * strand * xx geneid.
	--gff                 gff file for view, format: chrom * * start end * strand * xx=geneid.
	 [regionstats] mode paramaters, options
	-o                    output prefix [stdout]
	-r                    region for view, can be seperated by space. chr1:1-2900 chr2:1-200,+
	--method              weighted/ mean
	--minC                min cytosines in region will used for calculate, default: 2
	--strand              [0/1/2/3] strand for show, 0 represent '+' positive strand, 1 '-' negative strand, 2 '.' all information, 3 calculate and print strand meth level seperately
	--context             [0/1/2/3/4] context for show, 0 represent 'C/ALL' context, 1 'CG' context, 2 'CHG' context, 3 'CHH' context, 4 calculate and print strand meth level seperately
	--printcoverage       [0/1] print countC and coverage instead of methratio. [0]
	--print2one           [int] print all the countC and coverage results of C/CG/CHG/CHH context methylation to same file, only valid when --printcoverage 1. 0 for no, 1 for yes. [0]
	-h|--help
```


## dmtools_bodystats

### Tool Description
Calculate DNA methylation level of upstream and downstream N-bp window.

### Metadata
- **Docker Image**: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
- **Homepage**: https://github.com/ZhouQiangwei/dmtools
- **Package**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Validation**: PASS

### Original Help Text
```text
Command Format :  dmtools bodystats [opnions] -i dm --bed bedfile

Usage:
	 [bodystats] mode paramaters, required
	-i                    input DM file
	--bed                 bed file for view, format: chrom start end [strand].
	--gtf                 gtf file for view, format: chrom * * start end * strand * xx geneid.
	--gff                 gff file for view, format: chrom * * start end * strand * xx=geneid.
	 [bodystats] mode paramaters, options
	-o                    output file [stdout]
	-r                    region for view, can be seperated by space. chr1:1-2900 chr2:1-200,+
	--method              weighted/ mean
	--minC                min cytosines in region will used for calculate, default: 2
	--regionextend        also calculate DNA methylation level of upstream and downstream N-bp window. default 2000.
	--strand              [0/1/2/3] strand for show, 0 represent '+' positive strand, 1 '-' negative strand, 2 '.' all information, 3 calculate and print strand meth level seperately, only valid while -r para
	--context             [0/1/2/3/4] context for show, 0 represent 'C/ALL' context, 1 'CG' context, 2 'CHG' context, 3 'CHH' context, 4 calculate and print strand meth level seperately, default: 4.
	--printcoverage       [0/1] also print countC and coverage of body instead of methratio. [0]
	--print2one           [int] print all the countC and coverage results of C/CG/CHG/CHH context methylation to same file, only valid when --printcoverage 1. 0 for no, 1 for yes. [0]
	-h|--help
```


## dmtools_profile

### Tool Description
Calculate the methylation matrix mode of every region or gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
- **Homepage**: https://github.com/ZhouQiangwei/dmtools
- **Package**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Validation**: PASS

### Original Help Text
```text
Command Format :  dmtools profile [opnions] -i meth.dm --bed bedfile

Usage:
	 [profile] mode paramaters, required
	-i                    input DM file
	--bed                 bed file for view, format: chrom start end [strand].
	--gtf                 gtf file for view, format: chrom * * start end * strand * xx geneid.
	--gff                 gff file for view, format: chrom * * start end * strand * xx=geneid.
	 [profile] mode paramaters, options
	-o                    output file [stdout]
	-p                    [int] threads
	--regionextend        region extend for upstream and downstram, [2000]
	--profilestep         [double] step mean bin size for chromosome region, default: 0.02 (2%)
	--profilemovestep     [double] step move, default: profilestep/2, if no overlap, please define same as --profilestep
	--profilemode         calculate the methylation matrix mode of every region or gene. 0 for gene and flanks mode, 1 for tss and flanks, 2 for tts and flanks, 3 for region center and flanks. [0]
	--bodyX               [double] the gene body bin size is N multiple of the bin size of the upstream and downstream extension region. [1]
	--matrixX             [int] the bin size is N times of the profile bin size, so the bin size should be N*profilestep [5], please note N*profilestep must < 1 and N must >= 1, used for calculation per gene.
	--strand              [0/1/2] strand for calculate, 0 represent '+' positive strand, 1 '-' negative strand, 2 '.' all information, [2]
	--context             [0/1/2/3] context for calculate, 0 represent 'C/ALL' context, 1 'CG' context, 2 'CHG' context, 3 'CHH' context. [0]
	--print2one           [int] print all the matrix results of C/CG/CHG/CHH context methylation to same file. 0 for no, 1 for yes. [0]
	-h|--help
```


## dmtools_chromstats

### Tool Description
Calculate chromosome methylation statistics from DM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
- **Homepage**: https://github.com/ZhouQiangwei/dmtools
- **Package**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Validation**: PASS

### Original Help Text
```text
Command Format :  dmtools chromstats [opnions] -i meth.dm

Usage:
	 [chromstats] mode paramaters, required
	-i                    input DM file
	 [chromstats] mode paramaters, options
	-o                    output file [stdout]
	--method              weighted/ mean/ min/ max/ cover/ dev
	--chromstep           [int] step mean bin size for chromosome region, default: 100000
	--stepmove            [int] step move, default: 50000, if no overlap, please define same as --chromstep
	--context             [0/1/2/3/4] context for show, 0 represent 'C/ALL' context, 1 'CG' context, 2 'CHG' context, 3 'CHH' context, 4 calculate and print context meth level seperately. [4]
	--fstrand             [0/1/2/3] strand for calculation, 0 represent '+' positive strand, 1 '-' negative strand, 2 '.' without strand information, 3 calculate and print strand meth level seperately. [2]
	--printcoverage       [0/1] print countC and coverage instead of methratio. [0]
	--print2one           [int] print all the countC and coverage results of C/CG/CHG/CHH context methylation to same file, only valid when --printcoverage 1. 0 for no, 1 for yes. [0]
	-h|--help
```


## dmtools_chrmeth

### Tool Description
Calculates chromosome methylation statistics from a DM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
- **Homepage**: https://github.com/ZhouQiangwei/dmtools
- **Package**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Validation**: PASS

### Original Help Text
```text
Command Format :  dmtools chrmeth -i meth.dm

Usage:
	 [view] mode paramaters, required
	-i                    input DM file
	-o                    output file
	--chr                 chromosome for cal.
, default, all	-h|--help
```


## dmtools_addzm

### Tool Description
add zoom levels for dm

### Metadata
- **Docker Image**: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
- **Homepage**: https://github.com/ZhouQiangwei/dmtools
- **Package**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Validation**: PASS

### Original Help Text
```text
Command Format :  dmtools addzm [opnions] -i meth.dm -o meth.zm2.dm

Usage: add zoom levels for dm
	 [addzm] mode paramaters, required
	-i                    input DM file
	 [addzm] mode paramaters, options
	-o                    output dm file
	--zl                  The maximum number of zoom levels. [0-10], valid for dm out
	-r                    region for view, can be seperated by space. chr1:1-2900 chr2:1-200;
	--bed                 bed file for view, format: chrom start end (strand).
	--strand              [0/1/2] strand for show, 0 represent '+' positive strand, 1 '-' negative strand, 2 '.' all information
	--context             [0/1/2/3] context for show, 0 represent 'C/ALL' context, 1 'CG' context, 2 'CHG' context, 3 'CHH' context.
	--mincover            >= minumum coverage show, default: 0
	--maxcover            <= maximum coverage show, default: 10000
	-h|--help
```


## dmtools_stats

### Tool Description
Calculate statistics from DM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
- **Homepage**: https://github.com/ZhouQiangwei/dmtools
- **Package**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Validation**: PASS

### Original Help Text
```text
Command Format :  dmtools stats [opnions] -i meth.dm

Usage:
	 [stats] mode paramaters, required
	-i                    input DM file
	 [stats] mode paramaters, options
	-o                    output file [stdout]
	--tc                  total number of cytosine and guanine in genome, we will use the number of site in dm file if you not provide --tc
	-r                    region for calculate stats, can be seperated by space. chr1:1-2900 chr2:1-200
	--bed                 bed file for calculate stats, format: chrom start end (strand).
	--strand              [0/1/2] strand for show, 0 represent '+' positive strand, 1 '-' negative strand, 2 '.' all information
	--context             [0/1/2/3] context for show, 0 represent 'C/ALL' context, 1 'CG' context, 2 'CHG' context, 3 'CHH' context.
	-s                    size of bin for count cytosine number.
	--mincover            >= minumum coverage show, default: 0
	--maxcover            <= maximum coverage show, default: 10000
	-h|--help
```


## dmtools_dmdmr

### Tool Description
A collection of tools for DNA methylation analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
- **Homepage**: https://github.com/ZhouQiangwei/dmtools
- **Package**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Validation**: PASS

### Original Help Text
```text
Please define correct mode!!!
Command Format :  dmtools <mode> [opnions]

Usage:
	  [mode]         index align bam2dm mr2dm view ebsrate viewheader overlap regionstats bodystats profile chromstats

	  index          build index for genome
	  align          alignment fastq
	  bam2dm         calculate DNA methylation (DM format) with BAM file
	  mr2dm          convert txt meth file to dm format
	  view           dm format to txt/dm meth
	  merge          merge more than 1 dm files to one dm file
	  ebsrate        estimate bisulfite conversion rate
	  viewheader     view header of dm file
	  overlap        overlap cytosine site with more than two dm files
	  regionstats    calculate DNA methylation level of per region
	  bodystats      calculate DNA methylation level of body, upstream and downstream.
	  profile        calculate DNA methylation profile
	  chromstats     calculate DNA methylation level across chromosome
	  chrmeth        calculate DNA methylation level of chromosomes
	  addzm          add or change zoom levels for dm format, need for browser visulization
	  stats          coverage and methylation level distribution of data
	  dmDMR          differential DNA methylation analysis
	  bw             convert dm file to bigwig file
```


## dmtools_bw

### Tool Description
Convert DM file to bigwig format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
- **Homepage**: https://github.com/ZhouQiangwei/dmtools
- **Package**: https://anaconda.org/channels/bioconda/packages/dmtools/overview
- **Validation**: PASS

### Original Help Text
```text
Command Format :  dmtools bw [options] -i <dm> -o <out bigwig file>

Usage: dmtools bw -i input.dm -o meth.bw
	 [bw] mode paramaters, required
	-i                    input DM file
	-o|--out              Prefix of methratio.dm output file
	 [bw] mode paramaters, options
	-r                    region for print, can be seperated by space. chr1:1-2900 chr2:1-200
	--chr                 chromosome for print
	--strand              [0/1/2] strand for show, 0 represent '+' positive strand, 1 '-' negative strand, 2 '.' all information
	--context             [0/1/2/3] context for show, 0 represent 'C/ALL' context, 1 'CG' context, 2 'CHG' context, 3 'CHH' context.
	--mincover            >= minumum coverage show, default: 0
	--maxcover            <= maximum coverage show, default: 10000
	--zl                  The maximum number of zoom levels. [0-10], default: 2
	-h|--help
```


## Metadata
- **Skill**: not generated
