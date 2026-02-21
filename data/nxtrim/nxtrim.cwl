cwlVersion: v1.2
class: CommandLineTool
baseCommand: nxtrim
label: nxtrim
doc: "The provided text does not contain help information for nxtrim; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the container image due to lack of disk space. No arguments or tool descriptions
  could be extracted from this specific input.\n\nTool homepage: https://github.com/sequencing/NxTrim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nxtrim:0.4.3--he513fc3_0
stdout: nxtrim.out
