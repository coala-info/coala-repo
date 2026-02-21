cwlVersion: v1.2
class: CommandLineTool
baseCommand: regex
label: regex
doc: "The provided text does not contain help information or usage instructions for
  the tool 'regex'. It appears to be a log of a failed container build process.\n\n
  Tool homepage: https://github.com/ziishaned/learn-regex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regex:2016.06.24--py36_1
stdout: regex.out
