cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pepxml2csv_simple.py
label: msproteomicstools_pepxml2csv_simple.py
doc: "Convert a pepXML file to a simple csv table of spectrum, peptide, scores and protein.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: infile
    type: File
    doc: "pepXML file"
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: "Output csv file"
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: "Result table"
    outputBinding:
      glob: "$(inputs.output_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
