cwlVersion: v1.2
class: CommandLineTool
baseCommand: smartmap
label: smartmap
doc: "A tool for mapping and analyzing genomic data (Note: The provided text is an
  error log and does not contain usage instructions or argument definitions).\n\n
  Tool homepage: http://shah-rohan.github.io/SmartMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartmap:1.0.0--h077b44d_4
stdout: smartmap.out
