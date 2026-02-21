cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phava
  - prodigal
label: phava_prodigal
doc: "Phage Annotation Tool (prodigal subcommand)\n\nTool homepage: https://github.com/patrickwest/PhaVa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
stdout: phava_prodigal.out
