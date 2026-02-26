cwlVersion: v1.2
class: CommandLineTool
baseCommand: locidex manifest
label: locidex_manifest
doc: "Create a multi-database folder manifest\n\nTool homepage: https://pypi.org/project/locidex/"
inputs:
  - id: input_directory
    type: Directory
    doc: Input directory containing multiple locidex databases
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locidex:0.4.0--pyhdfd78af_0
stdout: locidex_manifest.out
