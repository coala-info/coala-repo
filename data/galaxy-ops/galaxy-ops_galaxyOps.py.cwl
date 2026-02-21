cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-ops_galaxyOps.py
label: galaxy-ops_galaxyOps.py
doc: "A tool from the galaxy-ops package (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/galaxyproject/gops"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-ops:1.1.0--py27_0
stdout: galaxy-ops_galaxyOps.py.out
