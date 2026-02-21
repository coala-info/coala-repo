cwlVersion: v1.2
class: CommandLineTool
baseCommand: carna_Setup.exe
label: carna_Setup.exe
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build/execution process.\n\nTool homepage:
  https://github.com/Code52/carnac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carna:1.3.3--1
stdout: carna_Setup.exe.out
