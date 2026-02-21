cwlVersion: v1.2
class: CommandLineTool
baseCommand: phonenumbers
label: phonenumbers
doc: "The provided text does not contain help information or usage instructions for
  the tool 'phonenumbers'. It appears to be a log of a failed container build/fetch
  process using Apptainer/Singularity.\n\nTool homepage: https://github.com/daviddrysdale/python-phonenumbers"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phonenumbers:7.2.4--py35_0
stdout: phonenumbers.out
