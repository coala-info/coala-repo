cwlVersion: v1.2
class: CommandLineTool
baseCommand: mysterymaster
label: mysterymaster
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the SIF image due to lack of disk space.\n\nTool homepage: https://bitbucket.org/NPC239/mysterymaster/src/main/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mysterymaster:0.0.8--hdfd78af_0
stdout: mysterymaster.out
