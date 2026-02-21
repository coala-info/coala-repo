cwlVersion: v1.2
class: CommandLineTool
baseCommand: metadmg
label: metadmg
doc: "The provided text is a system error log regarding a container build failure
  (no space left on device) and does not contain help documentation or argument definitions.\n
  \nTool homepage: https://github.com/metaDMG-dev/metaDMG-cpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metadmg:0.4.2--h2d82557_0
stdout: metadmg.out
