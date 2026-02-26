cwlVersion: v1.2
class: CommandLineTool
baseCommand: hymet truth
label: hymet_truth
doc: "Build Zymo mock community truth tables\n\nTool homepage: https://github.com/inesbmartins02/HYMET"
inputs:
  - id: build_zymo
    type: string
    doc: Build Zymo mock community truth tables
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hymet:1.3.0--hdfd78af_0
stdout: hymet_truth.out
