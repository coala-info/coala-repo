cwlVersion: v1.2
class: CommandLineTool
baseCommand: clustalx
label: clustalx
doc: "ClustalX is a graphical interface for the ClustalW multiple sequence alignment
  program. (Note: The provided text is a system error log and does not contain command-line
  argument definitions).\n\nTool homepage: https://github.com/moble/clustalx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/clustalx:v2.1lgpl-8-deb_cv1
stdout: clustalx.out
