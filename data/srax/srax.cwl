cwlVersion: v1.2
class: CommandLineTool
baseCommand: srax
label: srax
doc: "sRAx (Note: The provided text is a container runtime error log and does not
  contain the tool's help documentation or argument definitions.)\n\nTool homepage:
  https://github.com/lgpdevtools/sraX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srax:1.5--pl5321h05cac1d_4
stdout: srax.out
