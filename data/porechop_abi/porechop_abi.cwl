cwlVersion: v1.2
class: CommandLineTool
baseCommand: porechop_abi
label: porechop_abi
doc: "Porechop_abi is a tool for finding and removing adapters from Oxford Nanopore
  reads. (Note: The provided text appears to be a container runtime error log rather
  than the tool's help output, so no arguments could be extracted.)\n\nTool homepage:
  https://github.com/bonsai-team/Porechop_ABI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/porechop_abi:0.5.1--py310h275bdba_0
stdout: porechop_abi.out
