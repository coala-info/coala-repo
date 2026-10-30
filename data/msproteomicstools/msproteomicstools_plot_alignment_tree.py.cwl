cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - plot_alignment_tree.py
label: msproteomicstools_plot_alignment_tree.py
doc: "Draw the alignment tree from a .yaml output file of a feature_alignment run in a graph format (pdf, svg, ...) using graphviz.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: input_yaml
    type: File
    doc: "YAML file written by feature_alignment.py"
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: "Output file (format is taken from the extension)"
    inputBinding:
      position: 2
  - id: tree_format
    type: {type: enum, symbols: [Mapped, MappedFile, MappedFileInput, Raw]}
    doc: "Tree format"
    inputBinding:
      position: 3
  - id: draw_format
    type: {type: enum, symbols: [dot, neato, twopi, circo, fdp, sfdp]}
    doc: "Graphviz layout program"
    inputBinding:
      position: 4
outputs:
  - id: output
    type: File
    doc: "Tree drawing"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_plot_alignment_tree.py.out
