cwlVersion: v1.2
class: CommandLineTool
baseCommand: remurna
label: remurna
doc: The provided text does not contain help information or usage instructions for
  the tool 'remurna'. It appears to be a log of a failed container build process.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/remurna:1.0--h503566f_1
stdout: remurna.out
