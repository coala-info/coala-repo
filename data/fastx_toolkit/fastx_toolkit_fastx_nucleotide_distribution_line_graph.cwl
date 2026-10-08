cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_nucleotide_distribution_line_graph.sh
label: fastx_toolkit_fastx_nucleotide_distribution_line_graph
doc: "Generate a nucleotide distribution line graph (PNG or PostScript) from the output of fastx_quality_stats.\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input file. Should be the output of \"fastx_quality_stats\" program."
    inputBinding:
      position: 101
      prefix: -i
  - id: output_file_path
    type: string
    doc: "Output or path parameter `output_file_path`"
    inputBinding:
      position: 102
      prefix: -o
  - id: postscript
    type:
      - 'null'
      - boolean
    doc: "Generate PostScript (.PS) file. Default is PNG image."
    inputBinding:
      position: 101
      prefix: -p
  - id: title
    type:
      - 'null'
      - string
    doc: "Title - will be plotted on the graph."
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Nucleotide distribution graph. Default is STDOUT."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
