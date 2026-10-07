cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cressent
  - gene_map
label: cressent_gene_map
doc: "Generate gene arrow plots from motif data using R.\n\nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: input
    type: File
    doc: "Input file path for the motif table CSV"
    inputBinding:
      position: 101
      prefix: --input
  - id: output_dir
    type: string
    doc: "Path to the output directory (created by the tool; collected as the output)"
    inputBinding:
      position: 101
      prefix: --output
  - id: filename
    type:
      - 'null'
      - string
    doc: "Output filename for the generated plot (default: gene_motif.pdf)"
    inputBinding:
      position: 101
      prefix: --filename
  - id: height
    type:
      - 'null'
      - float
    doc: "Height of the output plot in inches (default: 10)"
    inputBinding:
      position: 101
      prefix: --height
  - id: width
    type:
      - 'null'
      - float
    doc: "Width of the output plot in inches (default: 10)"
    inputBinding:
      position: 101
      prefix: --width
  - id: title
    type:
      - 'null'
      - string
    doc: "Title for the plot (optional)"
    inputBinding:
      position: 101
      prefix: --title
outputs:
  - id: output
    type: Directory
    doc: Output directory with all result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
