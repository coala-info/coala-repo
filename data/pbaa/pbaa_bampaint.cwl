cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pbaa
  - bampaint
label: pbaa_bampaint
doc: "Add color tags to BAM records, based on pbaa clusters.\n\nTool homepage: https://github.com/PacificBiosciences/pbAA"
inputs:
  - id: read_info_file
    type: File
    doc: Read information file produced by pbaa cluster.
    inputBinding:
      position: 1
  - id: input_bam
    type: File
    doc: Bam file to add color tags.
    inputBinding:
      position: 2
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log to a file, instead of stderr.
    inputBinding:
      position: 103
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL).'
    inputBinding:
      position: 103
      prefix: --log-level
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    inputBinding:
      position: 103
      prefix: --num-threads
outputs:
  - id: output_bam
    type: File
    doc: Output bam file name.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbaa:1.2.0--h9ee0642_0
