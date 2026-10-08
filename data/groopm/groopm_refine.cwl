cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - groopm
  - refine
label: groopm_refine
doc: "Merge similar bins and split chimeric ones\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
inputs:
  - id: database
    type: File
    doc: GroopM database file to open (created by groopm parse) and modified in place
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: auto
    type:
      - 'null'
      - boolean
    doc: automatically refine bins
    inputBinding:
      position: 102
      prefix: --auto
  - id: no_transform
    type:
      - 'null'
      - boolean
    doc: skip data transformation (3 stoits only)
    inputBinding:
      position: 102
      prefix: --no_transform
  - id: plot
    type:
      - 'null'
      - boolean
    doc: create plots of bins after refinement
    inputBinding:
      position: 102
      prefix: --plot
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
stdout: groopm_refine.out
