cwlVersion: v1.2
class: CommandLineTool
baseCommand: iqtree
label: iqtree
doc: "The provided text does not contain help information for iqtree; it contains
  system log messages and a fatal error regarding a lack of disk space during a container
  build process.\n\nTool homepage: http://www.iqtree.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iqtree:3.0.1--h503566f_0
stdout: iqtree.out
