cwlVersion: v1.2
class: CommandLineTool
baseCommand: pepr
label: pepr
doc: "The provided text does not contain help information for the tool 'pepr'. It
  appears to be a log of a container execution failure indicating that the executable
  was not found.\n\nTool homepage: https://github.com/shawnzhangyx/PePr/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pepr:1.1.24--py35_0
stdout: pepr.out
