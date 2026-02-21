cwlVersion: v1.2
class: CommandLineTool
baseCommand: haslr
label: haslr
doc: "Hybrid Assembler for Long Reads (Note: The provided text is a container runtime
  error log and does not contain help information or argument definitions).\n\nTool
  homepage: https://github.com/vpc-ccg/haslr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haslr:0.8a1--py310h275bdba_6
stdout: haslr.out
