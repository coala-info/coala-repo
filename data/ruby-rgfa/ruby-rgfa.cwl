cwlVersion: v1.2
class: CommandLineTool
baseCommand: ruby-rgfa
label: ruby-rgfa
doc: The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build/fetch process.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ruby-rgfa:v1.3.1-1-deb_cv1
stdout: ruby-rgfa.out
