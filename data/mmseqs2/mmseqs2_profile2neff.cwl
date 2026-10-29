cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - profile2neff
label: mmseqs2_profile2neff
doc: 'Convert a profile DB to a tab-separated list of Neff scores.


  By Johannes Spies <johannes.spies@tum.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: profile_db
    type: Directory
    doc: Input profile database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.profile_db_name)
  - id: profile_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_neff_name
    type: string
    doc: Name of the output Neff file
    inputBinding:
      position: 2
outputs:
  - id: output_neff
    type: File
    doc: Tab-separated list of Neff scores
    outputBinding:
      glob: $(inputs.output_neff_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
