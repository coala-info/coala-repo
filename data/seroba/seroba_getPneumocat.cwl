cwlVersion: v1.2
class: CommandLineTool
baseCommand: seroba getPneumocat
label: seroba_getPneumocat
doc: "Downlaods PneumoCat and build an tsv formated meta data file out of it\n\nTool
  homepage: https://github.com/sanger-pathogens/seroba"
inputs:
  - id: database_dir
    type: Directory
    doc: output directory for PneumoCat Database
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seroba:1.0.2--pyhdfd78af_1
stdout: seroba_getPneumocat.out
