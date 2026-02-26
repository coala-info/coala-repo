cwlVersion: v1.2
class: CommandLineTool
baseCommand: vardict
label: vardict
doc: "VarDict is a variant calling program for SNV, MNV, indels (<120 bp default,
  but can be set using -I option), and complex variants. It accepts any BAM format,
  either from DNA-seq or RNA-seq. There are several distinct features over other variant
  callers. First, it can perform local realignment over indels on the fly for more
  accurate allele frequencies of indels. Second, it rescues softly clipped reads to
  identify indels not present in the alignments or support existing indels. Third,
  when given the PCR amplicon information, it will perform amplicon-based variant
  calling and filter out variants that show amplicon bias, a common false positive
  in PCR based targeted deep sequencing. Forth, it has very efficient memory management
  and memory usage is linear to the region of interest, not the depth. Five, it can
  handle ultra-deep sequencing and the performance is only linear to the depth. It
  has been tested on depth over 2M reads. Finally, it has a build-in capability to
  perform paired sample analysis, intended for somatic mutation identification, comparing
  DNA-seq and RNA-seq, or resistant vs sensitive in cancer research. By default, the
  region_info is an entry of refGene.txt from IGV, but can be any region or bed files.\n\
  \nTool homepage: https://github.com/AstraZeneca-NGS/VarDict"
inputs:
  - id: region_info
    type: string
    doc: Entry of refGene.txt from IGV, or any region or bed files.
    inputBinding:
      position: 1
  - id: adaptor_sequences
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter adaptor sequences so that they are not used in realignment. 
      Multiple adaptors can be supplied by multiple of this option.
    inputBinding:
      position: 102
      prefix: --adaptor
  - id: allele_freq_threshold
    type:
      - 'null'
      - float
    doc: 'The threshold for allele frequency, default: 0.01 or 1%'
    default: 0.01
    inputBinding:
      position: 102
      prefix: -f
  - id: allele_frequency_threshold
    type:
      - 'null'
      - float
    doc: 'The threshold for allele frequency, default: 0.01 or 1%'
    default: 0.01
    inputBinding:
      position: 102
      prefix: -f
  - id: amplicon_calling
    type:
      - 'null'
      - string
    doc: 'Indicate it is amplicon based calling. Reads do not map to the amplicon
      will be skipped. A read pair is considered belonging the amplicon if the edges
      are less than int bp to the amplicon, and overlap fraction is at least float.
      Default: 10:0.95'
    default: 10:0.95
    inputBinding:
      position: 102
      prefix: --amplicon
  - id: append_quality_data
    type:
      - 'null'
      - boolean
    doc: Similar to -D, but will append individual quality and position data 
      instead of mean
    inputBinding:
      position: 102
      prefix: -M
  - id: bam_file
    type:
      - 'null'
      - File
    doc: The indexed BAM file
    inputBinding:
      position: 102
      prefix: -b
  - id: bam_file_input
    type:
      - 'null'
      - File
    doc: The indexed BAM file
    inputBinding:
      position: 102
      prefix: -b
  - id: chr_col
    type:
      - 'null'
      - int
    doc: The column for chromosome
    inputBinding:
      position: 102
      prefix: -c
  - id: chromosome_col
    type:
      - 'null'
      - int
    doc: The column for chromosome
    inputBinding:
      position: 102
      prefix: -c
  - id: crispr_cutting_site
    type:
      - 'null'
      - string
    doc: The genomic position that CRISPR/Cas9 suppose to cut, typically 3bp 
      from the PAM NGG site and within the guide. For CRISPR mode only. It will 
      adjust the variants (mostly In-Del) start and end sites to as close to 
      this location as possible, if there are alternatives. The option should 
      only be used for CRISPR mode.
    inputBinding:
      position: 102
      prefix: --crispr
  - id: crispr_filtering_bp
    type:
      - 'null'
      - int
    doc: 'In CRISPR mode, the minimum amount in bp that a read needs to overlap with
      cutting site. If a read does not meet the criteria, it will not be used for
      variant calling, since it is likely just a partially amplified PCR. Default:
      not set, or no filtering'
    inputBinding:
      position: 102
      prefix: -j
  - id: debug_mode
    type:
      - 'null'
      - boolean
    doc: Debug mode. Will print some error messages and append full genotype at 
      the end.
    inputBinding:
      position: 102
      prefix: --debug
  - id: dedup_reads
    type:
      - 'null'
      - boolean
    doc: Indicate to remove duplicated reads. Only one pair with same start 
      positions will be kept
    inputBinding:
      position: 102
      prefix: --dedup
  - id: downsample_fraction
    type:
      - 'null'
      - float
    doc: 'For downsampling fraction. e.g. 0.7 means roughly 70% downsampling. Default:
      No downsampling. Use with caution. The downsampling will be random and non-reproducible.'
    inputBinding:
      position: 102
      prefix: --downsample
  - id: end_col
    type:
      - 'null'
      - int
    doc: The column for region end, e.g. gene end
    inputBinding:
      position: 102
      prefix: -E
  - id: end_col_region
    type:
      - 'null'
      - int
    doc: The column for region end, e.g. gene end
    inputBinding:
      position: 102
      prefix: -E
  - id: extend_nucleotides
    type:
      - 'null'
      - int
    doc: 'The number of nucleotide to extend for each segment, default: 0'
    default: 0
    inputBinding:
      position: 102
      prefix: -x
  - id: extend_segment_nucleotides
    type:
      - 'null'
      - int
    doc: 'The number of nucleotide to extend for each segment, default: 0'
    default: 0
    inputBinding:
      position: 102
      prefix: -x
  - id: filter_reads_hex
    type:
      - 'null'
      - string
    doc: 'The hexical to filter reads using samtools. Default: 0x500 (filter 2nd alignments
      and duplicates). Use -F 0 to turn it off.'
    default: '0x500'
    inputBinding:
      position: 102
      prefix: -F
  - id: gene_col
    type:
      - 'null'
      - int
    doc: The column for gene name, or segment annotation
    inputBinding:
      position: 102
      prefix: -g
  - id: gene_name_col
    type:
      - 'null'
      - int
    doc: The column for gene name, or segment annotation
    inputBinding:
      position: 102
      prefix: -g
  - id: genome_fasta
    type:
      - 'null'
      - File
    doc: 'The the reference fasta. Should be indexed (.fai). Default to: /ngs/reference_data/genomes/Hsapiens/hg19/seq/hg19.fa'
    default: /ngs/reference_data/genomes/Hsapiens/hg19/seq/hg19.fa
    inputBinding:
      position: 102
      prefix: -G
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print a header row decribing columns
    inputBinding:
      position: 102
      prefix: --header
  - id: indel_size
    type:
      - 'null'
      - int
    doc: 'The indel size. Default: 50bp'
    default: 50
    inputBinding:
      position: 102
      prefix: -I
  - id: insert_size
    type:
      - 'null'
      - int
    doc: 'The insert size. Used for SV calling. Default: 300'
    default: 300
    inputBinding:
      position: 102
      prefix: --insert-size
  - id: insert_std
    type:
      - 'null'
      - int
    doc: 'The insert size STD. Used for SV calling. Default: 100'
    default: 100
    inputBinding:
      position: 102
      prefix: --insert-std
  - id: insert_std_amt
    type:
      - 'null'
      - int
    doc: 'The number of STD. A pair will be considered for DEL if INSERT > INSERT_SIZE
      + INSERT_STD_AMT * INSERT_STD. Default: 4'
    default: 4
    inputBinding:
      position: 102
      prefix: -A
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: 'If set, reads with mismatches more than INT will be filtered and ignored.
      Gaps are not counted as mismatches. Valid only for bowtie2/TopHat or BWA aln
      followed by sampe. BWA mem is calculated as NM - Indels. Default: 8, or reads
      with more than 8 mismatches will not be used.'
    default: 8
    inputBinding:
      position: 102
      prefix: -m
  - id: min_base_quality
    type:
      - 'null'
      - float
    doc: 'The phred score for a base to be considered a good call. Default: 22.5 (for
      Illumina) For PGM, set it to ~15, as PGM tends to under estimate base quality.'
    default: 22.5
    inputBinding:
      position: 102
      prefix: -q
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: If set, reads with mapping quality less than INT will be filtered and 
      ignored
    inputBinding:
      position: 102
      prefix: -Q
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: 'The reads should have at least mean MapQ to be considered a valid variant.
      Default: no filtering'
    inputBinding:
      position: 102
      prefix: -O
  - id: min_matches
    type:
      - 'null'
      - int
    doc: 'The minimum matches for a read to be considered. If, after soft-clipping,
      the matched bp is less than INT, then the read is discarded. It is meant for
      PCR based targeted sequencing where there is no insert and the matching is only
      the primers. Default: 25, or reads with matches less than 25bp will be filtered'
    default: 25
    inputBinding:
      position: 102
      prefix: -M
  - id: min_strand_bias_reads
    type:
      - 'null'
      - int
    doc: 'The minimum # of reads to determine strand bias, default 2'
    default: 2
    inputBinding:
      position: 102
      prefix: -B
  - id: min_strand_bias_reads_count
    type:
      - 'null'
      - int
    doc: 'The minimum # of reads to determine strand bias, default 2'
    default: 2
    inputBinding:
      position: 102
      prefix: -B
  - id: min_sv_length
    type:
      - 'null'
      - int
    doc: 'The minimum structural variant length to be presented using <DEL> <DUP>
      <INV> <INS>, etc. Default: 500. Any indel, complex variants less than this will
      be spelled out with exact nucleotides'
    default: 500
    inputBinding:
      position: 102
      prefix: -L
  - id: min_variant_reads
    type:
      - 'null'
      - int
    doc: 'The minimum # of variance reads, default 2'
    default: 2
    inputBinding:
      position: 102
      prefix: -r
  - id: min_variant_reads_count
    type:
      - 'null'
      - int
    doc: 'The minimum # of variance reads, default 2'
    default: 2
    inputBinding:
      position: 102
      prefix: -r
  - id: mismatch_extension
    type:
      - 'null'
      - int
    doc: Extension of bp to look for mismatches after insersion or deletion. 
      Default to 3 bp, or only calls when they are within 3 bp.
    default: 3
    inputBinding:
      position: 102
      prefix: -X
  - id: move_indels_3prime
    type:
      - 'null'
      - boolean
    doc: Indicate to move indels to 3-prime if alternative alignment can be 
      achieved.
    inputBinding:
      position: 102
      prefix: '-3'
  - id: name_reg
    type:
      - 'null'
      - string
    doc: 'The regular expression to extract sample name from bam filenames. Default
      to: /([^/._]+?)_[^/]*.bam/'
    inputBinding:
      position: 102
      prefix: -n
  - id: no_chimeric_filtering
    type:
      - 'null'
      - boolean
    doc: Indicate to turn off chimeric reads filtering. Chimeric reads are 
      artifacts from library construction, where a read can be split into two 
      segments, each will be aligned within 1-2 read length distance, but in 
      opposite direction.
    inputBinding:
      position: 102
      prefix: --chimeric
  - id: no_sv_calling
    type:
      - 'null'
      - boolean
    doc: Turn off structural variant calling
    inputBinding:
      position: 102
      prefix: --nosv
  - id: normal_freq_threshold
    type:
      - 'null'
      - float
    doc: The lowest frequency in normal sample allowed for a putative somatic 
      mutations. Default to 0.05
    default: 0.05
    inputBinding:
      position: 102
      prefix: -V
  - id: numeric_chromosomes
    type:
      - 'null'
      - boolean
    doc: Indicate the chromosome names are just numbers, such as 1, 2, not chr1,
      chr2 (deprecated)
    inputBinding:
      position: 102
      prefix: -C
  - id: perform_local_realignment
    type:
      - 'null'
      - int
    doc: 'Indicate whether to perform local realignment. Default: 1 or yes. Set to
      0 to disable it. For Ion or PacBio, 0 is recommended.'
    default: 1
    inputBinding:
      position: 102
      prefix: -k
  - id: pileup_regardless_freq
    type:
      - 'null'
      - boolean
    doc: Do pileup regarless the frequency
    inputBinding:
      position: 102
      prefix: -p
  - id: qratio
    type:
      - 'null'
      - float
    doc: 'The Qratio of (good_quality_reads)/(bad_quality_reads+0.5). The quality
      is defined by -q option. Default: 1.5'
    default: 1.5
    inputBinding:
      position: 102
      prefix: -o
  - id: read_position_filter
    type:
      - 'null'
      - int
    doc: 'The read position filter. If the mean variants position is less that specified,
      it is considered false positive. Default: 5'
    default: 5
    inputBinding:
      position: 102
      prefix: -P
  - id: ref_extension
    type:
      - 'null'
      - int
    doc: Extension of bp of reference to build lookup table. Default to 1200 bp.
      Increase the number will slowdown the program. The main purpose is to call
      large indels within 1000 bp that can be missed by discordant mate pairs.
    default: 1200
    inputBinding:
      position: 102
      prefix: --ref-extension
  - id: region
    type:
      - 'null'
      - string
    doc: The region of interest. In the format of chr:start-end. If end is 
      omitted, then a single position. No BED is needed.
    inputBinding:
      position: 102
      prefix: -R
  - id: region_delimiter
    type:
      - 'null'
      - string
    doc: "The delimiter for split region_info, default to tab \"\t\""
    default: "\t"
    inputBinding:
      position: 102
      prefix: -d
  - id: sample_name
    type:
      - 'null'
      - string
    doc: The sample name to be used directly. Will overwrite -n option
    inputBinding:
      position: 102
      prefix: -N
  - id: sample_name_regex
    type:
      - 'null'
      - string
    doc: 'The regular expression to extract sample name from bam filenames. Default
      to: /([^/._]+?)_[^/]*.bam/'
    inputBinding:
      position: 102
      prefix: -n
  - id: seg_ends_col
    type:
      - 'null'
      - int
    doc: The column for segment ends in the region, e.g. exon ends
    inputBinding:
      position: 102
      prefix: -e
  - id: seg_starts_col
    type:
      - 'null'
      - int
    doc: The column for segment starts in the region, e.g. exon starts
    inputBinding:
      position: 102
      prefix: -s
  - id: segment_ends_col
    type:
      - 'null'
      - int
    doc: The column for segment ends in the region, e.g. exon ends
    inputBinding:
      position: 102
      prefix: -e
  - id: segment_starts_col
    type:
      - 'null'
      - int
    doc: The column for segment starts in the region, e.g. exon starts
    inputBinding:
      position: 102
      prefix: -s
  - id: splice_counts
    type:
      - 'null'
      - boolean
    doc: Output splicing read counts
    inputBinding:
      position: 102
      prefix: --splice
  - id: start_col
    type:
      - 'null'
      - int
    doc: The column for region start, e.g. gene start
    inputBinding:
      position: 102
      prefix: -S
  - id: start_col_region
    type:
      - 'null'
      - int
    doc: The column for region start, e.g. gene start
    inputBinding:
      position: 102
      prefix: -S
  - id: trim_bases
    type:
      - 'null'
      - int
    doc: Trim bases after [INT] bases in the reads
    inputBinding:
      position: 102
      prefix: --trim
  - id: unique_mode
    type:
      - 'null'
      - boolean
    doc: Indicate unique mode, which when mate pairs overlap, the overlapping 
      part will be counted only once using forward read only.
    inputBinding:
      position: 102
      prefix: -u
  - id: vcf_output
    type:
      - 'null'
      - boolean
    doc: VCF format output
    inputBinding:
      position: 102
      prefix: -v
  - id: verbose_mode
    type:
      - 'null'
      - boolean
    doc: Verbose mode. Will output variant calling process.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: zero_based_coordinates
    type:
      - 'null'
      - int
    doc: 'Indicate wehther is zero-based cooridates, as IGV does. Default: 1 for BED
      file or amplicon BED file. Use 0 to turn it off. When use -R option, it is set
      to 0'
    default: 1
    inputBinding:
      position: 102
      prefix: -z
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict:2019.06.04--pl526_0
stdout: vardict.out
