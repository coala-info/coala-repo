cwlVersion: v1.2
class: CommandLineTool
baseCommand: cured_CURED_FindREs.py
label: cured_CURED_FindREs.py
doc: "A tool for finding restriction enzymes or regulatory elements (Note: The provided
  help text contains only system error logs and no usage information).\n\nTool homepage:
  https://github.com/microbialARC/CURED"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cured:1.05--hdfd78af_0
stdout: cured_CURED_FindREs.py.out
