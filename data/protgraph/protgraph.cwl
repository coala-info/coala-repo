cwlVersion: v1.2
class: CommandLineTool
baseCommand: protgraph
label: protgraph
doc: "A tool for protein graph generation and peptide export from sequence data.\n\
  \nTool homepage: https://github.com/mpc-bioinformatics/ProtGraph"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Input files to process
    inputBinding:
      position: 1
  - id: annotate_avrg_weights
    type:
      - 'null'
      - boolean
    doc: Annotate average weights
    inputBinding:
      position: 102
      prefix: --annotate_avrg_weights
  - id: annotate_mono_weights
    type:
      - 'null'
      - boolean
    doc: Annotate monoisotopic weights
    inputBinding:
      position: 102
      prefix: --annotate_mono_weights
  - id: calc_num_possibilities
    type:
      - 'null'
      - boolean
    doc: Calculate number of possibilities
    inputBinding:
      position: 102
      prefix: --calc_num_possibilities
  - id: digestion
    type:
      - 'null'
      - string
    doc: Digestion method (gluc, trypsin, skip, full)
    inputBinding:
      position: 102
      prefix: --digestion
  - id: exclude_accessions
    type:
      - 'null'
      - string
    doc: Accessions to exclude
    inputBinding:
      position: 102
      prefix: --exclude_accessions
  - id: export_csv
    type:
      - 'null'
      - boolean
    doc: Export in CSV format
    inputBinding:
      position: 102
      prefix: --export_csv
  - id: export_dot
    type:
      - 'null'
      - boolean
    doc: Export in DOT format
    inputBinding:
      position: 102
      prefix: --export_dot
  - id: export_graphml
    type:
      - 'null'
      - boolean
    doc: Export in GraphML format
    inputBinding:
      position: 102
      prefix: --export_graphml
  - id: export_peptide_fasta
    type:
      - 'null'
      - boolean
    doc: Export peptides in FASTA format
    inputBinding:
      position: 102
      prefix: --export_peptide_fasta
  - id: export_peptide_sqlite
    type:
      - 'null'
      - boolean
    doc: Export peptides to SQLite
    inputBinding:
      position: 102
      prefix: --export_peptide_sqlite
  - id: export_pickle
    type:
      - 'null'
      - boolean
    doc: Export in Pickle format
    inputBinding:
      position: 102
      prefix: --export_pickle
  - id: feature_table
    type:
      - 'null'
      - string
    doc: Feature table selection (e.g., ALL, NONE, VARIANT, etc.)
    inputBinding:
      position: 102
      prefix: --feature_table
  - id: fixed_mod
    type:
      - 'null'
      - string
    doc: Fixed modifications
    inputBinding:
      position: 102
      prefix: --fixed_mod
  - id: mass_dict_factor
    type:
      - 'null'
      - float
    doc: Mass dictionary factor
    inputBinding:
      position: 102
      prefix: --mass_dict_factor
  - id: mass_dict_type
    type:
      - 'null'
      - string
    doc: Mass dictionary type (int or float)
    inputBinding:
      position: 102
      prefix: --mass_dict_type
  - id: no_collapsing_edges
    type:
      - 'null'
      - boolean
    doc: Do not collapse edges
    inputBinding:
      position: 102
      prefix: --no_collapsing_edges
  - id: no_description
    type:
      - 'null'
      - boolean
    doc: Do not include description
    inputBinding:
      position: 102
      prefix: --no_description
  - id: no_merge
    type:
      - 'null'
      - boolean
    doc: Do not merge
    inputBinding:
      position: 102
      prefix: --no_merge
  - id: num_of_entries
    type:
      - 'null'
      - int
    doc: Number of entries to process
    inputBinding:
      position: 102
      prefix: --num_of_entries
  - id: num_of_processes
    type:
      - 'null'
      - int
    doc: Number of processes to use
    inputBinding:
      position: 102
      prefix: --num_of_processes
  - id: output_csv_layout
    type:
      - 'null'
      - File
    doc: Layout for output CSV
    inputBinding:
      position: 102
      prefix: --output_csv_layout
  - id: pep_hops
    type:
      - 'null'
      - int
    doc: Peptide hops
    inputBinding:
      position: 102
      prefix: --pep_hops
  - id: pep_min_pep_length
    type:
      - 'null'
      - int
    doc: Minimum peptide length
    inputBinding:
      position: 102
      prefix: --pep_min_pep_length
  - id: pep_miscleavages
    type:
      - 'null'
      - int
    doc: Peptide miscleavages
    inputBinding:
      position: 102
      prefix: --pep_miscleavages
  - id: pep_sqlite_database
    type:
      - 'null'
      - File
    doc: SQLite database file
    inputBinding:
      position: 102
      prefix: --pep_sqlite_database
  - id: replace_aa
    type:
      - 'null'
      - string
    doc: Amino acid replacement
    inputBinding:
      position: 102
      prefix: --replace_aa
  - id: variable_mod
    type:
      - 'null'
      - string
    doc: Variable modifications
    inputBinding:
      position: 102
      prefix: --variable_mod
  - id: verify_graph
    type:
      - 'null'
      - boolean
    doc: Verify the generated graph
    inputBinding:
      position: 102
      prefix: --verify_graph
  - id: export_output_folder_path
    type:
      - 'null'
      - Directory
    doc: Output or path parameter `export_output_folder_path`
    inputBinding:
      position: 103
      prefix: --export-output-folder
  - id: output_csv_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_csv_path`
    inputBinding:
      position: 104
      prefix: --output-csv
  - id: pep_fasta_out_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `pep_fasta_out_path`
    inputBinding:
      position: 105
      prefix: --pep-fasta-out
outputs:
  - id: output_csv
    type:
      - 'null'
      - File
    doc: Output CSV file
    outputBinding:
      glob: $(inputs.output_csv_path)
  - id: export_output_folder
    type:
      - 'null'
      - Directory
    doc: Folder for exported graphs
    outputBinding:
      glob: $(inputs.export_output_folder_path)
  - id: pep_fasta_out
    type:
      - 'null'
      - File
    doc: Output FASTA file for peptides
    outputBinding:
      glob: $(inputs.pep_fasta_out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protgraph:0.3.12--pyhdfd78af_0
