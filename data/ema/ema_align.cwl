cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ema
  - align
label: ema_align
doc: "choose best alignments based on barcodes\n\nTool homepage: http://ema.csail.mit.edu/"
inputs:
  - id: preprocessed_inputs
    type:
      - 'null'
      - type: array
        items: File
    doc: list of all preprocessed inputs (only for -x)
    inputBinding:
      position: 1
  - id: ema_fastq_path
    type:
      - 'null'
      - File
    doc: specify special FASTQ path
    inputBinding:
      position: 102
      prefix: -s
  - id: fastq1_path
    type:
      - 'null'
      - File
    doc: first (preprocessed and sorted) FASTQ file
    inputBinding:
      position: 102
      prefix: '-1'
  - id: fastq2_path
    type:
      - 'null'
      - File
    doc: second (preprocessed and sorted) FASTQ file
    inputBinding:
      position: 102
      prefix: '-2'
  - id: fragment_read_density_optimization
    type:
      - 'null'
      - boolean
    doc: apply fragment read density optimization
    inputBinding:
      position: 102
      prefix: -d
  - id: index
    type:
      - 'null'
      - int
    doc: index to follow 'BX' tag in SAM output
    inputBinding:
      position: 102
      prefix: -i
  - id: multi_input_mode
    type:
      - 'null'
      - boolean
    doc: multi-input mode; takes input files after flags and spawns a thread for
      each
    inputBinding:
      position: 102
      prefix: -x
  - id: read_group_string
    type:
      - 'null'
      - string
    doc: full read group string (e.g. '@RG\tID:foo\tSM:bar')
    inputBinding:
      position: 102
      prefix: -R
  - id: reference_path
    type: File
    doc: indexed reference
    inputBinding:
      position: 102
      prefix: -r
  - id: sequencing_platform
    type:
      - 'null'
      - string
    doc: sequencing platform (one of 'haplotag', '10x', 'tru', 'cpt')
    inputBinding:
      position: 102
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: set number of threads
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: output_sam_file
    type:
      - 'null'
      - File
    doc: output SAM file
    outputBinding:
      glob: $(inputs.output_sam_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ema:0.7.0--h5ca1c30_2
