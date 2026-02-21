cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - msi
  - metabinkit
  - blastgendb
label: msi_metabinkit_blastgendb
doc: "Generate a BLAST database for MSI MetaBinKit. (Note: The provided help text
  contains only container runtime error messages and does not list specific command-line
  arguments.)\n\nTool homepage: http://github.com/nunofonseca/msi/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msi:0.3.8--hdfd78af_0
stdout: msi_metabinkit_blastgendb.out
