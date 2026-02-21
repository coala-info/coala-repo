cwlVersion: v1.2
class: CommandLineTool
baseCommand: tr-trimmer
label: tr-trimmer
doc: "A tool for trimming tandem repeats (Note: The provided text is a container runtime
  error log and does not contain the actual help documentation for the tool).\n\n
  Tool homepage: https://github.com/apcamargo/tr-trimmer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tr-trimmer:0.4.0--h4349ce8_0
stdout: tr-trimmer.out
