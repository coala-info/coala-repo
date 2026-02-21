cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycluster
label: pycluster
doc: "The provided text does not contain help information for pycluster; it is a log
  of a failed container build process.\n\nTool homepage: http://bonsai.hgc.jp/~mdehoon/software/cluster/software.htm#pycluster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycluster:1.54--py39hff726c5_9
stdout: pycluster.out
