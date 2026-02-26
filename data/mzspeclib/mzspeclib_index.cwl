cwlVersion: v1.2
class: CommandLineTool
baseCommand: mzspeclib index
label: mzspeclib_index
doc: "Build an external on-disk SQL-based index for the spectral library\n\nTool homepage:
  https://github.com/HUPO-PSI/mzSpecLib"
inputs:
  - id: inpath
    type: string
    doc: Path to the input spectral library file
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
stdout: mzspeclib_index.out
