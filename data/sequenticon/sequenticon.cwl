cwlVersion: v1.2
class: CommandLineTool
baseCommand: sequenticon
label: sequenticon
doc: "The provided text does not contain help information or usage instructions for
  the tool 'sequenticon'. It consists of error logs related to a failed Apptainer/Singularity
  container build due to insufficient disk space ('no space left on device').\n\n
  Tool homepage: https://github.com/Edinburgh-Genome-Foundry/sequenticon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenticon:0.1.8--pyh7e72e81_0
stdout: sequenticon.out
