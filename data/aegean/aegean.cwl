cwlVersion: v1.2
class: CommandLineTool
baseCommand: aegean
label: aegean
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the 'aegean'
  tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/BrendelGroup/AEGeAn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aegean:0.16.0--h71bfec9_5
stdout: aegean.out
