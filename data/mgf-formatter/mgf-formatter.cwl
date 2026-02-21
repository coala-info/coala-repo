cwlVersion: v1.2
class: CommandLineTool
baseCommand: mgf-formatter
label: mgf-formatter
doc: "A tool for formatting MGF (Mascot Generic Format) files. (Note: The provided
  help text contains only container runtime error messages and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/rformassspectrometry/MsBackendMgf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgf-formatter:1.0.0--py27_1
stdout: mgf-formatter.out
