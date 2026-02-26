cwlVersion: v1.2
class: CommandLineTool
baseCommand: themis
label: themis
doc: "Themis: a robust and accurate species-level metagenomic profiler.\n\nTool homepage:
  https://github.com/xujialupaoli/Themis"
inputs:
  - id: command
    type: string
    doc: 'The command to run. Available commands: build-custom, profile.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/themis:0.1.0--py314h0cb7dc8_0
stdout: themis.out
