cwlVersion: v1.2
class: CommandLineTool
baseCommand: hybracter
label: hybracter
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure (no space left
  on device).\n\nTool homepage: https://github.com/gbouras13/hybracter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybracter:0.12.0--pyhdfd78af_0
stdout: hybracter.out
