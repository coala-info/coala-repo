cwlVersion: v1.2
class: CommandLineTool
baseCommand: methylextract
label: methylextract
doc: "MethylExtract (Note: The provided text is an error log and does not contain
  help information or argument definitions).\n\nTool homepage: http://bioinfo2.ugr.es/MethylExtract/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylextract:1.9.1--0
stdout: methylextract.out
