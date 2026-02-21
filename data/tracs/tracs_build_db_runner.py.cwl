cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracs_build_db_runner.py
label: tracs_build_db_runner.py
doc: "A tool to build databases for TRACS. Note: The provided text appears to be an
  execution log showing a system error (no space left on device) rather than standard
  help documentation, so no specific arguments could be extracted.\n\nTool homepage:
  https://github.com/gtonkinhill/tracs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
stdout: tracs_build_db_runner.py.out
