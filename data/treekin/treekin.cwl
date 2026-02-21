cwlVersion: v1.2
class: CommandLineTool
baseCommand: treekin
label: treekin
doc: "The provided text is an error log from a container execution environment (Singularity/Apptainer)
  and does not contain the help documentation for the treekin tool. As a result, no
  arguments could be extracted.\n\nTool homepage: https://www.tbi.univie.ac.at/RNA/Barriers/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treekin:0.5.1--hf3d7b6d_4
stdout: treekin.out
