cwlVersion: v1.2
class: CommandLineTool
baseCommand: MITGARD-LR.py
label: mitgard_MITGARD-LR.py
doc: "Mitochondrial Genome Assembler using Long Reads (Note: The provided text is
  an error log and does not contain usage information or argument definitions).\n\n
  Tool homepage: https://github.com/pedronachtigall/MITGARD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitgard:1.1--hdfd78af_0
stdout: mitgard_MITGARD-LR.py.out
