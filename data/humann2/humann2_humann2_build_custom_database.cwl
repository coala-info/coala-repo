cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann2_build_custom_database
label: humann2_humann2_build_custom_database
doc: "Create a custom database file\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann2"
inputs:
  - id: input
    type: File
    doc: "the fasta input file"
    inputBinding:
      position: 101
      prefix: "--input"
  - id: output_path
    type: string
    doc: "the output folder"
    inputBinding:
      position: 102
      prefix: "--output"
  - id: id_mapping
    type:
      - 'null'
      - File
    doc: "the file mapping fasta ids to taxonomy"
    inputBinding:
      position: 103
      prefix: "--id-mapping"
  - id: taxonomic_profile
    type:
      - 'null'
      - File
    doc: "the file containing the taxonomic profile"
    inputBinding:
      position: 104
      prefix: "--taxonomic-profile"
  - id: format
    type:
      - 'null'
      - string
    doc: "the final database format: fasta or diamond"
    inputBinding:
      position: 105
      prefix: "--format"
  - id: genus_abundance_threshold
    type:
      - 'null'
      - float
    doc: "the minimum abundance for a genus to be included in the database"
    inputBinding:
      position: 106
      prefix: "--genus-abundance-threshold"
outputs:
  - id: output
    type: Directory
    doc: "custom database folder"
    outputBinding:
      glob: '$(inputs.output_path)'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_path)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann2:2.8.1--py27_0
