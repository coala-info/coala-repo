cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribocutter
label: ribocutter
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) failing
  to pull the ribocutter image.\n\nTool homepage: https://github.com/Delayed-Gitification/ribocutter.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribocutter:0.1.1--pyh5e36f6f_0
stdout: ribocutter.out
