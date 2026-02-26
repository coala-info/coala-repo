cwlVersion: v1.2
class: CommandLineTool
baseCommand: caspeak
label: caspeak_sequence
doc: "caspeak: error: argument {align,peak,valid,exec,plot}: invalid choice: 'sequence'
  (choose from align, peak, valid, exec, plot)\n\nTool homepage: https://github.com/Rye-lxy/CasPeak"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run (align, peak, valid, exec, plot)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/caspeak:1.1.5--pyhdfd78af_0
stdout: caspeak_sequence.out
