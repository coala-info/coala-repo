cwlVersion: v1.2
class: CommandLineTool
baseCommand: trimadap-mt
label: fermikit_trimadap-mt
doc: "Trim adapters from sequencing reads (Note: The provided help text contains a
  container execution error and does not list available arguments).\n\nTool homepage:
  https://github.com/lh3/fermikit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermikit:0.14.dev1--pl5321h86e5fe9_2
stdout: fermikit_trimadap-mt.out
