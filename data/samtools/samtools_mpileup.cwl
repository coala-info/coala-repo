cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- mpileup
label: samtools_mpileup
doc: 'Multi-way pileup of alignments


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: in_bam
  type:
  - 'null'
  - type: array
    items: File
  doc: Input sorted alignment files (indexes needed for --region).
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
- id: illumina1_3
  type:
  - 'null'
  - boolean
  doc: Quality is in the Illumina-1.3+ encoding.
  inputBinding:
    position: 103
    prefix: --illumina1.3+
- id: count_orphans
  type:
  - 'null'
  - boolean
  doc: Do not discard anomalous read pairs.
  inputBinding:
    position: 103
    prefix: --count-orphans
- id: bam_list
  type:
  - 'null'
  - File
  doc: List of input BAM filenames, one per line.
  inputBinding:
    position: 103
    prefix: --bam-list
- id: no_baq
  type:
  - 'null'
  - boolean
  doc: Disable BAQ (per-Base Alignment Quality).
  inputBinding:
    position: 103
    prefix: --no-BAQ
- id: adjust_mq
  type:
  - 'null'
  - int
  doc: Adjust mapping quality; recommended 50, disable 0 [0].
  inputBinding:
    position: 103
    prefix: --adjust-MQ
- id: max_depth
  type:
  - 'null'
  - int
  doc: Max per-file depth; avoids excessive memory usage [8000].
  inputBinding:
    position: 103
    prefix: --max-depth
- id: redo_baq
  type:
  - 'null'
  - boolean
  doc: Recalculate BAQ on the fly, ignore existing BQs.
  inputBinding:
    position: 103
    prefix: --redo-BAQ
- id: fasta_ref
  type:
  - 'null'
  - File
  doc: Faidx indexed reference sequence file.
  secondaryFiles:
  - pattern: .fai
    required: false
  inputBinding:
    position: 103
    prefix: --fasta-ref
- id: exclude_rg
  type:
  - 'null'
  - File
  doc: Exclude read groups listed in this file.
  inputBinding:
    position: 103
    prefix: --exclude-RG
- id: positions
  type:
  - 'null'
  - File
  doc: Skip unlisted positions (chr pos) or regions (BED).
  inputBinding:
    position: 103
    prefix: --positions
- id: min_mq
  type:
  - 'null'
  - int
  doc: Skip alignments with mapQ smaller than INT [0].
  inputBinding:
    position: 103
    prefix: --min-MQ
- id: min_bq
  type:
  - 'null'
  - int
  doc: Skip bases with baseQ/BAQ smaller than INT [13].
  inputBinding:
    position: 103
    prefix: --min-BQ
- id: region
  type:
  - 'null'
  - string
  doc: Region in which pileup is generated.
  inputBinding:
    position: 103
    prefix: --region
- id: ignore_rg
  type:
  - 'null'
  - boolean
  doc: Ignore RG tags (one BAM = one sample).
  inputBinding:
    position: 103
    prefix: --ignore-RG
- id: incl_flags
  type:
  - 'null'
  - string
  doc: 'Required flags: only include reads with any of the mask bits set.'
  inputBinding:
    position: 103
    prefix: --incl-flags
- id: excl_flags
  type:
  - 'null'
  - string
  doc: 'Filter flags: skip reads with any of the mask bits set [UNMAP,SECONDARY,QCFAIL,DUP].'
  inputBinding:
    position: 103
    prefix: --excl-flags
- id: disable_overlap_removal
  type:
  - 'null'
  - boolean
  doc: Disable read-pair overlap detection and removal.
  inputBinding:
    position: 103
    prefix: --ignore-overlaps-removal
- id: customized_index
  type:
  - 'null'
  - boolean
  doc: Use customized index files.
  inputBinding:
    position: 103
    prefix: --customized-index
- id: output_filename
  type: string
  doc: Write output to this file (-o).
  default: pileup.txt
  inputBinding:
    position: 103
    prefix: -o
- id: output_bp
  type:
  - 'null'
  - boolean
  doc: Output base positions on reads, current orientation.
  inputBinding:
    position: 103
    prefix: --output-BP
- id: output_bp_5
  type:
  - 'null'
  - boolean
  doc: Output base positions on reads, 5' to 3' orientation.
  inputBinding:
    position: 103
    prefix: --output-BP-5
- id: output_mods
  type:
  - 'null'
  - boolean
  doc: Output base modifications.
  inputBinding:
    position: 103
    prefix: --output-mods
- id: output_mq
  type:
  - 'null'
  - boolean
  doc: Output mapping quality.
  inputBinding:
    position: 103
    prefix: --output-MQ
- id: output_qname
  type:
  - 'null'
  - boolean
  doc: Output read names.
  inputBinding:
    position: 103
    prefix: --output-QNAME
- id: output_extra
  type:
  - 'null'
  - string
  doc: Output extra read fields and read tag values.
  inputBinding:
    position: 103
    prefix: --output-extra
- id: output_sep
  type:
  - 'null'
  - string
  doc: Set the separator character for tag lists [,].
  inputBinding:
    position: 103
    prefix: --output-sep
- id: output_empty
  type:
  - 'null'
  - string
  doc: Set the no value character for tag lists [*].
  inputBinding:
    position: 103
    prefix: --output-empty
- id: no_output_ins
  type:
  - 'null'
  - boolean
  doc: Skip insertion sequence after +NUM.
  inputBinding:
    position: 103
    prefix: --no-output-ins
- id: no_output_ins_mods
  type:
  - 'null'
  - boolean
  doc: Do not display base modifications within insertions.
  inputBinding:
    position: 103
    prefix: --no-output-ins-mods
- id: no_output_del
  type:
  - 'null'
  - boolean
  doc: Skip deletion sequence after -NUM.
  inputBinding:
    position: 103
    prefix: --no-output-del
- id: no_output_ends
  type:
  - 'null'
  - boolean
  doc: Remove ^MQUAL and $ markup in sequence column.
  inputBinding:
    position: 103
    prefix: --no-output-ends
- id: reverse_del
  type:
  - 'null'
  - boolean
  doc: Use '#' character for deletions on the reverse strand.
  inputBinding:
    position: 103
    prefix: --reverse-del
- id: output_all_positions
  type:
  - 'null'
  - boolean
  doc: Output all positions (including zero depth).
  inputBinding:
    position: 103
    prefix: -a
- id: output_absolutely_all_positions
  type:
  - 'null'
  - boolean
  doc: Output absolutely all positions, including unused reference sequences (-aa).
  inputBinding:
    position: 103
    prefix: -aa
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
  doc: Text pileup.
  outputBinding:
    glob: $(inputs.output_filename)
