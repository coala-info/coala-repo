cwlVersion: v1.2
class: CommandLineTool
baseCommand: plateo
label: plateo
doc: "The provided text does not contain help information for the tool 'plateo'. It
  is a system error log from a container runtime (Singularity/Apptainer) indicating
  a failure to build the container image due to insufficient disk space ('no space
  left on device').\n\nTool homepage: https://github.com/Edinburgh-Genome-Foundry/Plateo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plateo:0.3.1--pyh7e72e81_0
stdout: plateo.out
