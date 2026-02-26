cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract
label: qax_extract
doc: "Extract the artifact data. If multiple files are present, a new directory will
  be created (artifact name), otherwise the artifact name will be used to rename the
  single file (unless -k is specified).\n\nTool homepage: https://github.com/telatin/qax"
inputs:
  - id: inputfiles
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files
    inputBinding:
      position: 1
  - id: keepname
    type:
      - 'null'
      - boolean
    doc: Keep original file names instead of using artifact's basename
    default: false
    inputBinding:
      position: 102
      prefix: --keepname
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: .
    inputBinding:
      position: 102
      prefix: --outdir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qax:0.9.8--h515fd9b_0
stdout: qax_extract.out
