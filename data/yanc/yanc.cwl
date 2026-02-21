cwlVersion: v1.2
class: CommandLineTool
baseCommand: yanc
label: yanc
doc: "The provided text does not contain help information or usage instructions for
  the tool 'yanc'. It appears to be a log of a failed container build process.\n\n
  Tool homepage: https://github.com/dbosoft/YaNco"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yanc:0.3.3--py35_1
stdout: yanc.out
