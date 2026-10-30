cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mergeSqMass.py
label: msproteomicstools_mergeSqMass.py
doc: "Merge multiple sqMass files into one.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: infiles
    type: 'File[]'
    doc: "A list of files to be merged"
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
    doc: "Merged sqMass file"
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
stdout: msproteomicstools_mergeSqMass.py.out
