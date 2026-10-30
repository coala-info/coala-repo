cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MSE2mzML.py
label: msproteomicstools_MSE2mzML.py
doc: "Convert a MSE text export to mzML.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: input_file
    type: File
    doc: "MSE text file"
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: "Output mzML file"
    inputBinding:
      position: 2
outputs:
  - id: mzml
    type: File
    doc: "mzML file"
    outputBinding:
      glob: "$(inputs.output_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
