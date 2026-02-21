cwlVersion: v1.2
class: CommandLineTool
baseCommand: ecmwfapi
label: ecmwfapi
doc: "ECMWF Web API client (Note: The provided text is a container runtime error log
  and does not contain CLI help information)\n\nTool homepage: https://github.com/windsor718/ECMWFAPI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ecmwfapi:1.4.1--py27_0
stdout: ecmwfapi.out
