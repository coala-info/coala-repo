cwlVersion: v1.2
class: CommandLineTool
baseCommand: aghermann_edfhed
label: aghermann_edfhed
doc: "EDF header editor (Note: The provided help text contained only system error
  logs regarding a container build failure; no argument details were available in
  the input).\n\nTool homepage: https://github.com/BackupTheBerlios/aghermann"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/aghermann:v1.1.2-2-deb_cv1
stdout: aghermann_edfhed.out
