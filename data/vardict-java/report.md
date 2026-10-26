# vardict-java CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| vardict-java_testsomatic.R | PASS |  |
| vardict-java_teststrandbias.R | PASS |  |
| vardict-java_var2vcf_paired.pl | PASS |  |
| vardict-java_var2vcf_valid.pl | PASS |  |
| vardict-java_vardict-java | PASS |  |

## vardict-java_vardict-java

### Tool Description
VarDict is a variant calling program for SNV, MNV, indels and complex variants from BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/vardict-java:1.8.3--hdfd78af_0
- **Homepage**: https://github.com/AstraZeneca-NGS/VarDictJava
- **Package**: https://anaconda.org/channels/bioconda/packages/vardict-java/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required option(s): b
usage: vardict [-n name_reg] [-b bam] [-c chr] [-S start] [-E end] [-s seg_starts] [-e seg_ends] [-x #_nu] [-g gene] [-f freq] [-r #_reads]
               [-B #_reads] region_info
VarDict is a variant calling program for SNV, MNV, indels (<50 bp), and complex variants.  It accepts any BAM format, either
from DNA-seq or RNA-seq.  There are several distinct features over other variant callers.  First, it can perform local
realignment over indels on the fly for more accurate allele frequencies of indels.  Second, it rescues softly clipped reads
to identify indels not present in the alignments or support existing indels.  Third, when given the PCR amplicon information,
it will perform amplicon-based variant calling and filter out variants that show amplicon bias, a common false positive in PCR
based targeted deep sequencing.  Forth, it has very efficient memory management and memory usage is linear to the region of
interest, not the depth.  Five, it can handle ultra-deep sequencing and the performance is only linear to the depth.  It has
been tested on depth over 2M reads.  Finally, it has a build-in capability to perform paired sample analysis, intended for
somatic mutation identification, comparing DNA-seq and RNA-seq, or resistant vs sensitive in cancer research.  By default,
the region_info is an entry of refGene.txt from IGV, but can be any region or bed files.
Options:
 -3                                  Indicate to move indels to 3-prime if alternative alignment can be achieved.
 -A <INT>                            The number of STD. A pair will be considered for DEL if INSERT > INSERT_SIZE + INSERT_STD_AMT *
                                     INSERT_STD.  Default: 4
 -a,--amplicon <int:float>           Indicate it's amplicon based calling.  Reads that don't map to the amplicon will be skipped.  A read pair
                                     is considered belonging  to the amplicon if the edges are less than int bp to the amplicon, and overlap
                                     fraction is at least float.  Default: 10:0.95
 -adaptor <string>                   Filter adaptor sequences so that they are not used in realignment. Multiple adaptors can be supplied by
                                     setting them with comma, like: --adaptor ACGTTGCTC,ACGGGGTCTC,ACGCGGCTAG .
 -B <INT>                            The minimum # of reads to determine strand bias, default 2
 -b <string>                         The indexed BAM file
 -C                                  Indicate the chromosome names are just numbers, such as 1, 2, not chr1, chr2 (deprecated)
 -c <INT>                            The column for chromosome
 -chimeric                           Indicate to turn off chimeric reads filtering.
 -D,--debug                          Debug mode.  Will print some error messages and append full genotype at the end.
 -d <delemiter>                      The delimiter for split region_info, default to tab "\t"
 -deldupvar                          Turn on deleting of duplicate variants. Variants in this mode are considered and outputted only if start
                                     position of variant is inside the region interest.
 -DP,--default-printer <string>      The printer type used for different outputs. Default: OUT (i.e. System.out).
 -E <INT>                            The column for region end, e.g. gene end
 -e <INT>                            The column for segment ends in the region, e.g. exon ends
 -F <bit>                            The hexical to filter reads using samtools. Default: 0x504 (filter 2nd alignments, unmapped reads and
                                     duplicates).  Use -F 0 to turn it off.
 -f <double>                         The threshold for allele frequency, default: 0.01 or 1%
 -fisher                             Experimental feature: Changes R script (teststrandbias.R and testsomatic.) to Java implementation of
                                     Fisher exact test.
 -G <Genome fasta>                   The reference fasta. Should be indexed (.fai).
                                     Defaults to: /ngs/reference_data/genomes/Hsapiens/hg19/seq/hg19.fa.  Also short commands can be used to
                                     set path to:
                                     hg19 - /ngs/reference_data/genomes/Hsapiens/hg19/seq/hg19.fa
                                     hg38 - /ngs/reference_data/genomes/Hsapiens/hg38/seq/hg38.fa
                                     mm10 - /ngs/reference_data/genomes/Mmusculus/mm10/seq/mm10.fa
 -g <INT>                            The column for gene name, or segment annotation
 -H,--?                              Print this help page
 -h,--header                         Print a header row describing columns
 -I <INT>                            The indel size.  Default: 50bp
 -i,--splice                         Output splicing read counts
 -J,--crispr <CRISPR_cutting_site>   The genomic position that CRISPR/Cas9 suppose to cut, typically 3bp from the PAM NGG site and within the
                                     guide.  For
                                     CRISPR mode only.  It will adjust the variants (mostly In-Del) start and end sites to as close to this
                                     location as possible,
                                     if there are alternatives. The option should only be used for CRISPR mode.
 -j <CRISPR_filtering_bp>            In CRISPR mode, the minimum amount in bp that a read needs to overlap with cutting site.  If a read does
                                     not meet the criteria,
                                     it will not be used for variant calling, since it is likely just a partially amplified PCR.  Default: not
                                     set, or no filtering
 -K                                  Include Ns in the total depth calculation
 -k <0/1>                            Indicate whether to perform local realignment.  Default: 1.  Set to 0 to disable it.  For Ion or PacBio,
                                     0 is recommended.
 -L <INT>                            The minimum structural variant length to be presented using <DEL> <DUP> <INV> <INS>, etc. Default: 1000.
                                     Any indel, complex variants less than this will be spelled out with exact nucleotides.
 -M <INT>                            The minimum matches for a read to be considered. If, after soft-clipping, the matched bp is less than
                                     INT, then the read is discarded. It's meant for PCR based targeted sequencing where there's no insert and
                                     the matching is only the primers.
                                     Default: 0, or no filtering
 -m <INT>                            If set, reads with mismatches more than INT will be filtered and ignored.  Gaps are not counted as
                                     mismatches.
                                     Valid only for bowtie2/TopHat or BWA aln followed by sampe.  BWA mem is calculated as NM - Indels.
                                     Default: 8,
                                     or reads with more than 8 mismatches will not be used.
 -mfreq <double>                     The variant frequency threshold to determine variant as good in case of monomer MSI. Default: 0.25
 -N <string>                         The sample name to be used directly.  Will overwrite -n option
 -n <regular_expression>             The regular expression to extract sample name from BAM filenames.  Default to: /([^\/\._]+?)_[^\/]*.bam/
 -nmfreq <double>                    The variant frequency threshold to determine variant as good in case of non-monomer MSI. Default: 0.1
 -O <MapQ>                           The reads should have at least mean MapQ to be considered a valid variant.  Default: no filtering
 -o <Qratio>                         The Qratio of (good_quality_reads)/(bad_quality_reads+0.5).  The quality is defined by -q option.
                                     Default: 1.5
 -P <number>                         The read position filter.  If the mean variants position is less that specified, it's considered false
                                     positive.  Default: 5
 -p                                  Do pileup regardless of the frequency
 -Q <INT>                            If set, reads with mapping quality less than INT will be filtered and ignored
 -q <INT>                            The phred score for a base to be considered a good call.  Default: 25 (for Illumina)
                                     For PGM, set it to ~15, as PGM tends to under estimate base quality.
 -R <Region>                         The region of interest.  In the format of chr:start-end.  If end is omitted, then a single position.  No
                                     BED is needed.
 -r <minimum reads>                  The minimum # of variant reads, default 2
 -S <INT>                            The column for region start, e.g. gene start
 -s <INT>                            The column for segment starts in the region, e.g. exon starts
 -T,--trim <INT>                     Trim bases after [INT] bases in the reads
 -t,--dedup                          Indicate to remove duplicated reads.  Only one pair with same start positions will be kept
 -th <INT>                           Threads count.
 -U,--nosv                           Turn off structural variant calling.
 -u                                  Indicate unique mode, which when mate pairs overlap, the overlapping part will be counted only once using
                                     forward read only.
 -UN                                 Indicate unique mode, which when mate pairs overlap, the overlapping part will be counted only once using
                                     first read only.
 -V <freq>                           The lowest frequency in the normal sample allowed for a putative somatic mutation.  Defaults to 0.05
 -v                                  VCF format output
 -VS <STRICT | LENIENT | SILENT>     How strict to be when reading a SAM or BAM.
                                     STRICT	- throw an exception if something looks wrong.
                                     LENIENT	- Emit warnings but keep going if possible.
                                     SILENT	- Like LENIENT, only don't emit warning messages.
                                     Default: LENIENT
 -W,--insert-std <INT>               The insert size STD.  Used for SV calling.  Default: 100
 -w,--insert-size <INT>              The insert size.  Used for SV calling.  Default: 300
 -X <INT>                            Extension of bp to look for mismatches after insersion or deletion.  Default to 2 bp, or only calls when
                                     they're within 2 bp.
 -x <INT>                            The number of nucleotide to extend for each segment, default: 0
 -Y,--ref-extension <INT>            Extension of bp of reference to build lookup table. Default to 1200 bp. Increase the number will slowdown
                                     the program. The main purpose is to call large indels with 1000 bp that can be missed by discordant mate
                                     pairs.
 -y,--verbose
 -Z,--downsample <double>            For downsampling fraction.  e.g. 0.7 means roughly 70% downsampling.  Default: No downsampling.  Use with
                                     caution.  The
                                     downsampling will be random and non-reproducible.
 -z <0/1>                            Indicate whether coordinates are zero-based, as IGV uses.  Default: 1 for BED file or amplicon BED file.
                                     Use 0 to turn it off. When using the -R option, it's set to 0
AUTHOR
.       Written by Zhongwu Lai, AstraZeneca, Boston, USA
REPORTING BUGS
.       Report bugs to zhongwu@yahoo.com
COPYRIGHT
.       This is free software: you are free to change and redistribute it.  There is NO WARRANTY, to the extent permitted by law.
```

## vardict-java_teststrandbias.R

### Tool Description
Test strand bias of VarDict variants with Fisher exact test (standard input to standard output).

### Metadata
- **Docker Image**: quay.io/biocontainers/vardict-java:1.8.3--hdfd78af_0
- **Homepage**: https://github.com/AstraZeneca-NGS/VarDictJava
- **Package**: https://anaconda.org/channels/bioconda/packages/vardict-java/overview
- **Validation**: PASS

### Original Help Text
```text
teststrandbias.R reads the VarDict variant table on standard input and writes it to standard output with Fisher exact strand bias p-value and odds ratio columns added. It has no command-line options.
```

## vardict-java_testsomatic.R

### Tool Description
Test somatic status of paired VarDict output with Fisher exact test (standard input to standard output).

### Metadata
- **Docker Image**: quay.io/biocontainers/vardict-java:1.8.3--hdfd78af_0
- **Homepage**: https://github.com/AstraZeneca-NGS/VarDictJava
- **Package**: https://anaconda.org/channels/bioconda/packages/vardict-java/overview
- **Validation**: PASS

### Original Help Text
```text
testsomatic.R reads the paired VarDict variant table on standard input and writes it to standard output with the somatic status and Fisher exact test p-value columns added. It has no command-line options.
```

## vardict-java_var2vcf_paired.pl

### Tool Description
Convert paired VarDict output into a validated VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vardict-java:1.8.3--hdfd78af_0
- **Homepage**: https://github.com/AstraZeneca-NGS/VarDictJava
- **Package**: https://anaconda.org/channels/bioconda/packages/vardict-java/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/var2vcf_paired.pl [-hHS] [-p pos] [-q qual] [-d depth] [-v depth] [-f frequency] [-F frequency] vars.txt
Version: 1.8.2
The program will convert the variant output from checkVar.pl script into validated VCF file.

Options are:

    -h	Print this usage.
    -H	Print this usage.
    -C  If set, chrosomes will have names of 1,2,3,...,X,Y, instead of chr1, chr2, ..., chrX, chrY
    -S	If set, variants that didn't pass filters will not be present in VCF file
    -M  If set, will increase stringency for candidate somatic: flag P0.01Likely and InDelLikely, and add filter P0.05
    -A  Indicate to output all variants at the same position.  By default, only the variant with the highest allele frequency is converted to VCF.
    -D  float (0-1) # Deprecated
        The minimum allele frequency difference between two samples required in addition to p-value.  Not compatible
	with -M option.  It's for interest of identifying variants with different AF, not just somatic.
    -c  int
        If two somatic candidates are within {int} bp, they're both filtered.  Default: 0 or no filtering
    -I  int
        The maximum non-monomer MSI allowed for a HT variant with AF < 0.6.  By default, 12, or any variants with AF < 0.6 in a region
	with > 12 non-monomer MSI will be considered false positive.  For monomers, that number is 10.
    -m  int
        The maximum mean mismatches allowed.  Default: 5.25, or if a variant is supported by reads with more than 5.25 mismatches, it'll be considered
	false positive.  Mismatches don't includes indels in the alignment.
    -N  Name(s)
        The sample name(s).  If only one name is given, the matched will be simply names as "name-match".  Two names
	are given separated by "|", such as "tumor|blood".
    -P  float
        The maximum p-value.  Default to 0.05.
    -p	float
    	The minimum mean position of variants in the read.  Default: 5.
    -q	float
    	The minimum mean base quality.  Default to 22.5 for Illumina sequencing
    -Q	float
    	The minimum mapping quality.  Default to 0 for Illumina sequencing
    -d	integer
    	The minimum total depth.  Default to 5
    -v	integer
    	The minimum variant depth.  Default to 3
    -f	float
    	The minimum allele frequency.  Default to 0.02
    -o	signal/noise
    	The minimum signal to noise, or the ratio of hi/(lo+0.5).  Default to 1.5.  Set it higher for deep sequencing.
    -F	float
    	The minimum allele frequency to consider to be homozygous.  Default to 0.2.  Thus frequency > 0.8 (1-0.2) will 
	be considered homozygous "1/1", between 0.5 - (1-0.2) will be "1/0", between (-f) - 0.5 will be "0/1",
	below (-f) will be "0/0".
	-b  Path to the *.bed file which is used to generate contigs in the header
	-G  Path to the *.fasta (*.fa) file which is used to generate reference tag in the header

AUTHOR
       Written by Zhongwu Lai, AstraZeneca, Boston, USA

REPORTING BUGS
       Report bugs to zhongwu@yahoo.com

COPYRIGHT
       This is free software: you are free to change and redistribute it.  There is NO WARRANTY, to the extent permitted by law.
```

## Metadata
- **Skill**: generated

## vardict-java_var2vcf_valid.pl

### Tool Description
Convert VarDict output to VCF format with validation filtering

### Metadata
- **Docker Image**: quay.io/biocontainers/vardict-java:1.8.3--hdfd78af_0
- **Homepage**: https://github.com/joachimwolff/VarDictJava
- **Package**: https://anaconda.org/channels/bioconda/packages/vardict-java/overview
- **Validation**: PASS

### Original Help Text
```text
##fileformat=VCFv4.2
##source=VarDict_v1.8.2
##INFO=<ID=SAMPLE,Number=1,Type=String,Description="Sample name (with whitespace translated to underscores)">
##INFO=<ID=TYPE,Number=1,Type=String,Description="Variant Type: SNV Insertion Deletion Complex">
##INFO=<ID=DP,Number=1,Type=Integer,Description="Total Depth">
##INFO=<ID=END,Number=1,Type=Integer,Description="Chr End Position">
##INFO=<ID=VD,Number=1,Type=Integer,Description="Variant Depth">
##INFO=<ID=AF,Number=A,Type=Float,Description="Allele Frequency">
##INFO=<ID=BIAS,Number=1,Type=String,Description="Strand Bias Info">
##INFO=<ID=REFBIAS,Number=1,Type=String,Description="Reference depth by strand">
##INFO=<ID=VARBIAS,Number=1,Type=String,Description="Variant depth by strand">
##INFO=<ID=PMEAN,Number=1,Type=Float,Description="The mean distance to the nearest 5 or 3 prime read end (whichever is closer) in all reads that support the variant call">
##INFO=<ID=PSTD,Number=1,Type=Float,Description="Position STD in reads">
##INFO=<ID=QUAL,Number=1,Type=Float,Description="Mean quality score in reads">
##INFO=<ID=QSTD,Number=1,Type=Float,Description="Quality score STD in reads">
##INFO=<ID=SBF,Number=1,Type=Float,Description="Strand Bias Fisher p-value">
##INFO=<ID=ODDRATIO,Number=1,Type=Float,Description="Strand Bias Odds ratio">
##INFO=<ID=MQ,Number=1,Type=Float,Description="Mean Mapping Quality">
##INFO=<ID=SN,Number=1,Type=Float,Description="Signal to noise">
##INFO=<ID=HIAF,Number=1,Type=Float,Description="Allele frequency using only high quality bases">
##INFO=<ID=ADJAF,Number=1,Type=Float,Description="Adjusted AF for indels due to local realignment">
##INFO=<ID=SHIFT3,Number=1,Type=Integer,Description="No. of bases to be shifted to 3 prime for deletions due to alternative alignment">
##INFO=<ID=MSI,Number=1,Type=Float,Description="MicroSatellite. > 1 indicates MSI">
##INFO=<ID=MSILEN,Number=1,Type=Float,Description="MicroSatellite unit length in bp">
##INFO=<ID=NM,Number=1,Type=Float,Description="Mean mismatches in reads">
##INFO=<ID=LSEQ,Number=1,Type=String,Description="5' flanking seq">
##INFO=<ID=RSEQ,Number=1,Type=String,Description="3' flanking seq">
##INFO=<ID=GDAMP,Number=1,Type=Integer,Description="No. of amplicons supporting variant">
##INFO=<ID=TLAMP,Number=1,Type=Integer,Description="Total of amplicons covering variant">
##INFO=<ID=NCAMP,Number=1,Type=Integer,Description="No. of amplicons don't work">
##INFO=<ID=AMPFLAG,Number=1,Type=Integer,Description="Top variant in amplicons don't match">
##INFO=<ID=HICNT,Number=1,Type=Integer,Description="High quality variant reads">
##INFO=<ID=HICOV,Number=1,Type=Integer,Description="High quality total reads">
##INFO=<ID=SPLITREAD,Number=1,Type=Integer,Description="No. of split reads supporting SV">
##INFO=<ID=SPANPAIR,Number=1,Type=Integer,Description="No. of pairs supporting SV">
##INFO=<ID=SVTYPE,Number=1,Type=String,Description="SV type: INV DUP DEL INS FUS">
##INFO=<ID=SVLEN,Number=1,Type=Integer,Description="The length of SV in bp">
##INFO=<ID=DUPRATE,Number=1,Type=Float,Description="Duplication rate in fraction">
##FILTER=<ID=q22.5,Description="Mean Base Quality Below 22.5">
##FILTER=<ID=Q10,Description="Mean Mapping Quality Below 10">
##FILTER=<ID=p8,Description="Mean Position in Reads Less than 8">
##FILTER=<ID=SN1.5,Description="Signal to Noise Less than 1.5">
##FILTER=<ID=Bias,Description="Strand Bias">
##FILTER=<ID=pSTD,Description="Position in Reads has STD of 0">
##FILTER=<ID=d3,Description="Total Depth < 3">
##FILTER=<ID=v2,Description="Var Depth < 2">
##FILTER=<ID=f0.02,Description="Allele frequency < 0.02">
##FILTER=<ID=MSI12,Description="Variant in MSI region with 12 non-monomer MSI or 13 monomer MSI">
##FILTER=<ID=NM5.25,Description="Mean mismatches in reads >= 5.25, thus likely false positive">
##FILTER=<ID=InGap,Description="The variant is in the deletion gap, thus likely false positive">
##FILTER=<ID=InIns,Description="The variant is adjacent to an insertion variant">
##FILTER=<ID=Cluster0bp,Description="Two variants are within 0 bp">
##FILTER=<ID=LongMSI,Description="The somatic variant is flanked by long A/T (>=14)">
##FILTER=<ID=AMPBIAS,Description="Indicate the variant has amplicon bias.">
##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
##FORMAT=<ID=DP,Number=1,Type=Integer,Description="Total Depth">
##FORMAT=<ID=VD,Number=1,Type=Integer,Description="Variant Depth">
##FORMAT=<ID=AD,Number=R,Type=Integer,Description="Allelic depths for the ref and alt alleles in the order listed">
##FORMAT=<ID=AF,Number=A,Type=Float,Description="Allele Frequency">
##FORMAT=<ID=RD,Number=2,Type=Integer,Description="Reference forward, reverse reads">
##FORMAT=<ID=ALD,Number=2,Type=Integer,Description="Variant forward, reverse reads">
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	
/usr/local/bin/var2vcf_valid.pl version 1.8.2 calling Getopt::Std::getopts (version 1.12 [paranoid]),
running under Perl version 5.32.1.

Usage: var2vcf_valid.pl [-OPTIONS [-MORE_OPTIONS]] [--] [PROGRAM_ARG1 ...]

The following single-character options are accepted:
	With arguments: -P -d -v -f -p -q -F -Q -o -N -m -I -c -r -O -X -k -V -M -x -T -b -G
	Boolean (without arguments): -h -u -t -a -H -S -C -E -A

Options may be merged together.  -- stops processing of options.
Space is not required between options and their arguments.
  [Now continuing due to backward compatibility and excessive paranoia.
   See 'perldoc Getopt::Std' about $Getopt::Std::STANDARD_HELP_VERSION.]
Use of uninitialized value $sample_nowhitespace in substitution (s///) at /usr/local/bin/var2vcf_valid.pl line 44.
Use of uninitialized value $sample in join or string at /usr/local/bin/var2vcf_valid.pl line 116.
```
