cwlVersion: v1.2
class: CommandLineTool
baseCommand: dupsifter
label: dupsifter
doc: "dupsifter marks PCR duplicates in WGBS (and WGS) alignments from name-sorted
  BAM input.\n\nTool homepage: https://github.com/huishenlab/dupsifter"
inputs:
  - id: ref_fa
    type: File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: Reference FASTA file
    inputBinding:
      position: 1
  - id: in_bam
    type:
      - 'null'
      - File
    doc: Input BAM file (must be name sorted). If not provided, assume the input
      is stdin.
    inputBinding:
      position: 2
  - id: add_mate_tags
    type:
      - 'null'
      - boolean
    doc: add MC and MQ mate tags to mate reads
    inputBinding:
      position: 103
      prefix: --add-mate-tags
  - id: has_barcode
    type:
      - 'null'
      - boolean
    doc: reads in file have barcodes
    inputBinding:
      position: 103
      prefix: --has-barcode
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: maximum read length for paired end duplicate-marking
    inputBinding:
      position: 103
      prefix: --max-read-length
  - id: min_base_qual
    type:
      - 'null'
      - int
    doc: minimum base quality
    inputBinding:
      position: 103
      prefix: --min-base-qual
  - id: remove_dups
    type:
      - 'null'
      - boolean
    doc: toggle to remove marked duplicate
    inputBinding:
      position: 103
      prefix: --remove-dups
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: run for single-end data
    inputBinding:
      position: 103
      prefix: --single-end
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print extra messages
    inputBinding:
      position: 103
      prefix: --verbose
  - id: wgs_only
    type:
      - 'null'
      - boolean
    doc: process WGS reads instead of WGBS
    inputBinding:
      position: 103
      prefix: --wgs-only
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: name of output file [stdout]
    inputBinding:
      position: 104
      prefix: --output
  - id: stats_output_path
    type:
      - 'null'
      - string
    doc: name of file to write statistics to (see Note 3 for details)
    inputBinding:
      position: 105
      prefix: --stats-output
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: name of output file
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: stats_output
    type:
      - 'null'
      - File
    doc: name of file to write statistics to
    outputBinding:
      glob: "$(inputs.stats_output_path ? inputs.stats_output_path : '*dupsifter.stat')"
  - id: stdout
    type: stdout
    doc: Marked alignments in SAM format when no output file is given
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dupsifter:1.3.0.20241113--h566b1c6_1
stdout: dupsifter.out.sam
