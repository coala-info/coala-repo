cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidseeker_database_builder.pl
label: plasmidseeker_database_builder.pl
doc: "Builds a k-mer database from a plasmid FASTA file for use with PlasmidSeeker.\n
  \nTool homepage: https://github.com/bioinfo-ut/PlasmidSeeker"
inputs:
  - id: blacklist_fasta
    type:
      - 'null'
      - File
    doc: Optional blacklist FASTA file (e.g., human or bacterial genome) to filter
      out common k-mers
    inputBinding:
      position: 101
      prefix: -b
  - id: input_fasta
    type: File
    doc: Input plasmid FASTA file
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: database_dir
    type: Directory
    doc: Output directory where the database files will be created
    outputBinding:
      glob: $(inputs.database_dir)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plasmidseeker:v1.0dfsg-1-deb_cv1
