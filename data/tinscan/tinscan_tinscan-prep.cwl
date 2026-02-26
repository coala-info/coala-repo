cwlVersion: v1.2
class: CommandLineTool
baseCommand: tinscan_tinscan-prep
label: tinscan_tinscan-prep
doc: "Split multifasta genome files into directories for A and B genomes.\n\nTool
  homepage: https://github.com/Adamtaranto/TE-insertion-scanner"
inputs:
  - id: adir
    type:
      - 'null'
      - Directory
    doc: A genome sub-directory within outdir
    inputBinding:
      position: 101
      prefix: --adir
  - id: bdir
    type:
      - 'null'
      - Directory
    doc: B genome sub-directory within outdir
    inputBinding:
      position: 101
      prefix: --bdir
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Write split directories within this directory.
    default: cwd
    inputBinding:
      position: 101
      prefix: --outdir
  - id: query
    type: File
    doc: Multifasta containing B genome.
    inputBinding:
      position: 101
      prefix: --query
  - id: target
    type: File
    doc: Multifasta containing A genome.
    inputBinding:
      position: 101
      prefix: --target
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinscan:0.2.1--pyhdfd78af_0
stdout: tinscan_tinscan-prep.out
