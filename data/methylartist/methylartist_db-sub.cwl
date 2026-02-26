cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylartist
  - db-sub
label: methylartist_db-sub
doc: "Methylartist database submission/subcommand tool\n\nTool homepage: https://github.com/adamewing/methylartist"
inputs:
  - id: append
    type:
      - 'null'
      - boolean
    doc: Append to the existing database
    inputBinding:
      position: 101
      prefix: --append
  - id: bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: db
    type: File
    doc: Database file
    inputBinding:
      position: 101
      prefix: --db
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
stdout: methylartist_db-sub.out
