cwlVersion: v1.2
class: CommandLineTool
baseCommand: funannotate
label: funannotate_funannotate-docker
doc: "Funannotate is a pipeline for genome annotation. (Note: The provided text appears
  to be a system error log rather than help documentation, so no arguments could be
  extracted).\n\nTool homepage: https://github.com/nextgenusfs/funannotate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/funannotate:1.8.17--pyhdfd78af_5
stdout: funannotate_funannotate-docker.out
