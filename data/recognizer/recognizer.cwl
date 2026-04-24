cwlVersion: v1.2
class: CommandLineTool
baseCommand: recognizer
label: recognizer
doc: "a tool for domain based annotation with the CDD database\n\nTool homepage: https://github.com/iquasere/reCOGnizer"
inputs:
  - id: custom_databases
    type:
      - 'null'
      - boolean
    doc: If databases inputted were NOT produced by reCOGnizer [False]. Default 
      databases of reCOGnizer (e.g., COG, TIGR, ...) can't be used 
      simultaneously with custom databases. Use together with the '--databases' 
      parameter.
    inputBinding:
      position: 101
      prefix: --custom-databases
  - id: databases
    type:
      - 'null'
      - string
    doc: Databases to include in functional annotation (comma-separated)
    inputBinding:
      position: 101
      prefix: --databases
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print all commands running in the background, including those of 
      rpsblast and rpsbproc.
    inputBinding:
      position: 101
      prefix: --debug
  - id: evalue
    type:
      - 'null'
      - float
    doc: Maximum e-value to report annotations for
    inputBinding:
      position: 101
      prefix: --evalue
  - id: fasta_file
    type: File
    doc: Fasta file with protein sequences for annotation
    inputBinding:
      position: 101
      prefix: --file
  - id: keep_intermediates
    type:
      - 'null'
      - boolean
    doc: Keep intermediate annotation files generated in reCOGnizer's workflow, 
      i.e., ASN, RPSBPROC and BLAST reports and split FASTA inputs.
    inputBinding:
      position: 101
      prefix: --keep-intermediates
  - id: keep_spaces
    type:
      - 'null'
      - boolean
    doc: BLAST ignores sequences IDs after the first space. This option changes 
      all spaces to underscores to keep the full IDs.
    inputBinding:
      position: 101
      prefix: --keep-spaces
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: Number of maximum identifications for each protein
    inputBinding:
      position: 101
      prefix: --max-target-seqs
  - id: no_blast_info
    type:
      - 'null'
      - boolean
    doc: Information from the alignment will be stored in their own columns.
    inputBinding:
      position: 101
      prefix: --no-blast-info
  - id: no_output_sequences
    type:
      - 'null'
      - boolean
    doc: Protein sequences from the FASTA input will be stored in their own 
      column.
    inputBinding:
      position: 101
      prefix: --no-output-sequences
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --output
  - id: output_rpsbproc_cols
    type:
      - 'null'
      - boolean
    doc: Output columns obtained with RPSBPROC - 'Superfamilies', 'Sites' and 
      'Motifs'.
    inputBinding:
      position: 101
      prefix: --output-rpsbproc-cols
  - id: protein_id_col
    type:
      - 'null'
      - string
    doc: Name of column with protein headers as in supplied FASTA file
    inputBinding:
      position: 101
      prefix: --protein-id-col
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't output download information, used mainly for CI.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: resources_directory
    type:
      - 'null'
      - Directory
    doc: Output directory for storing databases and other resources
    inputBinding:
      position: 101
      prefix: --resources-directory
  - id: species_taxids
    type:
      - 'null'
      - boolean
    doc: If tax col contains Tax IDs of species (required for running COG 
      taxonomic)
    inputBinding:
      position: 101
      prefix: --species-taxids
  - id: tax_col
    type:
      - 'null'
      - string
    doc: Name of column with tax IDs of proteins
    inputBinding:
      position: 101
      prefix: --tax-col
  - id: tax_file
    type:
      - 'null'
      - File
    doc: File with taxonomic identification of proteins inputted (TSV). Must 
      have one line per query, query name on first column, taxid on second.
    inputBinding:
      position: 101
      prefix: --tax-file
  - id: test_run
    type:
      - 'null'
      - boolean
    doc: This parameter is only appropriate for reCOGnizer's tests on GitHub. 
      Should not be used.
    inputBinding:
      position: 101
      prefix: --test-run
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for reCOGnizer to use [max available]
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recognizer:1.11.1--hdfd78af_0
stdout: recognizer.out
