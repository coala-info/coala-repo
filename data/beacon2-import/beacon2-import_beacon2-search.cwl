cwlVersion: v1.2
class: CommandLineTool
baseCommand: beacon2-search
label: beacon2-import_beacon2-search
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error indicating a 'no space left on device' condition
  during a container build process.\n\nTool homepage: https://pypi.org/project/beacon2-import/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beacon2-import:2.2.4--pyhdfd78af_0
stdout: beacon2-import_beacon2-search.out
