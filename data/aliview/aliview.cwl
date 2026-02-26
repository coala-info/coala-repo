cwlVersion: v1.2
class: CommandLineTool
baseCommand: aliview
label: aliview
doc: "AliView is a graphical alignment viewer and editor. It is primarily a GUI-based
  application, but it can accept a file path as a positional argument to open an alignment
  on startup.\n\nTool homepage: https://ormbunkar.se/aliview/"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Alignment file to open (e.g., FASTA, Phylip, Clustal, MSF, Nexus).
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aliview:1.30--hdfd78af_0
stdout: aliview.out
