cwlVersion: v1.2
class: CommandLineTool
baseCommand: assembly-scan
label: assembly-scan
doc: "The provided text is a system error log regarding a container build failure
  ('no space left on device') and does not contain the help documentation for the
  tool. Consequently, no arguments could be extracted.\n\nTool homepage: https://github.com/rpetit3/assembly-scan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assembly-scan:1.0.0--pyhdfd78af_0
stdout: assembly-scan.out
