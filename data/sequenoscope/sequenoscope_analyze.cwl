cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sequenoscope
  - analyze
label: sequenoscope_analyze
doc: "Map reads to a target and produce a report with sequencing statistics\n\nTool homepage: https://github.com/phac-nml/sequenoscope"
inputs:
  - id: input_fastq
    type:
      type: array
      items: File
    doc: Path to 1 (SE) or 2 (PE) FASTQ files to process.
    inputBinding:
      position: 101
      prefix: --input_fastq
  - id: input_reference
    type: File
    doc: Path to a single reference FASTA file.
    inputBinding:
      position: 101
      prefix: --input_reference
  - id: output
    type: string
    doc: Output directory designation.
    inputBinding:
      position: 101
      prefix: -o
  - id: sequencing_type
    type: string
    doc: "Sequencing type: 'SE' for single-end or 'PE' for paired-end."
    inputBinding:
      position: 101
      prefix: -seq_type
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite of existing results directory.
    inputBinding:
      position: 101
      prefix: --force
  - id: sequencing_summary
    type:
      - 'null'
      - File
    doc: Path to sequencing summary for manifest creation.
    inputBinding:
      position: 101
      prefix: -seq_sum
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output file prefix designation. Default is 'sample'.
    inputBinding:
      position: 101
      prefix: -op
  - id: minimum_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage threshold; default is 1.
    inputBinding:
      position: 101
      prefix: -min_cov
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: -t
  - id: minimum_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length; default is 15.
    inputBinding:
      position: 101
      prefix: -min_len
  - id: maximum_read_length
    type:
      - 'null'
      - int
    doc: Maximum read length; default is 0 (no limit).
    inputBinding:
      position: 101
      prefix: -max_len
  - id: trim_front_bp
    type:
      - 'null'
      - int
    doc: Bases to trim from the front; default is 0.
    inputBinding:
      position: 101
      prefix: -trm_fr
  - id: trim_tail_bp
    type:
      - 'null'
      - int
    doc: Bases to trim from the tail; default is 0.
    inputBinding:
      position: 101
      prefix: -trm_tail
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: Quality score threshold; default is 15.
    inputBinding:
      position: 101
      prefix: -q
outputs:
  - id: output_directory
    type: Directory
    doc: Directory with the manifest, summary manifest, log and intermediate files.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenoscope:1.0.0--pyh7e72e81_1
