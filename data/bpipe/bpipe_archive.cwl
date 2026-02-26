cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpipe_archive
label: bpipe_archive
doc: "Archiving to computed file path\n\nTool homepage: http://docs.bpipe.org/"
inputs:
  - id: zip_file
    type: File
    doc: Path to the zip file to create
    inputBinding:
      position: 1
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Remove archived files
    inputBinding:
      position: 102
      prefix: --delete
  - id: directory
    type:
      - 'null'
      - Directory
    doc: Directory of Bpipe run to archive
    inputBinding:
      position: 102
      prefix: --dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
stdout: bpipe_archive.out
