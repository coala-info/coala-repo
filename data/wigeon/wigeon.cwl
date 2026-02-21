cwlVersion: v1.2
class: CommandLineTool
baseCommand: wigeon
label: wigeon
doc: "The provided text does not contain help information or a description for the
  tool 'wigeon'. It appears to be a log of a failed container build/fetch process.\n
  \nTool homepage: https://github.com/alexmaybar/wigeonDB"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/wigeon:v20101212dfsg1-2-deb_cv1
stdout: wigeon.out
