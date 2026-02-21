cwlVersion: v1.2
class: CommandLineTool
baseCommand: je
label: je-suite_je
doc: "Je-suite is a suite of tools for handling multiplexed sequencing data. (Note:
  The provided help text contains only container runtime error messages and does not
  list specific command-line arguments.)\n\nTool homepage: https://gbcs.embl.de/Je"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/je-suite:2.0.RC--0
stdout: je-suite_je.out
