cwlVersion: v1.2
class: CommandLineTool
baseCommand: merqury.sh
label: merqury_merqury.sh
doc: "K-mer based genome assembly evaluation\n\nTool homepage: https://github.com/marbl/merqury"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merqury:1.3--hdfd78af_4
stdout: merqury_merqury.sh.out
