cwlVersion: v1.2
class: CommandLineTool
baseCommand: vardict
label: vardict
doc: 'VarDict is a variant calling program for SNV, MNV, indels (<120 bp default,
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
  region_info is an entry of refGene.txt from IGV, but can be any region or bed files.


  Tool homepage: https://github.com/AstraZeneca-NGS/VarDict'
inputs:
  - id: region_info
    type:
      - 'null'
      - File
    doc: Entry of refGene.txt from IGV, or any region or BED file (not needed when
      -R is used).
    inputBinding:
      position: 1
  - id: bam_file
    type:
      - 'null'
      - File
    secondaryFiles:
      - .bai
    doc: The indexed BAM file
    inputBinding:
      position: 102
      prefix: -b
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
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print a header row describing columns
    inputBinding:
      position: 102
      prefix: -h
  - id: vcf_output
    type:
      - 'null'
      - boolean
    doc: VCF format output
    inputBinding:
      position: 102
      prefix: -v
  - id: splice
    type:
      - 'null'
      - boolean
    doc: Output splicing read counts
    inputBinding:
      position: 102
      prefix: -i
  - id: pileup_regardless_freq
    type:
      - 'null'
      - boolean
    doc: Do pileup regardless the frequency
    inputBinding:
      position: 102
      prefix: -p
  - id: numeric_chromosomes
    type:
      - 'null'
      - boolean
    doc: Indicate the chromosome names are just numbers, such as 1, 2, not chr1, chr2
      (deprecated)
    inputBinding:
      position: 102
      prefix: -C
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode. Will print some error messages and append full genotype at the
      end.
    inputBinding:
      position: 102
      prefix: -D
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode. Will output variant calling process.
    inputBinding:
      position: 102
      prefix: -y
  - id: dedup
    type:
      - 'null'
      - boolean
    doc: Indicate to remove duplicated reads. Only one pair with same start positions
      will be kept
    inputBinding:
      position: 102
      prefix: -t
  - id: move_indels_3prime
    type:
      - 'null'
      - boolean
    doc: Indicate to move indels to 3-prime if alternative alignment can be achieved.
    inputBinding:
      position: 102
      prefix: '-3'
  - id: nosv
    type:
      - 'null'
      - boolean
    doc: Turn off structural variant calling
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
  - id: filter_reads_hex
    type:
      - 'null'
      - string
    doc: 'The hexical to filter reads using samtools. Default: 0x500 (filter 2nd alignments
      and duplicates). Use -F 0 to turn it off.'
    inputBinding:
      position: 102
      prefix: -F
  - id: zero_based_coordinates
    type:
      - 'null'
      - int
    doc: 'Indicate whether is zero-based coordinates, as IGV does. Default: 1 for
      BED file or amplicon BED file. Use 0 to turn it off. When use -R option, it
      is set to 0'
    inputBinding:
      position: 102
      prefix: -z
  - id: amplicon
    type:
      - 'null'
      - string
    doc: 'Indicate it is amplicon based calling. Reads do not map to the amplicon
      will be skipped. A read pair is considered belonging the amplicon if the edges
      are less than int bp to the amplicon, and overlap fraction is at least float.
      Default: 10:0.95 (int:float)'
    inputBinding:
      position: 102
      prefix: -a
  - id: local_realignment
    type:
      - 'null'
      - int
    doc: 'Indicate whether to perform local realignment. Default: 1 or yes. Set to
      0 to disable it. For Ion or PacBio, 0 is recommended.'
    inputBinding:
      position: 102
      prefix: -k
  - id: region
    type:
      - 'null'
      - string
    doc: The region of interest. In the format of chr:start-end. If end is omitted,
      then a single position. No BED is needed.
    inputBinding:
      position: 102
      prefix: -R
  - id: delimiter
    type:
      - 'null'
      - string
    doc: The delimiter for split region_info, default to tab
    inputBinding:
      position: 102
      prefix: -d
  - id: sample_name_regex
    type:
      - 'null'
      - string
    doc: 'The regular expression to extract sample name from bam filenames. Default
      to: /([^/._]+?)_[^/]*.bam/'
    inputBinding:
      position: 102
      prefix: -n
  - id: sample_name
    type:
      - 'null'
      - string
    doc: The sample name to be used directly. Will overwrite -n option
    inputBinding:
      position: 102
      prefix: -N
  - id: chr_col
    type:
      - 'null'
      - int
    doc: The column for chromosome
    inputBinding:
      position: 102
      prefix: -c
  - id: start_col
    type:
      - 'null'
      - int
    doc: The column for region start, e.g. gene start
    inputBinding:
      position: 102
      prefix: -S
  - id: end_col
    type:
      - 'null'
      - int
    doc: The column for region end, e.g. gene end
    inputBinding:
      position: 102
      prefix: -E
  - id: seg_starts_col
    type:
      - 'null'
      - int
    doc: The column for segment starts in the region, e.g. exon starts
    inputBinding:
      position: 102
      prefix: -s
  - id: seg_ends_col
    type:
      - 'null'
      - int
    doc: The column for segment ends in the region, e.g. exon ends
    inputBinding:
      position: 102
      prefix: -e
  - id: gene_col
    type:
      - 'null'
      - int
    doc: The column for gene name, or segment annotation
    inputBinding:
      position: 102
      prefix: -g
  - id: extend_nucleotides
    type:
      - 'null'
      - int
    doc: 'The number of nucleotide to extend for each segment, default: 0'
    inputBinding:
      position: 102
      prefix: -x
  - id: allele_freq_threshold
    type:
      - 'null'
      - float
    doc: 'The threshold for allele frequency, default: 0.01 or 1%'
    inputBinding:
      position: 102
      prefix: -f
  - id: min_variant_reads
    type:
      - 'null'
      - int
    doc: 'The minimum # of variance reads, default 2'
    inputBinding:
      position: 102
      prefix: -r
  - id: min_strand_bias_reads
    type:
      - 'null'
      - int
    doc: 'The minimum # of reads to determine strand bias, default 2'
    inputBinding:
      position: 102
      prefix: -B
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
      - float
    doc: 'The phred score for a base to be considered a good call. Default: 22.5 (for
      Illumina). For PGM, set it to ~15.'
    inputBinding:
      position: 102
      prefix: -q
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: 'If set, reads with mismatches more than INT will be filtered and ignored.
      Gaps are not counted as mismatches. Default: 8'
    inputBinding:
      position: 102
      prefix: -m
  - id: trim_bases
    type:
      - 'null'
      - int
    doc: Trim bases after [INT] bases in the reads
    inputBinding:
      position: 102
      prefix: -T
  - id: mismatch_extension
    type:
      - 'null'
      - int
    doc: Extension of bp to look for mismatches after insertion or deletion. Default
      to 3 bp, or only calls when they are within 3 bp.
    inputBinding:
      position: 102
      prefix: -X
  - id: ref_extension
    type:
      - 'null'
      - int
    doc: Extension of bp of reference to build lookup table. Default to 1200 bp. Increase
      the number will slowdown the program.
    inputBinding:
      position: 102
      prefix: -Y
  - id: read_position_filter
    type:
      - 'null'
      - float
    doc: 'The read position filter. If the mean variants position is less that specified,
      it is considered false positive. Default: 5'
    inputBinding:
      position: 102
      prefix: -P
  - id: downsample_fraction
    type:
      - 'null'
      - float
    doc: 'For downsampling fraction. e.g. 0.7 means roughly 70% downsampling. Default:
      No downsampling. Use with caution. The downsampling will be random and non-reproducible.'
    inputBinding:
      position: 102
      prefix: -Z
  - id: qratio
    type:
      - 'null'
      - float
    doc: 'The Qratio of (good_quality_reads)/(bad_quality_reads+0.5). The quality
      is defined by -q option. Default: 1.5'
    inputBinding:
      position: 102
      prefix: -o
  - id: min_mapq
    type:
      - 'null'
      - float
    doc: 'The reads should have at least mean MapQ to be considered a valid variant.
      Default: no filtering'
    inputBinding:
      position: 102
      prefix: -O
  - id: normal_freq_threshold
    type:
      - 'null'
      - float
    doc: The lowest frequency in normal sample allowed for a putative somatic mutations.
      Default to 0.05
    inputBinding:
      position: 102
      prefix: -V
  - id: indel_size
    type:
      - 'null'
      - int
    doc: 'The indel size. Default: 50bp'
    inputBinding:
      position: 102
      prefix: -I
  - id: min_matches
    type:
      - 'null'
      - int
    doc: 'The minimum matches for a read to be considered. If, after soft-clipping,
      the matched bp is less than INT, then the read is discarded. It is meant for
      PCR based targeted sequencing where there is no insert and the matching is only
      the primers. Default: 25'
    inputBinding:
      position: 102
      prefix: -M
  - id: min_sv_length
    type:
      - 'null'
      - int
    doc: 'The minimum structural variant length to be presented using <DEL> <DUP>
      <INV> <INS>, etc. Default: 500. Any indel, complex variants less than this will
      be spelled out with exact nucleotides'
    inputBinding:
      position: 102
      prefix: -L
  - id: insert_size
    type:
      - 'null'
      - int
    doc: 'The insert size. Used for SV calling. Default: 300'
    inputBinding:
      position: 102
      prefix: -w
  - id: insert_std
    type:
      - 'null'
      - int
    doc: 'The insert size STD. Used for SV calling. Default: 100'
    inputBinding:
      position: 102
      prefix: -W
  - id: insert_std_amt
    type:
      - 'null'
      - int
    doc: 'The number of STD. A pair will be considered for DEL if INSERT > INSERT_SIZE
      + INSERT_STD_AMT * INSERT_STD. Default: 4'
    inputBinding:
      position: 102
      prefix: -A
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
  - id: no_chimeric_filtering
    type:
      - 'null'
      - boolean
    doc: Indicate to turn off chimeric reads filtering.
    inputBinding:
      position: 102
      prefix: --chimeric
  - id: adaptor_sequences
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --adaptor
    doc: Filter adaptor sequences so that they are not used in realignment. Multiple
      adaptors can be supplied by multiple of this option.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict:2019.06.04--pl526_0
stdout: vardict.out

