cwlVersion: v1.2
class: CommandLineTool
baseCommand: besst
label: besst
doc: "BESST (Bresler's Scaffolding Tool) - Scaffolding of genomic assemblies.\n\n
  Tool homepage: https://github.com/ksahlin/BESST"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/besst:2.2.8--py27_0
stdout: besst.out
