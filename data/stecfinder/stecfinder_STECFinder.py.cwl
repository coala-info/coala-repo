cwlVersion: v1.2
class: CommandLineTool
baseCommand: stecfinder_STECFinder.py
label: stecfinder_STECFinder.py
doc: "STECFinder (Shiga toxin-producing Escherichia coli Finder)\n\nTool homepage:
  https://github.com/LanLab/STECFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stecfinder:1.1.2--pyhdfd78af_0
stdout: stecfinder_STECFinder.py.out
