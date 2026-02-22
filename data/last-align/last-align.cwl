cwlVersion: v1.2
class: CommandLineTool
baseCommand: last-align
label: last-align
doc: "The provided text is a system error log (Singularity/Apptainer build failure)
  and does not contain CLI help information or argument definitions.\n\nTool homepage:
  https://gitlab.com/mcfrith/last"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/last-align:v963-2-deb_cv1
stdout: last-align.out
