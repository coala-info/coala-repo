cwlVersion: v1.2
class: CommandLineTool
baseCommand: bgreat_numbersToSequences
label: bgreat_numbersToSequences
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating a failure to build a Singularity/Apptainer container due to insufficient
  disk space.\n\nTool homepage: https://github.com/Malfoy/BGREAT2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bgreat:2.0.0--hd28b015_0
stdout: bgreat_numbersToSequences.out
