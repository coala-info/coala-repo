cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlv-smile
label: mlv-smile
doc: 'A tool for MLV (Murine Leukemia Virus) integration site analysis (Note: The
  provided help text contains only system error logs and does not list specific command-line
  arguments).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mlv-smile:v1.47-6-deb_cv1
stdout: mlv-smile.out
