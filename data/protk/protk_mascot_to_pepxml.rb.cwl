cwlVersion: v1.2
class: CommandLineTool
baseCommand: mascot_to_pepxml.rb
label: protk_mascot_to_pepxml.rb
doc: 'Convert mascot dat files to pep.xml files.


  Tool homepage: https://github.com/iracooke/protk'
inputs:
  - id: dat_files
    type:
      type: array
      items: File
    doc: Mascot dat result files (staged in the working directory because the tool writes temporary files
      beside them)
    inputBinding:
      position: 1
      valueFrom: $(self.map(function(f){ return f.basename; }))
  - id: replace_output
    type:
      - 'null'
      - boolean
    doc: Dont skip analyses for which the output file already exists
    inputBinding:
      position: 102
      prefix: --replace-output
  - id: database
    type:
      - 'null'
      - string
      - File
    doc: Specify the database to use for this search. Can be a named protk database or the path to a fasta
      file [sphuman]
    inputBinding:
      position: 102
      prefix: --database
  - id: enzyme
    type:
      - 'null'
      - string
    doc: Enzyme [Trypsin]
    inputBinding:
      position: 102
      prefix: --enzyme
  - id: shortid
    type:
      - 'null'
      - boolean
    doc: Use short protein id as per Mascot result (default uses full protein ids in fasta file)
    inputBinding:
      position: 102
      prefix: --shortid
  - id: output_path
    type: string
    doc: An explicitly named output file.
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: An explicitly named output file.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.dat_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
