cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamkit_bamheadrg.py
label: bamkit_bamheadrg.py
doc: "The provided text does not contain help documentation or a description for the
  tool. It appears to be a log of a failed container build process due to insufficient
  disk space.\n\nTool homepage: https://github.com/hall-lab/bamkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamkit:16.07.26--py_0
stdout: bamkit_bamheadrg.py.out
