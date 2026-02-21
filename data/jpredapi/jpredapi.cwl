cwlVersion: v1.2
class: CommandLineTool
baseCommand: jpredapi
label: jpredapi
doc: "JPred API client for secondary structure prediction\n\nTool homepage: https://github.com/MoseleyBioinformaticsLab/jpredapi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jpredapi:1.5.6--py_0
stdout: jpredapi.out
