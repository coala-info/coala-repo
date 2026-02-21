cwlVersion: v1.2
class: CommandLineTool
baseCommand: iphop
label: iphop
doc: "iPHoP (integrated Phage Host Prediction) - A tool for host prediction of viruses/phages.\n
  \nTool homepage: https://bitbucket.org/srouxjgi/iphop/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iphop:1.4.2--pyhdfd78af_0
stdout: iphop.out
