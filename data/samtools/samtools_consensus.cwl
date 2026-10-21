cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- consensus
label: samtools_consensus
doc: 'Produce a consensus FASTA/FASTQ/pileup from an alignment file


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: in_bam
  type: File
  doc: Input sorted alignment file (index needed for --region).
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: .csi
    required: false
  - pattern: .crai
    required: false
  - pattern: ^.bai
    required: false
  inputBinding:
    position: 104
- id: region
  type:
  - 'null'
  - string
  doc: Limit query to REG; requires an index.
  inputBinding:
    position: 103
    prefix: --region
- id: format
  type:
  - 'null'
  - string
  doc: Output in format FASTA, FASTQ or PILEUP [FASTA].
  inputBinding:
    position: 103
    prefix: --format
- id: line_len
  type:
  - 'null'
  - int
  doc: Wrap FASTA/Q at line length INT [70].
  inputBinding:
    position: 103
    prefix: --line-len
- id: output_filename
  type: string
  doc: Output consensus to this file (-o).
  default: consensus.fa
  inputBinding:
    position: 103
    prefix: -o
- id: mode
  type:
  - 'null'
  - string
  doc: Switch consensus mode to simple or bayesian [bayesian].
  inputBinding:
    position: 103
    prefix: --mode
- id: all_bases
  type:
  - 'null'
  - boolean
  doc: Output all bases (start/end of reference).
  inputBinding:
    position: 103
    prefix: -a
- id: incl_flags
  type:
  - 'null'
  - string
  doc: Only include reads with any flag bit set [0].
  inputBinding:
    position: 103
    prefix: --incl-flags
- id: excl_flags
  type:
  - 'null'
  - string
  doc: Exclude reads with any flag bit set [UNMAP,SECONDARY,QCFAIL,DUP].
  inputBinding:
    position: 103
    prefix: --excl-flags
- id: min_mq
  type:
  - 'null'
  - int
  doc: Exclude reads with mapping quality below INT [0].
  inputBinding:
    position: 103
    prefix: --min-MQ
- id: min_bq
  type:
  - 'null'
  - int
  doc: Exclude reads with base quality below INT [0].
  inputBinding:
    position: 103
    prefix: --min-BQ
- id: show_del
  type:
  - 'null'
  - string
  doc: Whether to show deletion as '*' (yes/no) [no].
  inputBinding:
    position: 103
    prefix: --show-del
- id: show_ins
  type:
  - 'null'
  - string
  doc: Whether to show insertions (yes/no) [yes].
  inputBinding:
    position: 103
    prefix: --show-ins
- id: mark_ins
  type:
  - 'null'
  - boolean
  doc: Add '+' before every inserted base/qual.
  inputBinding:
    position: 103
    prefix: --mark-ins
- id: ambig
  type:
  - 'null'
  - boolean
  doc: Enable IUPAC ambiguity codes.
  inputBinding:
    position: 103
    prefix: --ambig
- id: min_depth
  type:
  - 'null'
  - int
  doc: Minimum depth of INT [1].
  inputBinding:
    position: 103
    prefix: --min-depth
- id: block_size
  type:
  - 'null'
  - int
  doc: Size of chromosome block (bp) when threading [100000].
  inputBinding:
    position: 103
    prefix: --block-size
- id: ref_qual
  type:
  - 'null'
  - int
  doc: QUAL to use for reference bases [0].
  inputBinding:
    position: 103
    prefix: --ref-qual
- id: use_qual
  type:
  - 'null'
  - boolean
  doc: 'Simple mode: use quality values in calculation.'
  inputBinding:
    position: 103
    prefix: --use-qual
- id: no_use_qual
  type:
  - 'null'
  - boolean
  doc: 'Simple mode: do not use quality values in calculation.'
  inputBinding:
    position: 103
    prefix: --no-use-qual
- id: call_fract
  type:
  - 'null'
  - float
  doc: 'Simple mode: at least this portion of bases must agree [0.75].'
  inputBinding:
    position: 103
    prefix: --call-fract
- id: het_fract
  type:
  - 'null'
  - float
  doc: 'Simple mode: minimum fraction of 2nd-most to most common base [0.15].'
  inputBinding:
    position: 103
    prefix: --het-fract
- id: cutoff
  type:
  - 'null'
  - int
  doc: 'Bayesian mode: consensus cutoff quality C [10].'
  inputBinding:
    position: 103
    prefix: --cutoff
- id: adj_qual
  type:
  - 'null'
  - boolean
  doc: 'Bayesian mode: modify quality with local minima [on].'
  inputBinding:
    position: 103
    prefix: --adj-qual
- id: no_adj_qual
  type:
  - 'null'
  - boolean
  doc: 'Bayesian mode: do not modify quality with local minima.'
  inputBinding:
    position: 103
    prefix: --no-adj-qual
- id: use_mq
  type:
  - 'null'
  - boolean
  doc: 'Bayesian mode: use mapping quality in calculation [on].'
  inputBinding:
    position: 103
    prefix: --use-MQ
- id: no_use_mq
  type:
  - 'null'
  - boolean
  doc: 'Bayesian mode: do not use mapping quality in calculation.'
  inputBinding:
    position: 103
    prefix: --no-use-MQ
- id: adj_mq
  type:
  - 'null'
  - boolean
  doc: 'Bayesian mode: modify mapping quality by local NM [on].'
  inputBinding:
    position: 103
    prefix: --adj-MQ
- id: no_adj_mq
  type:
  - 'null'
  - boolean
  doc: 'Bayesian mode: do not modify mapping quality by local NM.'
  inputBinding:
    position: 103
    prefix: --no-adj-MQ
- id: nm_halo
  type:
  - 'null'
  - int
  doc: Size of window for NM count in --adj-MQ [50].
  inputBinding:
    position: 103
    prefix: --NM-halo
- id: scale_mq
  type:
  - 'null'
  - float
  doc: Scale mapping quality by FLOAT [1.00].
  inputBinding:
    position: 103
    prefix: --scale-MQ
- id: low_mq
  type:
  - 'null'
  - int
  doc: Cap minimum mapping quality [1].
  inputBinding:
    position: 103
    prefix: --low-MQ
- id: high_mq
  type:
  - 'null'
  - int
  doc: Cap maximum mapping quality [60].
  inputBinding:
    position: 103
    prefix: --high-MQ
- id: p_het
  type:
  - 'null'
  - float
  doc: Probability of heterozygous site [1.0e-03].
  inputBinding:
    position: 103
    prefix: --P-het
- id: p_indel
  type:
  - 'null'
  - float
  doc: Probability of indel sites [2.0e-04].
  inputBinding:
    position: 103
    prefix: --P-indel
- id: het_scale
  type:
  - 'null'
  - float
  doc: Heterozygous SNP probability multiplier [1.0e+00].
  inputBinding:
    position: 103
    prefix: --het-scale
- id: homopoly_fix
  type:
  - 'null'
  - boolean
  doc: Spread low-qual bases to both ends of homopolymers.
  inputBinding:
    position: 103
    prefix: --homopoly-fix
- id: homopoly_score
  type:
  - 'null'
  - float
  doc: Qual fraction adjustment for --homopoly-fix [0.5].
  inputBinding:
    position: 103
    prefix: --homopoly-score
- id: qual_calibration
  type:
  - 'null'
  - File
  doc: Load quality calibration file (or :config, see man page).
  inputBinding:
    position: 103
    prefix: --qual-calibration
- id: config
  type:
  - 'null'
  - string
  doc: 'Use pre-defined configuration set: hiseq, hifi, r10.4_sup, r10.4_dup or ultima.'
  inputBinding:
    position: 103
    prefix: --config
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence FASTA file.
  secondaryFiles:
  - pattern: .fai
    required: false
  inputBinding:
    position: 103
    prefix: --reference
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional decompression threads to use [0].
  inputBinding:
    position: 103
    prefix: --threads
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity.
  inputBinding:
    position: 103
    prefix: --verbosity
- id: input_fmt_option
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --input-fmt-option
  doc: Specify a single input file format option in the form OPTION or OPTION=VALUE (repeatable).
  inputBinding:
    position: 103
outputs:
- id: output
  type: File
  doc: Consensus sequence.
  outputBinding:
    glob: $(inputs.output_filename)
