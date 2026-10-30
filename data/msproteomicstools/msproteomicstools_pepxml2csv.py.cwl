cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pepxml2csv.py
label: msproteomicstools_pepxml2csv.py
doc: "Convert a pepXML file to a tab-delimited csv file written next to the input (input name with extension replaced by .csv).\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: infile
    type: File
    doc: "pepXML file"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
outputs:
  - id: output
    type: File
    doc: "Tab-delimited result table"
    outputBinding:
      glob: "$(inputs.infile.nameroot).csv"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.infile)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_pepxml2csv.py.out
