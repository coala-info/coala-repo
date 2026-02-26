cwlVersion: v1.2
class: CommandLineTool
baseCommand: acc2gtdb_tax.py
label: gtdb_to_taxdump_acc2gtdb_tax.py
doc: "Create Sequence accession to TAXID mapping file\n\nTool homepage: https://github.com/nick-youngblut/gtdb_to_taxdump"
inputs:
  - id: gtdb_dir
    type: Directory
    doc: Path to GTDB genome directory
    inputBinding:
      position: 1
  - id: names_dmp
    type: File
    doc: GTDB names.dmp file created  with gtdb_to_taxdump.py
    inputBinding:
      position: 2
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 2
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output acc2tax file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdb_to_taxdump:0.1.9--pyhcf36b3e_0
