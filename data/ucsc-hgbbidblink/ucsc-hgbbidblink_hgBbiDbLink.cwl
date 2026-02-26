cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgBbiDbLink
label: ucsc-hgbbidblink_hgBbiDbLink
doc: "Add table that just contains a pointer to a bbiFile to database. This program
  is used to add bigWigs and bigBeds.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: database
    type: string
    doc: Database name
    inputBinding:
      position: 1
  - id: track_name
    type: string
    doc: Track name
    inputBinding:
      position: 2
  - id: file_name
    type: File
    doc: Name of the bbiFile (bigWig or bigBed)
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgbbidblink:482--h0b57e2e_0
stdout: ucsc-hgbbidblink_hgBbiDbLink.out
