cwlVersion: v1.2
class: CommandLineTool
baseCommand: sourmash
label: sourmash
doc: "The provided text is a container build error log and does not contain CLI help
  information or argument definitions.\n\nTool homepage: https://github.com/sourmash-bio/sourmash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
stdout: sourmash.out
