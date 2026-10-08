cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - groopm
  - split
label: groopm_split
doc: "Split a database into parts\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
inputs:
  - id: database
    type: File
    doc: GroopM database file to open (created by groopm parse) and modified in place
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: bid
    type: string
    doc: Bid (e.g., a sample ID)
    inputBinding:
      position: 2
  - id: parts
    type: int
    doc: Number of parts to split into
    inputBinding:
      position: 3
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force splitting even if parts already exist
    inputBinding:
      position: 104
      prefix: -f
  - id: mode
    type:
      - 'null'
      - string
    doc: Mode of splitting (e.g., 'random', 'sequential')
    inputBinding:
      position: 104
      prefix: -m
outputs:
  - id: database_out
    type: File
    doc: The GroopM database after the command ran (updated in place)
    outputBinding:
      glob: $(inputs.database.basename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.database.basename)
        entry: $(inputs.database)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
stdout: groopm_split.out
