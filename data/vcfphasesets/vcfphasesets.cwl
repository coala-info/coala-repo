cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfphasesets
label: vcfphasesets
doc: "A tool for processing VCF phase sets (Note: The provided help text contains
  only container runtime error logs and does not list usage or arguments).\n\nTool
  homepage: https://github.com/LUMC/vcfphasesets"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfphasesets:0.3--pyhdfd78af_0
stdout: vcfphasesets.out
