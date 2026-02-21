cwlVersion: v1.2
class: CommandLineTool
baseCommand: wisecondorx
label: wisecondorx
doc: "WGS-based Copy Number Variation (CNV) detection\n\nTool homepage: https://github.com/CenterForMedicalGeneticsGhent/wisecondorX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wisecondorx:1.2.9--pyhdfd78af_0
stdout: wisecondorx.out
