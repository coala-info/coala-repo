cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - bwt2fa
label: sga_bwt2fa
doc: "Transform the bwt BWTFILE back into a set of sequences\n\nTool homepage: https://github.com/jts/sga"
inputs:
  - id: bwtfile
    type: File
    doc: BWTFILE
    inputBinding:
      position: 1
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix the names of the reads with STR
    inputBinding:
      position: 102
      prefix: --prefix
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: outfile_path
    type: string
    doc: Output or path parameter `outfile_path`
    inputBinding:
      position: 103
      prefix: --outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: write the sequences to FILE
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
