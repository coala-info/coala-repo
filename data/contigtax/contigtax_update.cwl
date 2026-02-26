cwlVersion: v1.2
class: CommandLineTool
baseCommand: contigtax update
label: contigtax_update
doc: "Update a prot.accession2taxid.gz file with new sequence IDs.\n\nTool homepage:
  https://github.com/NBISweden/contigtax"
inputs:
  - id: taxonmap
    type: File
    doc: Existing prot.accession2taxid.gz file
    inputBinding:
      position: 1
  - id: idfile
    type: File
    doc: File mapping long sequence ids to new ids
    inputBinding:
      position: 2
  - id: newfile
    type: File
    doc: Updated mapfile
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0
stdout: contigtax_update.out
