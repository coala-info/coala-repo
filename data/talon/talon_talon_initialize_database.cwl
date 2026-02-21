cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - talon_initialize_database
label: talon_talon_initialize_database
doc: "Initialize a TALON database (Note: The provided text contains system error logs
  rather than help documentation; no arguments could be extracted).\n\nTool homepage:
  https://github.com/mortazavilab/TALON"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
stdout: talon_talon_initialize_database.out
