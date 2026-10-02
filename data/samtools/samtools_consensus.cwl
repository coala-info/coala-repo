cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - consensus
label: samtools_consensus
doc: Produce consensus sequence from BAM/CRAM/SAM files
inputs:
  - id: in_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: region
    type:
      - 'null'
      - string
    doc: Limit query to REG. Requires an index
    inputBinding:
      position: 102
      prefix: --region
  - id: format
    type:
      - 'null'
      - string
    doc: Output in format FASTA, FASTQ or PILEUP
    inputBinding:
      position: 102
      prefix: --format
  - id: line_len
    type:
      - 'null'
      - int
    doc: Wrap FASTA/Q at line length INT
    inputBinding:
      position: 102
      prefix: --line-len
  - id: output
    type:
      - 'null'
      - string
    doc: Output consensus to FILE
    inputBinding:
      position: 102
      prefix: --output
  - id: mode
    type:
      - 'null'
      - string
    doc: Switch consensus mode to "simple"/"bayesian"
    inputBinding:
      position: 102
      prefix: --mode
  - id: all_bases
    type:
      - 'null'
      - boolean
    doc: Output all bases (start/end of reference)
    inputBinding:
      position: 102
      prefix: -a
  - id: incl_flags
    type:
      - 'null'
      - string
    doc: Only include reads with any flag bit set
    inputBinding:
      position: 102
      prefix: --incl-flags
  - id: excl_flags
    type:
      - 'null'
      - string
    doc: Exclude reads with any flag bit set
    inputBinding:
      position: 102
      prefix: --excl-flags
  - id: min_mq
    type:
      - 'null'
      - int
    doc: Exclude reads with mapping quality below INT
    inputBinding:
      position: 102
      prefix: --min-MQ
  - id: min_bq
    type:
      - 'null'
      - int
    doc: Exclude reads with base quality below INT
    inputBinding:
      position: 102
      prefix: --min-BQ
  - id: show_del
    type:
      - 'null'
      - string
    doc: Whether to show deletion as "*"
    inputBinding:
      position: 102
      prefix: --show-del
  - id: show_ins
    type:
      - 'null'
      - string
    doc: Whether to show insertions
    inputBinding:
      position: 102
      prefix: --show-ins
  - id: mark_ins
    type:
      - 'null'
      - boolean
    doc: Add '+' before every inserted base/qual
    inputBinding:
      position: 102
      prefix: --mark-ins
  - id: ambig
    type:
      - 'null'
      - boolean
    doc: Enable IUPAC ambiguity codes
    inputBinding:
      position: 102
      prefix: --ambig
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth of INT
    inputBinding:
      position: 102
      prefix: --min-depth
  - id: block_size
    type:
      - 'null'
      - int
    doc: Size of chromosome block (bp) when threading
    inputBinding:
      position: 102
      prefix: --block-size
  - id: ref_qual
    type:
      - 'null'
      - int
    doc: QUAL to use for reference bases
    inputBinding:
      position: 102
      prefix: --ref-qual
  - id: use_qual
    type:
      - 'null'
      - boolean
    doc: Use quality values in calculation
    inputBinding:
      position: 102
      prefix: --use-qual
  - id: no_use_qual
    type:
      - 'null'
      - boolean
    doc: Do not use quality values in calculation
    inputBinding:
      position: 102
      prefix: --no-use-qual
  - id: call_fract
    type:
      - 'null'
      - float
    doc: At least INT portion of bases must agree
    inputBinding:
      position: 102
      prefix: --call-fract
  - id: het_fract
    type:
      - 'null'
      - float
    doc: Minimum fraction of 2nd-most to most common base
    inputBinding:
      position: 102
      prefix: --het-fract
  - id: cutoff
    type:
      - 'null'
      - int
    doc: Consensus cutoff quality C
    inputBinding:
      position: 102
      prefix: --cutoff
  - id: adj_qual
    type:
      - 'null'
      - boolean
    doc: Modify quality with local minima
    inputBinding:
      position: 102
      prefix: --adj-qual
  - id: no_adj_qual
    type:
      - 'null'
      - boolean
    doc: Do not modify quality with local minima
    inputBinding:
      position: 102
      prefix: --no-adj-qual
  - id: use_mq
    type:
      - 'null'
      - boolean
    doc: Use mapping quality in calculation
    inputBinding:
      position: 102
      prefix: --use-MQ
  - id: no_use_mq
    type:
      - 'null'
      - boolean
    doc: Do not use mapping quality in calculation
    inputBinding:
      position: 102
      prefix: --no-use-MQ
  - id: adj_mq
    type:
      - 'null'
      - boolean
    doc: Modify mapping quality by local NM
    inputBinding:
      position: 102
      prefix: --adj-MQ
  - id: no_adj_mq
    type:
      - 'null'
      - boolean
    doc: Do not modify mapping quality by local NM
    inputBinding:
      position: 102
      prefix: --no-adj-MQ
  - id: nm_halo
    type:
      - 'null'
      - int
    doc: Size of window for NM count in --adj-MQ
    inputBinding:
      position: 102
      prefix: --NM-halo
  - id: scale_mq
    type:
      - 'null'
      - float
    doc: Scale mapping quality by FLOAT
    inputBinding:
      position: 102
      prefix: --scale-MQ
  - id: low_mq
    type:
      - 'null'
      - int
    doc: Cap minimum mapping quality
    inputBinding:
      position: 102
      prefix: --low-MQ
  - id: high_mq
    type:
      - 'null'
      - int
    doc: Cap maximum mapping quality
    inputBinding:
      position: 102
      prefix: --high-MQ
  - id: p_het
    type:
      - 'null'
      - float
    doc: Probability of heterozygous site
    inputBinding:
      position: 102
      prefix: --P-het
  - id: p_indel
    type:
      - 'null'
      - float
    doc: Probability of indel sites
    inputBinding:
      position: 102
      prefix: --P-indel
  - id: het_scale
    type:
      - 'null'
      - float
    doc: Heterozygous SNP probability multiplier
    inputBinding:
      position: 102
      prefix: --het-scale
  - id: homopoly_fix
    type:
      - 'null'
      - boolean
    doc: Spread low-qual bases to both ends of homopolymers
    inputBinding:
      position: 102
      prefix: --homopoly-fix
  - id: homopoly_score
    type:
      - 'null'
      - float
    doc: Qual fraction adjustment for -p option
    inputBinding:
      position: 102
      prefix: --homopoly-score
  - id: qual_calibration
    type:
      - 'null'
      - string
    doc: Load quality calibration file
    inputBinding:
      position: 102
      prefix: --qual-calibration
  - id: config
    type:
      - 'null'
      - string
    doc: 'Use pre-defined configuration set. STR from: hiseq, hifi, r10.4_sup, r10.4_dup
      and ultima'
    inputBinding:
      position: 102
      prefix: --config
  - id: input_fmt_option
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --input-fmt-option
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE
    secondaryFiles:
      - .fai
    inputBinding:
      position: 102
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional decompression threads to use
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: Output consensus to FILE
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
