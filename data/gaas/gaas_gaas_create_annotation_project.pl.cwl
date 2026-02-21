cwlVersion: v1.2
class: CommandLineTool
baseCommand: gaas_gaas_create_annotation_project.pl
label: gaas_gaas_create_annotation_project.pl
doc: "A tool to create an annotation project (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/NBISweden/GAAS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gaas:1.2.0--pl5321r42hdfd78af_1
stdout: gaas_gaas_create_annotation_project.pl.out
