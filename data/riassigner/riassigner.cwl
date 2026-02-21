cwlVersion: v1.2
class: CommandLineTool
baseCommand: riassigner
label: riassigner
doc: "A tool for Retention Index (RI) assignment (Note: The provided text is a container
  build error log and does not contain CLI help information).\n\nTool homepage: https://github.com/RECETOX/RIAssigner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riassigner:0.5.0--pyhdfd78af_0
stdout: riassigner.out
