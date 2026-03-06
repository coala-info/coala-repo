cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- consensus
label: samtools_consensus
doc: "Generate consensus sequence from a BAM file\n\nTool homepage: https://github.com/samtools/samtools"
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entryname: $(inputs.reference.basename)
    entry: $(inputs.reference)
- class: InlineJavascriptRequirement
inputs:
- id: input_bam
  type: File
  doc: Input BAM file
  inputBinding:
    position: 1
- id: adj_mq
  type:
  - 'null'
  - boolean
  doc: Modify mapping quality by local NM (Bayesian mode)
  inputBinding:
    position: 102
    prefix: --adj-MQ
- id: adj_qual
  type:
  - 'null'
  - boolean
  doc: Modify quality with local minima (Bayesian mode)
  inputBinding:
    position: 102
    prefix: --adj-qual
- id: ambig
  type:
  - 'null'
  - boolean
  doc: Enable IUPAC ambiguity codes
  inputBinding:
    position: 102
    prefix: --ambig
- id: block_size
  type:
  - 'null'
  - int
  doc: Size of chromosome block (bp) when threading
  default: 100000
  inputBinding:
    position: 102
    prefix: --block-size
- id: call_fract
  type:
  - 'null'
  - float
  doc: At least INT portion of bases must agree (simple mode)
  default: 0.75
  inputBinding:
    position: 102
    prefix: --call-fract
- id: config
  type:
  - 'null'
  - string
  doc: Use pre-defined configuration set (hiseq, hifi, r10.4_sup, r10.4_dup, 
    ultima)
  inputBinding:
    position: 102
    prefix: --config
- id: cutoff
  type:
  - 'null'
  - int
  doc: Consensus cutoff quality C (Bayesian mode)
  default: 10
  inputBinding:
    position: 102
    prefix: --cutoff
- id: excl_flags
  type:
  - 'null'
  - string
  doc: Exclude reads with any flag bit set
  default: UNMAP,SECONDARY,QCFAIL,DUP
  inputBinding:
    position: 102
    prefix: --excl-flags
- id: format
  type:
  - 'null'
  - string
  doc: Output in format FASTA, FASTQ or PILEUP
  default: FASTA
  inputBinding:
    position: 102
    prefix: --format
- id: het_fract
  type:
  - 'null'
  - float
  doc: Minimum fraction of 2nd-most to most common base (simple mode)
  default: 0.15
  inputBinding:
    position: 102
    prefix: --het-fract
- id: het_scale
  type:
  - 'null'
  - float
  doc: Heterozygous SNP probability multiplier
  default: 1.0
  inputBinding:
    position: 102
    prefix: --het-scale
- id: high_mq
  type:
  - 'null'
  - int
  doc: Cap maximum mapping quality
  default: 60
  inputBinding:
    position: 102
    prefix: --high-MQ
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
  default: 0.5
  inputBinding:
    position: 102
    prefix: --homopoly-score
- id: incl_flags
  type:
  - 'null'
  - string
  doc: Only include reads with any flag bit set
  default: '0'
  inputBinding:
    position: 102
    prefix: --incl-flags
- id: input_fmt_option
  type:
  - 'null'
  - type: array
    items: string
  doc: Specify a single input file format option
  inputBinding:
    position: 102
    prefix: --input-fmt-option
- id: line_len
  type:
  - 'null'
  - int
  doc: Wrap FASTA/Q at line length INT
  default: 70
  inputBinding:
    position: 102
    prefix: --line-len
- id: low_mq
  type:
  - 'null'
  - int
  doc: Cap minimum mapping quality
  default: 1
  inputBinding:
    position: 102
    prefix: --low-MQ
- id: mark_ins
  type:
  - 'null'
  - boolean
  doc: Add '+' before every inserted base/qual
  inputBinding:
    position: 102
    prefix: --mark-ins
- id: min_bq
  type:
  - 'null'
  - int
  doc: Exclude reads with base quality below INT
  default: 0
  inputBinding:
    position: 102
    prefix: --min-BQ
- id: min_depth
  type:
  - 'null'
  - int
  doc: Minimum depth of INT
  default: 1
  inputBinding:
    position: 102
    prefix: --min-depth
- id: min_mq
  type:
  - 'null'
  - int
  doc: Exclude reads with mapping quality below INT
  default: 0
  inputBinding:
    position: 102
    prefix: --min-MQ
- id: mode
  type:
  - 'null'
  - string
  doc: Switch consensus mode to "simple"/"bayesian"
  default: bayesian
  inputBinding:
    position: 102
    prefix: --mode
- id: nm_halo
  type:
  - 'null'
  - int
  doc: Size of window for NM count in --adj-MQ
  default: 50
  inputBinding:
    position: 102
    prefix: --NM-halo
- id: output_all_bases
  type:
  - 'null'
  - boolean
  doc: Output all bases (start/end of reference)
  inputBinding:
    position: 102
    prefix: -a
- id: p_het
  type:
  - 'null'
  - float
  doc: Probability of heterozygous site
  default: 0.001
  inputBinding:
    position: 102
    prefix: --P-het
- id: p_indel
  type:
  - 'null'
  - float
  doc: Probability of indel sites
  default: 0.0002
  inputBinding:
    position: 102
    prefix: --P-indel
- id: qual_calibration
  type:
  - 'null'
  - File
  doc: Load quality calibration file
  inputBinding:
    position: 102
    prefix: --qual-calibration
- id: ref_qual
  type:
  - 'null'
  - int
  doc: QUAL to use for reference bases
  default: 0
  inputBinding:
    position: 102
    prefix: --ref-qual
- id: reference
  type: File
  doc: Reference sequence FASTA FILE
  inputBinding:
    position: 102
    prefix: --reference
    valueFrom: $(self.basename)
- id: region
  type:
  - 'null'
  - string
  doc: Limit query to REG. Requires an index
  inputBinding:
    position: 102
    prefix: --region
- id: scale_mq
  type:
  - 'null'
  - float
  doc: Scale mapping quality by FLOAT
  default: 1.0
  inputBinding:
    position: 102
    prefix: --scale-MQ
- id: show_del
  type:
  - 'null'
  - string
  doc: Whether to show deletion as "*"
  default: no
  inputBinding:
    position: 102
    prefix: --show-del
- id: show_ins
  type:
  - 'null'
  - string
  doc: Whether to show insertions
  default: yes
  inputBinding:
    position: 102
    prefix: --show-ins
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional decompression threads to use
  default: 0
  inputBinding:
    position: 102
    prefix: --threads
- id: use_mq
  type:
  - 'null'
  - boolean
  doc: Use mapping quality in calculation (Bayesian mode)
  inputBinding:
    position: 102
    prefix: --use-MQ
- id: use_qual
  type:
  - 'null'
  - boolean
  doc: Use quality values in calculation (simple mode)
  inputBinding:
    position: 102
    prefix: --use-qual
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity
  inputBinding:
    position: 102
    prefix: --verbosity
outputs:
- id: output
  type: stdout
stdout: consensus.out
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
