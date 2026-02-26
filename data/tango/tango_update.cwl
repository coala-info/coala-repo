cwlVersion: v1.2
class: CommandLineTool
baseCommand: tango update
label: tango_update
doc: "Updates a prot.accession2taxid.gz file based on a mapping of sequence IDs.\n\
  \nTool homepage: https://github.com/johnne/tango"
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
    dockerPull: quay.io/biocontainers/tango:0.5.7--py_0
stdout: tango_update.out
