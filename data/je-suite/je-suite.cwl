cwlVersion: v1.2
class: CommandLineTool
baseCommand: je-suite
label: je-suite
doc: "A suite of tools for processing multiplexed sequencing data (Je: Just Eight).
  Note: The provided input text contains container runtime error messages rather than
  tool help documentation.\n\nTool homepage: https://gbcs.embl.de/Je"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/je-suite:2.0.RC--0
stdout: je-suite.out
