cwlVersion: v1.2
class: CommandLineTool
baseCommand: vardict-java
label: vardict-java_vardict-java
doc: 'VarDict is a variant calling program for SNV, MNV, indels (<50 bp), and complex
  variants. It accepts any BAM format, either from DNA-seq or RNA-seq. It can perform
  local realignment over indels on the fly, rescues softly clipped reads, supports
  amplicon-based calling and paired sample (somatic) analysis. By default, the region_info
  is an entry of refGene.txt from IGV, but can be any region or BED file.


  Tool homepage: https://github.com/AstraZeneca-NGS/VarDictJava'
inputs:
  - id: region_info
    type:
      - 'null'
      - File
    doc: Entry of refGene.txt from IGV, or any region or BED file (not needed when
      -R is used).
    inputBinding:
      position: 1
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    secondaryFiles:
      - .bai
    doc: The indexed BAM file. For paired (tumor/normal) calling give two files, tumor
      first; they are joined with "|".
    inputBinding:
      position: 102
      prefix: -b
      itemSeparator: '|'
  - id: genome_fasta
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: The reference fasta. Should be indexed (.fai).
    inputBinding:
      position: 102
      prefix: -G
  - id: adaptor_sequences
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter adaptor sequences so that they are not used in realignment. Several
      adaptors are joined with a comma.
    inputBinding:
      position: 102
      prefix: -adaptor
      itemSeparator: ','
  - id: move_indels_3prime
    type:
      - 'null'
      - boolean
    doc: Indicate to move indels to 3-prime if alternative alignment can be achieved.
    inputBinding:
      position: 102
      prefix: '-3'
  - id: insert_std_amt
    type:
      - 'null'
      - int
    doc: 'The number of STD. A pair will be considered for DEL if INSERT > INSERT_SIZE
      + INSERT_STD_AMT * INSERT_STD. Default: 4'
    inputBinding:
      position: 102
      prefix: -A
  - id: amplicon
    type:
      - 'null'
      - string
    doc: 'Indicate it is amplicon based calling (int:float). Reads that do not map
      to the amplicon will be skipped. Default: 10:0.95'
    inputBinding:
      position: 102
      prefix: -a
  - id: min_strand_bias_reads
    type:
      - 'null'
      - int
    doc: 'The minimum # of reads to determine strand bias, default 2'
    inputBinding:
      position: 102
      prefix: -B
  - id: numeric_chromosomes
    type:
      - 'null'
      - boolean
    doc: Indicate the chromosome names are just numbers, such as 1, 2, not chr1, chr2
      (deprecated)
    inputBinding:
      position: 102
      prefix: -C
  - id: chr_col
    type:
      - 'null'
      - int
    doc: The column for chromosome
    inputBinding:
      position: 102
      prefix: -c
  - id: chimeric
    type:
      - 'null'
      - boolean
    doc: Indicate to turn off chimeric reads filtering.
    inputBinding:
      position: 102
      prefix: -chimeric
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode. Will print some error messages and append full genotype at the
      end.
    inputBinding:
      position: 102
      prefix: -D
  - id: delimiter
    type:
      - 'null'
      - string
    doc: The delimiter for split region_info, default to tab
    inputBinding:
      position: 102
      prefix: -d
  - id: deldupvar
    type:
      - 'null'
      - boolean
    doc: Turn on deleting of duplicate variants. Variants in this mode are considered
      and outputted only if start position of variant is inside the region interest.
    inputBinding:
      position: 102
      prefix: -deldupvar
  - id: default_printer
    type:
      - 'null'
      - string
    doc: 'The printer type used for different outputs. Default: OUT (i.e. System.out).'
    inputBinding:
      position: 102
      prefix: -DP
  - id: end_col
    type:
      - 'null'
      - int
    doc: The column for region end, e.g. gene end
    inputBinding:
      position: 102
      prefix: -E
  - id: seg_ends_col
    type:
      - 'null'
      - int
    doc: The column for segment ends in the region, e.g. exon ends
    inputBinding:
      position: 102
      prefix: -e
  - id: filter_reads_hex
    type:
      - 'null'
      - string
    doc: 'The hexical to filter reads using samtools. Default: 0x504 (filter 2nd alignments,
      unmapped reads and duplicates). Use -F 0 to turn it off.'
    inputBinding:
      position: 102
      prefix: -F
  - id: allele_freq_threshold
    type:
      - 'null'
      - float
    doc: 'The threshold for allele frequency, default: 0.01 or 1%'
    inputBinding:
      position: 102
      prefix: -f
  - id: fisher
    type:
      - 'null'
      - boolean
    doc: 'Experimental feature: Changes R script (teststrandbias.R and testsomatic.)
      to Java implementation of Fisher exact test.'
    inputBinding:
      position: 102
      prefix: -fisher
  - id: gene_col
    type:
      - 'null'
      - int
    doc: The column for gene name, or segment annotation
    inputBinding:
      position: 102
      prefix: -g
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print a header row describing columns
    inputBinding:
      position: 102
      prefix: -h
  - id: indel_size
    type:
      - 'null'
      - int
    doc: 'The indel size. Default: 50bp'
    inputBinding:
      position: 102
      prefix: -I
  - id: splice
    type:
      - 'null'
      - boolean
    doc: Output splicing read counts
    inputBinding:
      position: 102
      prefix: -i
  - id: crispr_cutting_site
    type:
      - 'null'
      - string
    doc: The genomic position that CRISPR/Cas9 suppose to cut, typically 3bp from
      the PAM NGG site and within the guide. For CRISPR mode only.
    inputBinding:
      position: 102
      prefix: -J
  - id: crispr_filtering_bp
    type:
      - 'null'
      - int
    doc: 'In CRISPR mode, the minimum amount in bp that a read needs to overlap with
      cutting site. Default: not set, or no filtering'
    inputBinding:
      position: 102
      prefix: -j
  - id: include_ns
    type:
      - 'null'
      - boolean
    doc: Include Ns in the total depth calculation
    inputBinding:
      position: 102
      prefix: -K
  - id: local_realignment
    type:
      - 'null'
      - int
    doc: 'Indicate whether to perform local realignment (0/1). Default: 1. Set to
      0 to disable it. For Ion or PacBio, 0 is recommended.'
    inputBinding:
      position: 102
      prefix: -k
  - id: min_sv_length
    type:
      - 'null'
      - int
    doc: 'The minimum structural variant length to be presented using <DEL> <DUP>
      <INV> <INS>, etc. Default: 1000. Any indel, complex variants less than this
      will be spelled out with exact nucleotides.'
    inputBinding:
      position: 102
      prefix: -L
  - id: min_matches
    type:
      - 'null'
      - int
    doc: 'The minimum matches for a read to be considered. If, after soft-clipping,
      the matched bp is less than INT, then the read is discarded. Default: 0, or
      no filtering'
    inputBinding:
      position: 102
      prefix: -M
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: 'If set, reads with mismatches more than INT will be filtered and ignored.
      Gaps are not counted as mismatches. Default: 8'
    inputBinding:
      position: 102
      prefix: -m
  - id: monomer_msi_freq
    type:
      - 'null'
      - float
    doc: 'The variant frequency threshold to determine variant as good in case of
      monomer MSI. Default: 0.25'
    inputBinding:
      position: 102
      prefix: -mfreq
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
    doc: 'The regular expression to extract sample name from BAM filenames. Default
      to: /([^\/\._]+?)_[^\/]*.bam/'
    inputBinding:
      position: 102
      prefix: -n
  - id: non_monomer_msi_freq
    type:
      - 'null'
      - float
    doc: 'The variant frequency threshold to determine variant as good in case of
      non-monomer MSI. Default: 0.1'
    inputBinding:
      position: 102
      prefix: -nmfreq
  - id: min_mapq
    type:
      - 'null'
      - float
    doc: 'The reads should have at least mean MapQ to be considered a valid variant.
      Default: no filtering'
    inputBinding:
      position: 102
      prefix: -O
  - id: qratio
    type:
      - 'null'
      - float
    doc: 'The Qratio of (good_quality_reads)/(bad_quality_reads+0.5). The quality
      is defined by -q option. Default: 1.5'
    inputBinding:
      position: 102
      prefix: -o
  - id: read_position_filter
    type:
      - 'null'
      - float
    doc: 'The read position filter. If the mean variants position is less that specified,
      it is considered false positive. Default: 5'
    inputBinding:
      position: 102
      prefix: -P
  - id: pileup_regardless_freq
    type:
      - 'null'
      - boolean
    doc: Do pileup regardless of the frequency
    inputBinding:
      position: 102
      prefix: -p
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: If set, reads with mapping quality less than INT will be filtered and ignored
    inputBinding:
      position: 102
      prefix: -Q
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: 'The phred score for a base to be considered a good call. Default: 25 (for
      Illumina). For PGM, set it to ~15.'
    inputBinding:
      position: 102
      prefix: -q
  - id: region
    type:
      - 'null'
      - string
    doc: The region of interest. In the format of chr:start-end. If end is omitted,
      then a single position. No BED is needed.
    inputBinding:
      position: 102
      prefix: -R
  - id: min_variant_reads
    type:
      - 'null'
      - int
    doc: 'The minimum # of variant reads, default 2'
    inputBinding:
      position: 102
      prefix: -r
  - id: start_col
    type:
      - 'null'
      - int
    doc: The column for region start, e.g. gene start
    inputBinding:
      position: 102
      prefix: -S
  - id: seg_starts_col
    type:
      - 'null'
      - int
    doc: The column for segment starts in the region, e.g. exon starts
    inputBinding:
      position: 102
      prefix: -s
  - id: trim_bases
    type:
      - 'null'
      - int
    doc: Trim bases after [INT] bases in the reads
    inputBinding:
      position: 102
      prefix: -T
  - id: dedup
    type:
      - 'null'
      - boolean
    doc: Indicate to remove duplicated reads. Only one pair with same start positions
      will be kept
    inputBinding:
      position: 102
      prefix: -t
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads count.
    inputBinding:
      position: 102
      prefix: -th
  - id: nosv
    type:
      - 'null'
      - boolean
    doc: Turn off structural variant calling.
    inputBinding:
      position: 102
      prefix: -U
  - id: unique_mode
    type:
      - 'null'
      - boolean
    doc: Indicate unique mode, which when mate pairs overlap, the overlapping part
      will be counted only once using forward read only.
    inputBinding:
      position: 102
      prefix: -u
  - id: unique_first_read
    type:
      - 'null'
      - boolean
    doc: Indicate unique mode, which when mate pairs overlap, the overlapping part
      will be counted only once using first read only.
    inputBinding:
      position: 102
      prefix: -UN
  - id: normal_freq_threshold
    type:
      - 'null'
      - float
    doc: The lowest frequency in the normal sample allowed for a putative somatic
      mutation. Defaults to 0.05
    inputBinding:
      position: 102
      prefix: -V
  - id: vcf_output
    type:
      - 'null'
      - boolean
    doc: VCF format output
    inputBinding:
      position: 102
      prefix: -v
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: 'How strict to be when reading a SAM or BAM: STRICT, LENIENT or SILENT. Default:
      LENIENT'
    inputBinding:
      position: 102
      prefix: -VS
  - id: insert_std
    type:
      - 'null'
      - int
    doc: 'The insert size STD. Used for SV calling. Default: 100'
    inputBinding:
      position: 102
      prefix: -W
  - id: insert_size
    type:
      - 'null'
      - int
    doc: 'The insert size. Used for SV calling. Default: 300'
    inputBinding:
      position: 102
      prefix: -w
  - id: mismatch_extension
    type:
      - 'null'
      - int
    doc: Extension of bp to look for mismatches after insertion or deletion. Default
      to 2 bp, or only calls when they are within 2 bp.
    inputBinding:
      position: 102
      prefix: -X
  - id: extend_nucleotides
    type:
      - 'null'
      - int
    doc: 'The number of nucleotide to extend for each segment, default: 0'
    inputBinding:
      position: 102
      prefix: -x
  - id: ref_extension
    type:
      - 'null'
      - int
    doc: Extension of bp of reference to build lookup table. Default to 1200 bp.
    inputBinding:
      position: 102
      prefix: -Y
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode.
    inputBinding:
      position: 102
      prefix: -y
  - id: downsample_fraction
    type:
      - 'null'
      - float
    doc: 'For downsampling fraction. e.g. 0.7 means roughly 70% downsampling. Default:
      No downsampling. Use with caution.'
    inputBinding:
      position: 102
      prefix: -Z
  - id: zero_based_coordinates
    type:
      - 'null'
      - int
    doc: 'Indicate whether coordinates are zero-based, as IGV uses (0/1). Default:
      1 for BED file or amplicon BED file. Use 0 to turn it off. When using the -R
      option, it is set to 0'
    inputBinding:
      position: 102
      prefix: -z
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict-java:1.8.3--hdfd78af_0
stdout: vardict-java.out
