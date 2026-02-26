# vardict CWL Generation Report

## vardict

### Tool Description
VarDict is a variant calling program for SNV, MNV, indels (<120 bp default, but can be set using -I option), and complex variants. It accepts any BAM format, either from DNA-seq or RNA-seq. There are several distinct features over other variant callers. First, it can perform local realignment over indels on the fly for more accurate allele frequencies of indels. Second, it rescues softly clipped reads to identify indels not present in the alignments or support existing indels. Third, when given the PCR amplicon information, it will perform amplicon-based variant calling and filter out variants that show amplicon bias, a common false positive in PCR based targeted deep sequencing. Forth, it has very efficient memory management and memory usage is linear to the region of interest, not the depth. Five, it can handle ultra-deep sequencing and the performance is only linear to the depth. It has been tested on depth over 2M reads. Finally, it has a build-in capability to perform paired sample analysis, intended for somatic mutation identification, comparing DNA-seq and RNA-seq, or resistant vs sensitive in cancer research. By default, the region_info is an entry of refGene.txt from IGV, but can be any region or bed files.

### Metadata
- **Docker Image**: quay.io/biocontainers/vardict:2019.06.04--pl526_0
- **Homepage**: https://github.com/AstraZeneca-NGS/VarDict
- **Package**: https://anaconda.org/channels/bioconda/packages/vardict/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vardict/overview
- **Total Downloads**: 130.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/AstraZeneca-NGS/VarDict
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin/vardict [-n name_reg] [-b bam] [-c chr] [-S start] [-E end] [-s seg_starts] [-e seg_ends] [-x #_nu] [-g gene] [-f freq] [-r #_reads] [-B #_reads] region_info

    VarDict is a variant calling program for SNV, MNV, indels (<120 bp default, but can be set using -I option), and complex variants.  It accepts any BAM format, either
    from DNA-seq or RNA-seq.  There are several distinct features over other variant callers.  First, it can perform local
    realignment over indels on the fly for more accurate allele frequencies of indels.  Second, it rescues softly clipped reads
    to identify indels not present in the alignments or support existing indels.  Third, when given the PCR amplicon information,
    it will perform amplicon-based variant calling and filter out variants that show amplicon bias, a common false positive in PCR
    based targeted deep sequencing.  Forth, it has very efficient memory management and memory usage is linear to the region of
    interest, not the depth.  Five, it can handle ultra-deep sequencing and the performance is only linear to the depth.  It has
    been tested on depth over 2M reads.  Finally, it has a build-in capability to perform paired sample analysis, intended for
    somatic mutation identification, comparing DNA-seq and RNA-seq, or resistant vs sensitive in cancer research.  By default,
    the region_info is an entry of refGene.txt from IGV, but can be any region or bed files.

    -H|-? Print this help page

    -h|--header
       Print a header row decribing columns

    -v VCF format output

    -i|--splice 
       Output splicing read counts

    -p Do pileup regarless the frequency

    -C Indicate the chromosome names are just numbers, such as 1, 2, not chr1, chr2 (deprecated)

    -D|--debug
       Debug mode.  Will print some error messages and append full genotype at the end.

    -y|verbose
       Verbose mode.  Will output variant calling process.

    -M Similar to -D, but will append individual quality and position data instead of mean

    -t|--dedup
       Indicate to remove duplicated reads.  Only one pair with same start positions will be kept

    -3 Indicate to move indels to 3-prime if alternative alignment can be achieved.

    -U|--nosv Turn off structural variant calling

    -u Indicate unique mode, which when mate pairs overlap, the overlapping part will be counted only once using forward read only.

    -F bit
       The hexical to filter reads using samtools. Default: 0x500 (filter 2nd alignments and duplicates).  Use -F 0 to turn it off.

    -z 0/1
       Indicate wehther is zero-based cooridates, as IGV does.  Default: 1 for BED file or amplicon BED file.  Use 0 to turn it off.
       When use -R option, it is set to 0
       
    -a|--amplicon int:float
       Indicate it is amplicon based calling.  Reads do not map to the amplicon will be skipped.  A read pair is considered belonging
       the amplicon if the edges are less than int bp to the amplicon, and overlap fraction is at least float.  Default: 10:0.95
       
    -k 0/1
       Indicate whether to perform local realignment.  Default: 1 or yes.  Set to 0 to disable it.  For Ion or PacBio, 0 is recommended.
       
    -G Genome fasta
       The the reference fasta.  Should be indexed (.fai).  Default to: /ngs/reference_data/genomes/Hsapiens/hg19/seq/hg19.fa
       
    -R Region
       The region of interest.  In the format of chr:start-end.  If end is omitted, then a single position.  No BED is needed.
       
    -d delimiter
       The delimiter for split region_info, default to tab "	"
       
    -n regular_expression
       The regular expression to extract sample name from bam filenames.  Default to: /([^/._]+?)_[^/]*.bam/
       
    -N string
       The sample name to be used directly.  Will overwrite -n option
       
    -b string
       The indexed BAM file
       
    -c INT
       The column for chromosome
       
    -S INT
       The column for region start, e.g. gene start
       
    -E INT
       The column for region end, e.g. gene end
       
    -s INT
       The column for segment starts in the region, e.g. exon starts
       
    -e INT
       The column for segment ends in the region, e.g. exon ends
       
    -g INT
       The column for gene name, or segment annotation
       
    -x INT
       The number of nucleotide to extend for each segment, default: 0
       
    -f double
       The threshold for allele frequency, default: 0.01 or 1%
       
    -r minimum reads
       The minimum # of variance reads, default 2
       
    -B INT
       The minimum # of reads to determine strand bias, default 2
       
    -Q INT
       If set, reads with mapping quality less than INT will be filtered and ignored
       
    -q INT
       The phred score for a base to be considered a good call.  Default: 22.5 (for Illumina)
       For PGM, set it to ~15, as PGM tends to under estimate base quality.
       
    -m INT
       If set, reads with mismatches more than INT will be filtered and ignored.  Gaps are not counted as mismatches.  
       Valid only for bowtie2/TopHat or BWA aln followed by sampe.  BWA mem is calculated as NM - Indels.  Default: 8,
       or reads with more than 8 mismatches will not be used.
   
    -T|--trim INT
       Trim bases after [INT] bases in the reads
       
    -X INT
       Extension of bp to look for mismatches after insersion or deletion.  Default to 3 bp, or only calls when they are within 3 bp.
       
    -Y|--ref-extension INT
       Extension of bp of reference to build lookup table.  Default to 1200 bp.  Increase the number will slowdown the program.
       The main purpose is to call large indels within 1000 bp that can be missed by discordant mate pairs.
       
    -P number
       The read position filter.  If the mean variants position is less that specified, it is considered false positive.  Default: 5
       
    -Z|--downsample double
       For downsampling fraction.  e.g. 0.7 means roughly 70% downsampling.  Default: No downsampling.  Use with caution.  The
       downsampling will be random and non-reproducible.
       
    -o Qratio
       The Qratio of (good_quality_reads)/(bad_quality_reads+0.5).  The quality is defined by -q option.  Default: 1.5
       
    -O MapQ
       The reads should have at least mean MapQ to be considered a valid variant.  Default: no filtering
       
    -V freq
       The lowest frequency in normal sample allowed for a putative somatic mutations.  Default to 0.05
       
    -I INT
       The indel size.  Default: 50bp
       
    -M INT
       The minimum matches for a read to be considered.  If, after soft-clipping, the matched bp is less than INT, then the 
       read is discarded.  It is meant for PCR based targeted sequencing where there is no insert and the matching is only the primers.
       Default: 25, or reads with matches less than 25bp will be filtered
       
    -L INT
       The minimum structural variant length to be presented using <DEL> <DUP> <INV> <INS>, etc.  Default: 500.  Any indel, complex
       variants less than this will be spelled out with exact nucleotides
       
    -w|--insert-size INSERT_SIZE
       The insert size.  Used for SV calling.  Default: 300
       
    -W|--insert-std INSERT_STD
       The insert size STD.  Used for SV calling.  Default: 100
       
    -A INSERT_STD_AMT
       The number of STD.  A pair will be considered for DEL if INSERT > INSERT_SIZE + INSERT_STD_AMT * INSERT_STD.  Default: 4
       
    -J|--crispr CRISPR_cutting_site
       The genomic position that CRISPR/Cas9 suppose to cut, typically 3bp from the PAM NGG site and within the guide.  For
       CRISPR mode only.  It will adjust the variants (mostly In-Del) start and end sites to as close to this location as possible,
       if there are alternatives. The option should only be used for CRISPR mode.
       
    -j CRISPR_filtering_bp
       In CRISPR mode, the minimum amount in bp that a read needs to overlap with cutting site.  If a read does not meet the criteria,
       it will not be used for variant calling, since it is likely just a partially amplified PCR.  Default: not set, or no filtering 

    --adaptor adaptor_seq
       Filter adaptor sequences so that they are not used in realignment.  Multiple adaptors can be supplied by multiple of this option.

    --chimeric
       Indicate to turn off chimeric reads filtering.  Chimeric reads are artifacts from library construction, where a read can be split
       into two segments, each will be aligned within 1-2 read length distance, but in opposite direction.

AUTHOR
       Written by Zhongwu Lai, AstraZeneca, Boston, USA

REPORTING BUGS
       Report bugs to zhongwu@yahoo.com

COPYRIGHT
       This is free software: you are free to change and redistribute it.  There is NO WARRANTY, to the extent permitted by law.
```

