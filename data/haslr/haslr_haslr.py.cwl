cwlVersion: v1.2
class: CommandLineTool
baseCommand: haslr_haslr.py
label: haslr_haslr.py
doc: "Hybrid Assembler for Long Reads (Note: The provided text contains container
  execution errors rather than help documentation. No arguments could be extracted
  from the input.)\n\nTool homepage: https://github.com/vpc-ccg/haslr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haslr:0.8a1--py310h275bdba_6
stdout: haslr_haslr.py.out
