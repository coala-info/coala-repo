cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - trafoXML_visualize.py
label: msproteomicstools_trafoXML_visualize.py
doc: "Plot the residues and the retention time correlation of a trafoXML file (linear fit) to PDF files.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: input_trafoxml
    type: File
    doc: "trafoXML file"
    inputBinding:
      position: 1
  - id: result_dir
    type: ['null', string]
    doc: "Prefix for the result files (use a directory name ending in /)"
    inputBinding:
      position: 2
outputs:
  - id: plots
    type: 'File[]'
    doc: "PDF plots"
    outputBinding:
      glob: "*.pdf"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_trafoXML_visualize.py.out
