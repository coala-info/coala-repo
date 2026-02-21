cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-lib
label: galaxy-lib
doc: "The provided text does not contain help information or usage instructions for
  galaxy-lib. It contains system log messages and a fatal error regarding a container
  build failure (no space left on device).\n\nTool homepage: https://github.com/galaxyproject/galaxy-lib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-lib:19.5.2--py_0
stdout: galaxy-lib.out
