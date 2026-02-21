cwlVersion: v1.2
class: CommandLineTool
baseCommand: guidescan
label: guidescan
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the guidescan
  tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/pritykinlab/guidescan-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/guidescan:2.2.1--h4ac6f70_2
stdout: guidescan.out
