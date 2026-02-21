cwlVersion: v1.2
class: CommandLineTool
baseCommand: tttrlib
label: tttrlib
doc: "No description available: The provided text contains system logs and error messages
  regarding a container build failure rather than CLI help text.\n\nTool homepage:
  https://github.com/fluorescence-tools/tttrlib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tttrlib:0.25.1--py312hd82e9f0_1
stdout: tttrlib.out
