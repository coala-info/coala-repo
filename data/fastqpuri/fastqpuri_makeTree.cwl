cwlVersion: v1.2
class: CommandLineTool
baseCommand: makeTree
label: fastqpuri_makeTree
doc: "Reads a *fa file, constructs a tree of depth DEPTH and saves it compressed in
  OUTPUT_FILE.\n\nTool homepage: https://github.com/jengelmann/FastqPuri"
inputs:
  - id: depth
    type: int
    doc: depth of the tree structure.
    inputBinding:
      position: 101
      prefix: --depth
  - id: fasta_input
    type: File
    doc: Fasta input file.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type: File
    doc: Output file. If the extension is not *gz, it is added.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqpuri:1.0.7--r44hb1d24b7_9
