cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfsim
label: vcfsim
doc: "A tool for simulating VCF (Variant Call Format) files. Note: The provided text
  appears to be a container engine error log rather than help text, so no specific
  arguments could be extracted.\n\nTool homepage: https://github.com/Pie115/VCFSimulator-SamukLab"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfsim:1.0.27.alpha--pyhdc42f0e_0
stdout: vcfsim.out
