cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccne-acc
label: ccne_ccne-acc
doc: "The provided text does not contain help information for the tool. It is a log
  of a failed container build process due to insufficient disk space.\n\nTool homepage:
  https://github.com/biojiang/ccne"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccne:1.1.2--hdfd78af_0
stdout: ccne_ccne-acc.out
