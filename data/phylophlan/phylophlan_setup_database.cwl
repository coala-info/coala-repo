cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylophlan_setup_database
label: phylophlan_setup_database
doc: "Formats an input folder or multi-fasta file of marker sequences to be used as a database in phylophlan, or downloads a pre-identified set of core UniRef90 proteins for the species of a given taxonomic label.\n\nTool homepage: https://github.com/biobakery/phylophlan"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: "The file of markers in (multi-)fasta format (one representative sequence per marker)"
    inputBinding:
      position: 1
      prefix: "--input"
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: "The folder containing the marker files, in (multi-)fasta format (used instead of input)"
    inputBinding:
      position: 1
      prefix: "--input"
  - id: get_core_proteins
    type:
      - 'null'
      - string
    doc: "Taxonomic label for which to download the set of core proteins, for example s__Escherichia_coli"
    inputBinding:
      position: 1
      prefix: "--get_core_proteins"
  - id: database_update
    type:
      - 'null'
      - boolean
    doc: "Update the databases file"
    inputBinding:
      position: 1
      prefix: "--database_update"
  - id: output
    type: string
    doc: "Output folder where to save the database (it is created before the run)"
    inputBinding:
      position: 1
      prefix: "--output"
  - id: db_name
    type:
      - 'null'
      - string
    doc: "Name of the output database"
    inputBinding:
      position: 1
      prefix: "--db_name"
  - id: input_extension
    type:
      - 'null'
      - string
    doc: "Extension of the input file(s) specified via input"
    inputBinding:
      position: 1
      prefix: "--input_extension"
  - id: db_type
    type:
      - 'null'
      - string
    doc: "Type of the database: n for nucleotides, a for amino acids"
    inputBinding:
      position: 1
      prefix: "--db_type"
  - id: output_extension
    type:
      - 'null'
      - string
    doc: "Set the database output extension"
    inputBinding:
      position: 1
      prefix: "--output_extension"
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "If specified and the output file exists it will be overwritten"
    inputBinding:
      position: 1
      prefix: "--overwrite"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Prints more stuff"
    inputBinding:
      position: 1
      prefix: "--verbose"
outputs:
  - id: database_dir
    type:
      - 'null'
      - Directory
    doc: "Database folder"
    outputBinding:
      glob: "$(inputs.output)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output)
        entry: '$({"class": "Directory", "basename": inputs.output, "listing": []})'
        writable: true
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylophlan:3.2.1--pyhdfd78af_0
stdout: phylophlan_setup_database.out
