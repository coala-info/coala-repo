cwlVersion: v1.2
class: CommandLineTool
baseCommand: voluptuous
label: voluptuous
doc: "The provided text does not contain help information for the tool 'voluptuous'.
  It appears to be a log of a failed container build process (Apptainer/Singularity).\n
  \nTool homepage: https://github.com/alecthomas/voluptuous"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voluptuous:0.8.8--py36_0
stdout: voluptuous.out
