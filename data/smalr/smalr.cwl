cwlVersion: v1.2
class: CommandLineTool
baseCommand: smalr
label: smalr
doc: "The provided text does not contain help information or usage instructions for
  the tool 'smalr'. It appears to be a log of a failed container build process.\n\n
  Tool homepage: https://github.com/silviazuffi/smalr_online"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/smalr:v1.1dfsg-2-deb_cv1
stdout: smalr.out
