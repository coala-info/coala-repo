cwlVersion: v1.2
class: CommandLineTool
baseCommand: PretextGraph
label: pretextgraph_PretextGraph
doc: "PretextMap Version 0.0.9\n\nTool homepage: https://github.com/wtsi-hpag/PretextGraph"
inputs:
  - id: bedgraph_file
    type: File
    doc: Graph data in bedgraph format (-f; the help calls it the debug bedgraph file,
      but it is the input data; standard input also works)
    inputBinding:
      position: 101
      prefix: -f
  - id: graph_name
    type: string
    doc: graph name
    inputBinding:
      position: 101
      prefix: -n
  - id: input_pretext
    type: File
    doc: input.pretext
    inputBinding:
      position: 101
      prefix: -i
  - id: noise_filter
    type:
      - 'null'
      - int
    doc: '0: disable NOISE FILTER, 1: enable NOISE FILTER (default: 1)'
    inputBinding:
      position: 101
      prefix: -nf
  - id: output_pretext_path
    type:
      - 'null'
      - string
    doc: Output pretext file name
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_pretext
    type:
      - 'null'
      - File
    doc: output.pretext
    outputBinding:
      glob: "$(inputs.output_pretext_path ? inputs.output_pretext_path : 'no_output_file')"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_pretext)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pretextgraph:0.0.9--h9948957_1
