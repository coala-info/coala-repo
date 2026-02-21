cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssw-align
label: ssw-align
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a failed container image retrieval.\n\n
  Tool homepage: https://github.com/kyu999/ssw_aligner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ssw-align:v1.1-2-deb_cv1
stdout: ssw-align.out
