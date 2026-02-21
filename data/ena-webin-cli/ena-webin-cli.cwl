cwlVersion: v1.2
class: CommandLineTool
baseCommand: ena-webin-cli
label: ena-webin-cli
doc: "The ENA Webin CLI is used to validate and submit data to the European Nucleotide
  Archive (ENA). (Note: The provided text is a system error log and does not contain
  usage instructions or argument definitions).\n\nTool homepage: https://github.com/enasequence/webin-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ena-webin-cli:9.0.3--hdfd78af_0
stdout: ena-webin-cli.out
