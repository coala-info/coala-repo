cwlVersion: v1.2
class: CommandLineTool
baseCommand: splash
label: splash
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container build process.\n\nTool homepage: https://github.com/refresh-bio/splash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/splash:2.11.0--py313h9ee0642_0
stdout: splash.out
