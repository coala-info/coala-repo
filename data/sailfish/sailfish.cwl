cwlVersion: v1.2
class: CommandLineTool
baseCommand: sailfish
label: sailfish
doc: "Sailfish is a tool for quantifying transcript abundance in RNA-Seq data.\n\n\
  Tool homepage: https://github.com/rust-sailfish/sailfish"
inputs:
  - id: no_version_check
    type:
      - 'null'
      - boolean
    doc: don't check with the server to see if this is the latest version
    inputBinding:
      position: 101
      prefix: --no-version-check
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sailfish:0.10.1--1
stdout: sailfish.out
