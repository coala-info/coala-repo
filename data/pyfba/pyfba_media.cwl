cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfba
  - media
label: pyfba_media
doc: "List the names of all the predefined media\n\nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
stdout: pyfba_media.out
