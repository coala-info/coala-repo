cwlVersion: v1.2
class: CommandLineTool
baseCommand: [database-reduction]
label: madre_database-reduction
doc: "MADRe database reduction: selects the reference genomes supported by the assembly mapping and extracts them into a reduced database.\n\nTool homepage: https://github.com/lbcb-sci/MADRe"
inputs:
  - id: database
    type: File
    doc: Path to the strating database file (fasta/fna).
    inputBinding:
      position: 1
      prefix: --database
  - id: strain_species_info
    type: File
    doc: "An additional parameter required if a custom database path is provided. JSON file with info about species taxid for every strain taxid in the database. If you want to use default one provide path to MADRe/database/taxids_species.json."
    inputBinding:
      position: 2
      prefix: --strain_species_info
  - id: paf_path
    type: File
    doc: Path to the PAF file of assembly mapped to database.
    inputBinding:
      position: 3
      prefix: --paf_path
  - id: num_collapsed_strains
    type: File
    doc: File containing info about number of collapsed strains for every contig (hairsplitter output).
    inputBinding:
      position: 4
      prefix: --num_collapsed_strains
  - id: reduced_list_txt
    type: string
    doc: Path to the file with list of genomes for reduced database.
    inputBinding:
      position: 5
      prefix: --reduced_list_txt
  - id: reduced_db
    type:
      - 'null'
      - string
    doc: Path to the reduced database file (fasta).
    inputBinding:
      position: 6
      prefix: --reduced_db
  - id: mapping_class
    type:
      - 'null'
      - string
    doc: Path to the output mapping contig classification.
    inputBinding:
      position: 7
      prefix: --mapping_class
  - id: mapping_reduced_db
    type:
      - 'null'
      - string
    doc: Path to the output mapping reduced database.
    inputBinding:
      position: 8
      prefix: --mapping_reduced_db
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (default=32).
    inputBinding:
      position: 9
      prefix: --threads
  - id: strictness
    type:
      - 'null'
      - string
    doc: "Strictness of database reduction - choices: less-strict, strict, very-strict - default: very-strict"
    inputBinding:
      position: 10
      prefix: --strictness
  - id: min_contig_len
    type:
      - 'null'
      - int
    doc: Filter out contigs shorter than min_contig_len (default=1000).
    inputBinding:
      position: 11
      prefix: --min_contig_len
  - id: collapsed_strains_overhead
    type:
      - 'null'
      - int
    doc: Maximum overhead for number of collapsed strains per contig estimated by HairSplitter (default=2).
    inputBinding:
      position: 12
      prefix: --collapsed_strains_overhead
outputs:
  - id: reduced_list
    type: File
    doc: List of genomes for the reduced database
    outputBinding:
      glob: $(inputs.reduced_list_txt)
  - id: reduced_database
    type:
      - 'null'
      - File
    doc: Reduced database (fasta)
    outputBinding:
      glob: '$(inputs.reduced_db ? inputs.reduced_db : null)'
  - id: mapping_class_file
    type:
      - 'null'
      - File
    doc: Mapping contig classification
    outputBinding:
      glob: '$(inputs.mapping_class ? inputs.mapping_class : null)'
  - id: mapping_reduced_db_file
    type:
      - 'null'
      - File
    doc: Mapping reduced database
    outputBinding:
      glob: '$(inputs.mapping_reduced_db ? inputs.mapping_reduced_db : null)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/madre:0.0.5--pyhdfd78af_0
