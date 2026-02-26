cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnaplotter
label: artemis_dnaplotter
doc: "DNA Image Generation Tool\n\nTool homepage: http://sanger-pathogens.github.io/Artemis/"
inputs:
  - id: template_file
    type:
      - 'null'
      - File
    doc: Read a template file
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artemis:18.2.0--hdfd78af_0
stdout: artemis_dnaplotter.out
