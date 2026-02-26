cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varda2-client
  - snv
label: varda2-client_snv
doc: "SNV subcommand for varda2-client\n\nTool homepage: https://github.com/varda/varda2-client"
inputs:
  - id: inserted
    type: string
    doc: Inserted base
    inputBinding:
      position: 101
      prefix: --inserted
  - id: position
    type: string
    doc: Locus position
    inputBinding:
      position: 101
      prefix: --position
  - id: reference
    type: string
    doc: Chromosome to look at
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varda2-client:0.9--py_0
stdout: varda2-client_snv.out
