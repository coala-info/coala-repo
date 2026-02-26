cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfba_media
label: pyfba_media
doc: "List of media components for pyfba\n\nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs:
  - id: media_component
    type: string
    doc: A media component from the provided list
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
stdout: pyfba_media.out
