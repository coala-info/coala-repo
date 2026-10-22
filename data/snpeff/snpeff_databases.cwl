cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snpEff
  - databases
label: snpeff_databases
doc: "List the SnpEff databases that can be downloaded.\n\nTool homepage: http://snpeff.sourceforge.net/"
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: "Output format: galaxy (Galaxy menu format) or html"
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (messages)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
stdout: snpeff_databases.out
stderr: snpeff_databases.err
