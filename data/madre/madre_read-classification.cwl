cwlVersion: v1.2
class: CommandLineTool
baseCommand: [read-classification]
label: madre_read-classification
doc: "MADRe read classification: assigns reads to reference strains from the PAF file of the assembly mapped to the database, and can cluster similar strains.\n\nTool homepage: https://github.com/lbcb-sci/MADRe"
inputs:
  - id: paf_path
    type: File
    doc: Path to the PAF file of assembly mapped to database.
    inputBinding:
      position: 1
      prefix: --paf_path
  - id: strain_species_info
    type: File
    doc: "An additional parameter required if a custom database path is provided. JSON file with info about species taxid for every strain taxid in the database. If you want to use default one provide path to MADRe/database/taxids_species.json."
    inputBinding:
      position: 2
      prefix: --strain_species_info
  - id: read_class_output
    type:
      - 'null'
      - string
    doc: Path to the output file with classification labels for reads. (default=read_classification.out)
    inputBinding:
      position: 3
      prefix: --read_class_output
  - id: clustering_out
    type:
      - 'null'
      - string
    doc: Path to clustering output directory. If provided clustering using mapping info from --paf_path will be performed, otherwise not.
    inputBinding:
      position: 4
      prefix: --clustering_out
outputs:
  - id: read_class
    type: File
    doc: File with classification labels for reads
    outputBinding:
      glob: '$(inputs.read_class_output ? inputs.read_class_output : "read_classification.out")'
  - id: clustering_dir
    type:
      - 'null'
      - Directory
    doc: Clustering output directory (clusters.txt and representatives.txt)
    outputBinding:
      glob: '$(inputs.clustering_out ? inputs.clustering_out : null)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/madre:0.0.5--pyhdfd78af_0
