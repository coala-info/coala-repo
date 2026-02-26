cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqmagick_info
label: seqmagick_info
doc: "Info action\n\nTool homepage: http://github.com/fhcrc/seqmagick"
inputs:
  - id: sequence_files
    type:
      type: array
      items: File
    doc: Input sequence files
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: Specify output format as tab-delimited, CSV or aligned in a borderless 
      table. Default is tab-delimited if the output is directed to a file, 
      aligned if output to the console.
    inputBinding:
      position: 102
      prefix: --format
  - id: input_format
    type:
      - 'null'
      - string
    doc: Input format. Overrides extension for all input files
    inputBinding:
      position: 102
      prefix: --input-format
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (CPUs).
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: 'Output destination. Default: STDOUT'
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqmagick:0.8.6--pyhdfd78af_0
