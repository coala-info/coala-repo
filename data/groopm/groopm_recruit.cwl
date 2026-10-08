cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - groopm
  - recruit
label: groopm_recruit
doc: "Recruit more contigs into existing bins\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
inputs:
  - id: database
    type: File
    doc: GroopM database file to open (created by groopm parse) and modified in place
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: cutoff
    type:
      - 'null'
      - int
    doc: cutoff contig size
    inputBinding:
      position: 102
      prefix: --cutoff
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite existing db file without prompting
    inputBinding:
      position: 102
      prefix: --force
  - id: inclusivity
    type:
      - 'null'
      - float
    doc: make recruitment more or less inclusive
    inputBinding:
      position: 102
      prefix: --inclusivity
  - id: step
    type:
      - 'null'
      - int
    doc: step size for iterative recruitment
    inputBinding:
      position: 102
      prefix: --step
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
stdout: groopm_recruit.out
