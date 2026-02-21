cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngmerge
label: ngmerge
doc: "The provided text does not contain help information for the tool; it is a system
  error message from a container runtime (Apptainer/Singularity) indicating a failure
  to build the SIF image due to insufficient disk space ('no space left on device').\n
  \nTool homepage: https://github.com/harvardinformatics/NGmerge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngmerge:0.5--h89d970f_0
stdout: ngmerge.out
