cwlVersion: v1.2
class: CommandLineTool
baseCommand: funannotate_setupDB.py
label: funannotate_setupDB.py
doc: "The provided text does not contain help information or a description of the
  tool; it contains execution logs and a fatal error regarding disk space during a
  container build.\n\nTool homepage: https://github.com/nextgenusfs/funannotate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/funannotate:1.8.17--pyhdfd78af_5
stdout: funannotate_setupDB.py.out
