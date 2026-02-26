cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfba
label: pyfba_media_compounds
doc: "List the compounds in a media formulation\n\nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs:
  - id: media
    type: string
    doc: the name of the media
    inputBinding:
      position: 101
      prefix: --media
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
stdout: pyfba_media_compounds.out
