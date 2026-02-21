cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabinner
label: metabinner
doc: "A tool for binning metagenomic contigs (Note: The provided text is an error
  log and does not contain help information).\n\nTool homepage: https://github.com/ziyewang/MetaBinner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabinner:1.4.4--hdfd78af_1
stdout: metabinner.out
