cwlVersion: v1.2
class: CommandLineTool
baseCommand: clustergrammer
label: clustergrammer
doc: "The provided text is a build error log from a Singularity/Apptainer environment
  and does not contain CLI help information or usage instructions. As a result, no
  arguments could be extracted.\n\nTool homepage: https://github.com/MaayanLab/clustergrammer-py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clustergrammer:1.13.6--pyh24bf2e0_0
stdout: clustergrammer.out
