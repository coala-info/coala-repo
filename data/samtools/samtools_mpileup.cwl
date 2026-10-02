cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - mpileup
label: samtools_mpileup
doc: Generate text pileup from BAM, SAM, or CRAM files
inputs:
  - id: in_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: Input BAM file(s)
    inputBinding:
      position: 1
  - id: illumina1_3
    type:
      - 'null'
      - boolean
    doc: quality is in the Illumina-1.3+ encoding
    inputBinding:
      position: 102
      prefix: --illumina1.3+
  - id: count_orphans
    type:
      - 'null'
      - boolean
    doc: do not discard anomalous read pairs
    inputBinding:
      position: 102
      prefix: --count-orphans
  - id: bam_list
    type:
      - 'null'
      - File
    doc: list of input BAM filenames, one per line
    inputBinding:
      position: 102
      prefix: --bam-list
  - id: no_baq
    type:
      - 'null'
      - boolean
    doc: disable BAQ (per-Base Alignment Quality)
    inputBinding:
      position: 102
      prefix: --no-BAQ
  - id: adjust_mq
    type:
      - 'null'
      - int
    doc: adjust mapping quality; recommended:50, disable:0
    inputBinding:
      position: 102
      prefix: --adjust-MQ
  - id: max_depth
    type:
      - 'null'
      - int
    doc: max per-file depth; avoids excessive memory usage
    inputBinding:
      position: 102
      prefix: --max-depth
  - id: redo_baq
    type:
      - 'null'
      - boolean
    doc: recalculate BAQ on the fly, ignore existing BQs
    inputBinding:
      position: 102
      prefix: --redo-BAQ
  - id: fasta_ref
    type:
      - 'null'
      - File
    doc: faidx indexed reference sequence file
    inputBinding:
      position: 102
      prefix: --fasta-ref
  - id: exclude_rg
    type:
      - 'null'
      - File
    doc: exclude read groups listed in FILE
    inputBinding:
      position: 102
      prefix: --exclude-RG
  - id: positions
    type:
      - 'null'
      - File
    doc: skip unlisted positions (chr pos) or regions (BED)
    inputBinding:
      position: 102
      prefix: --positions
  - id: min_mq
    type:
      - 'null'
      - int
    doc: skip alignments with mapQ smaller than INT
    inputBinding:
      position: 102
      prefix: --min-MQ
  - id: min_bq
    type:
      - 'null'
      - int
    doc: skip bases with baseQ/BAQ smaller than INT
    inputBinding:
      position: 102
      prefix: --min-BQ
  - id: region
    type:
      - 'null'
      - string
    doc: region in which pileup is generated
    inputBinding:
      position: 102
      prefix: --region
  - id: ignore_rg
    type:
      - 'null'
      - boolean
    doc: ignore RG tags (one BAM = one sample)
    inputBinding:
      position: 102
      prefix: --ignore-RG
  - id: incl_flags
    type:
      - 'null'
      - string
    doc: 'required flags: only include reads with any of the mask bits set'
    inputBinding:
      position: 102
      prefix: --incl-flags
  - id: excl_flags
    type:
      - 'null'
      - string
    doc: 'filter flags: skip reads with any of the mask bits set'
    inputBinding:
      position: 102
      prefix: --excl-flags
  - id: disable_overlap_removal
    type:
      - 'null'
      - boolean
    doc: disable read-pair overlap detection and removal
    inputBinding:
      position: 102
      prefix: --ignore-overlaps-removal
  - id: customized_index
    type:
      - 'null'
      - boolean
    doc: use customized index files
    inputBinding:
      position: 102
      prefix: --customized-index
  - id: output
    type:
      - 'null'
      - string
    doc: write output to FILE
    inputBinding:
      position: 102
      prefix: --output
  - id: output_bp
    type:
      - 'null'
      - boolean
    doc: output base positions on reads, current orientation
    inputBinding:
      position: 102
      prefix: --output-BP
  - id: output_bp_5
    type:
      - 'null'
      - boolean
    doc: output base positions on reads, 5' to 3' orientation
    inputBinding:
      position: 102
      prefix: --output-BP-5
  - id: output_mods
    type:
      - 'null'
      - boolean
    doc: output base modifications
    inputBinding:
      position: 102
      prefix: --output-mods
  - id: output_mq
    type:
      - 'null'
      - boolean
    doc: output mapping quality
    inputBinding:
      position: 102
      prefix: --output-MQ
  - id: output_qname
    type:
      - 'null'
      - boolean
    doc: output read names
    inputBinding:
      position: 102
      prefix: --output-QNAME
  - id: output_extra
    type:
      - 'null'
      - string
    doc: output extra read fields and read tag values
    inputBinding:
      position: 102
      prefix: --output-extra
  - id: output_sep
    type:
      - 'null'
      - string
    doc: set the separator character for tag lists
    inputBinding:
      position: 102
      prefix: --output-sep
  - id: output_empty
    type:
      - 'null'
      - string
    doc: set the no value character for tag lists
    inputBinding:
      position: 102
      prefix: --output-empty
  - id: no_output_ins
    type:
      - 'null'
      - boolean
    doc: skip insertion sequence after +NUM. Use twice for complete insertion 
      removal
    inputBinding:
      position: 102
      prefix: --no-output-ins
  - id: no_output_ins_mods
    type:
      - 'null'
      - boolean
    doc: don't display base modifications within insertions
    inputBinding:
      position: 102
      prefix: --no-output-ins-mods
  - id: no_output_del
    type:
      - 'null'
      - boolean
    doc: skip deletion sequence after -NUM. Use twice for complete deletion 
      removal
    inputBinding:
      position: 102
      prefix: --no-output-del
  - id: no_output_ends
    type:
      - 'null'
      - boolean
    doc: remove ^MQUAL and $ markup in sequence column
    inputBinding:
      position: 102
      prefix: --no-output-ends
  - id: reverse_del
    type:
      - 'null'
      - boolean
    doc: use '#' character for deletions on the reverse strand
    inputBinding:
      position: 102
      prefix: --reverse-del
  - id: output_all_positions
    type:
      - 'null'
      - boolean
    doc: output all positions (including zero depth)
    inputBinding:
      position: 102
      prefix: -a
  - id: output_absolutely_all_positions
    type:
      - 'null'
      - boolean
    doc: output absolutely all positions, including unused ref. sequences
    inputBinding:
      position: 102
      prefix: -aa
  - id: input_fmt_option
    type:
      - 'null'
      - string
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
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: write output to FILE
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
