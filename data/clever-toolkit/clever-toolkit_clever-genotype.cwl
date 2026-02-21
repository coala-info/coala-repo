cwlVersion: v1.2
class: CommandLineTool
baseCommand: clever-genotype
label: clever-toolkit_clever-genotype
doc: "The provided text does not contain help information for the tool. It contains
  container runtime error logs indicating a failure to extract the image due to lack
  of disk space.\n\nTool homepage: https://bitbucket.org/tobiasmarschall/clever-toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clever-toolkit:2.4--h077b44d_14
stdout: clever-toolkit_clever-genotype.out
