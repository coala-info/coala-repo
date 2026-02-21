cwlVersion: v1.2
class: CommandLineTool
baseCommand: xpore
label: xpore
doc: "The provided text does not contain help information or documentation for the
  tool. It appears to be a system log or error message from a container runtime (Singularity/Apptainer)
  failing to fetch the xpore image.\n\nTool homepage: https://github.com/GoekeLab/xpore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xpore:2.1--pyh5e36f6f_0
stdout: xpore.out
