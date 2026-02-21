cwlVersion: v1.2
class: CommandLineTool
baseCommand: Binsanity-wf
label: binsanity_Binsanity-wf
doc: "The provided text contains execution logs and a fatal error message rather than
  the standard help documentation for Binsanity-wf. As a result, no command-line arguments
  could be extracted from this specific input.\n\nTool homepage: https://github.com/edgraham/BinSanity"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binsanity:0.5.4--pyh5e36f6f_0
stdout: binsanity_Binsanity-wf.out
