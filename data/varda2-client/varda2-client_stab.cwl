cwlVersion: v1.2
class: CommandLineTool
baseCommand: varda2-client stab
label: varda2-client_stab
doc: "Get stabilized sequence for a given region\n\nTool homepage: https://github.com/varda/varda2-client"
inputs:
  - id: end
    type: int
    doc: End of region
    inputBinding:
      position: 101
      prefix: --end
  - id: reference
    type: string
    doc: Chromosome to look at
    inputBinding:
      position: 101
      prefix: --reference
  - id: start
    type: int
    doc: Start of region
    inputBinding:
      position: 101
      prefix: --start
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varda2-client:0.9--py_0
stdout: varda2-client_stab.out
