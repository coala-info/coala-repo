cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - NISTParser.py
label: msproteomicstools_NISTParser.py
doc: "Parse a NIST spectral library (msp text) into a transition TSV (top 6 fragment ions above m/z 400 per spectrum).\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: input_library
    type: File
    doc: "NIST library in msp text format"
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: "Output TSV file"
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: "Transition TSV"
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
stdout: msproteomicstools_NISTParser.py.out
