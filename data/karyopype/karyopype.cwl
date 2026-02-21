cwlVersion: v1.2
class: CommandLineTool
baseCommand: karyopype
label: karyopype
doc: "A tool for karyotype analysis and visualization. (Note: The provided text is
  an error log and does not contain usage information or argument definitions.)\n\n
  Tool homepage: http://github.com/jakevc/karyopype"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/karyopype:0.1.6--py_0
stdout: karyopype.out
