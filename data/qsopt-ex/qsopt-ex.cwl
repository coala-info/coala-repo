cwlVersion: v1.2
class: CommandLineTool
baseCommand: qsopt-ex
label: qsopt-ex
doc: "The provided text does not contain help information or a description for the
  tool. It appears to be a log of a failed container image build/fetch process.\n\n
  Tool homepage: https://github.com/jonls/python-qsoptex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/qsopt-ex:v2.5.10.3-2-deb_cv1
stdout: qsopt-ex.out
