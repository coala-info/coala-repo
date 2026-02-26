cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mzspeclib
  - validate
label: mzspeclib_validate
doc: "Semantically and structurally validate a spectral library.\n\nTool homepage:
  https://github.com/HUPO-PSI/mzSpecLib"
inputs:
  - id: inpath
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
  - id: profile
    type:
      - 'null'
      - string
    doc: Profile type for validation (consensus, single, silver, peptide, gold)
    inputBinding:
      position: 102
      prefix: --profile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mzspeclib:1.0.7--pyhdfd78af_0
stdout: mzspeclib_validate.out
