cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylophlan_get_reference
label: phylophlan_get_reference
doc: "Downloads a specified number of reference genomes from the Genbank repository for a taxonomic label (or all species), or lists the available clades.\n\nTool homepage: https://github.com/biobakery/phylophlan"
inputs:
  - id: get
    type:
      - 'null'
      - string
    doc: "Taxonomic label for which to download the set of reference genomes (a valid taxonomic level or the special case \"all\")"
    inputBinding:
      position: 1
      prefix: "--get"
  - id: list_clades
    type:
      - 'null'
      - boolean
    doc: "Print for all taxa the total number of species and reference genomes available"
    inputBinding:
      position: 1
      prefix: "--list_clades"
  - id: database_update
    type:
      - 'null'
      - boolean
    doc: "Update the databases file"
    inputBinding:
      position: 1
      prefix: "--database_update"
  - id: output_file_extension
    type:
      - 'null'
      - string
    doc: "Extension of the output files. Default: .fna.gz"
    inputBinding:
      position: 1
      prefix: "--output_file_extension"
  - id: output
    type:
      - 'null'
      - string
    doc: "Output folder where to save the files, required when get is specified"
    inputBinding:
      position: 1
      prefix: "--output"
  - id: how_many
    type:
      - 'null'
      - int
    doc: "How many reference genomes to download (-1 = all available). Default: 4"
    inputBinding:
      position: 1
      prefix: "--how_many"
  - id: genbank_mapping
    type:
      - 'null'
      - string
    doc: "The local GenBank mapping file, if not found it will be downloaded. Default: assembly_summary_genbank.txt"
    inputBinding:
      position: 1
      prefix: "--genbank_mapping"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Prints more stuff"
    inputBinding:
      position: 1
      prefix: "--verbose"
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: references
    type:
      - 'null'
      - type: array
        items: File
    doc: "Downloaded reference genomes and the GenBank mapping file"
    outputBinding:
      glob:
        - "$(inputs.output)/*"
        - "assembly_summary_genbank.txt"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylophlan:3.2.1--pyhdfd78af_0
stdout: phylophlan_get_reference.out
