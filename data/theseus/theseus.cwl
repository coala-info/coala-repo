cwlVersion: v1.2
class: CommandLineTool
baseCommand: theseus
label: theseus
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain help information or argument definitions for the tool 'theseus'.\n
  \nTool homepage: https://github.com/theseus-os/Theseus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/theseus:v3.3.0-8-deb_cv1
stdout: theseus.out
