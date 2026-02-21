cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion
label: relion
doc: "The provided text does not contain help information for the 'relion' command-line
  tool. It appears to be a log from a failed container build or fetch process (Singularity/Apptainer).\n
  \nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion.out
