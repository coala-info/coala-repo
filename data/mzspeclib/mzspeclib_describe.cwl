cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mzspeclib
  - describe
label: mzspeclib_describe
doc: "Produce a minimal textual description of a spectral library.\n\nTool homepage:
  https://github.com/HUPO-PSI/mzSpecLib"
inputs:
  - id: path
    type: File
    doc: Path to the spectral library file
    inputBinding:
      position: 1
  - id: input_format
    type:
      - 'null'
      - string
    doc: The file format of the input file. If omitted, will attempt to infer 
      automatically.
    inputBinding:
      position: 102
      prefix: --input-format
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mzspeclib:1.0.7--pyhdfd78af_0
stdout: mzspeclib_describe.out
