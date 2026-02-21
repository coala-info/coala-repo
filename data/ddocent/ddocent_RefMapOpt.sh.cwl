cwlVersion: v1.2
class: CommandLineTool
baseCommand: ddocent_RefMapOpt.sh
label: ddocent_RefMapOpt.sh
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container environment (Singularity/Apptainer)
  failing to pull an image due to lack of disk space.\n\nTool homepage: https://ddocent.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddocent:2.9.8--hdfd78af_0
stdout: ddocent_RefMapOpt.sh.out
