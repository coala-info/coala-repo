cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy_sequence_utils
label: galaxy_sequence_utils
doc: "The provided text does not contain help information; it contains system error
  messages regarding container execution (Singularity/Apptainer) and a 'no space left
  on device' failure.\n\nTool homepage: https://github.com/galaxyproject/sequence_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-workflow-executor:0.2.6--pyh5e36f6f_0
stdout: galaxy_sequence_utils.out
