cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ProtFDRmProphet2Mayu.py
label: msproteomicstools_ProtFDRmProphet2Mayu.py
doc: "Convert an mProphet TSV output file to a Mayu input file.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: infile
    type: File
    doc: "mProphet output file containing all peakgroups (optionally .gz)"
    inputBinding:
      prefix: --in
  - id: output_path
    type: string
    doc: "Output file"
    inputBinding:
      prefix: --out
outputs:
  - id: output
    type: File
    doc: "Mayu input file"
    outputBinding:
      glob: "$(inputs.output_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
