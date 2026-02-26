cwlVersion: v1.2
class: CommandLineTool
baseCommand: theseus
label: theseus
doc: "Maximum likelihood multiple superpositioning\n\nTool homepage: https://github.com/theseus-os/Theseus"
inputs:
  - id: pdb_files
    type:
      type: array
      items: File
    doc: PDB files to superimpose
    inputBinding:
      position: 1
  - id: alignment_file
    type:
      - 'null'
      - File
    doc: Sequence alignment file to use as a guide (CLUSTAL or A2M format)
    inputBinding:
      position: 102
      prefix: -A
  - id: amber_format
    type:
      - 'null'
      - boolean
    doc: For reading AMBER8 formatted PDB files
    inputBinding:
      position: 102
      prefix: --amber
  - id: atoms_to_include
    type:
      - 'null'
      - string
    doc: "Atoms to include in superposition. Can be an integer (0-4) or a colon-delimited
      string specifying atom-types PDB-style (e.g., ' CA  : N  ')."
    default: '0'
    inputBinding:
      position: 102
      prefix: -a
  - id: calculate_scale_factors
    type:
      - 'null'
      - boolean
    doc: Calculate scale factors (for morphometrics)
    inputBinding:
      position: 102
      prefix: -d
  - id: calculate_statistics_only
    type:
      - 'null'
      - boolean
    doc: Just calculate statistics for input file (don't superposition)
    inputBinding:
      position: 102
      prefix: -I
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Maximum iterations for superposition
    default: 200
    inputBinding:
      position: 102
      prefix: -i
  - id: num_principal_components
    type:
      - 'null'
      - int
    doc: Number of principal components to calculate
    default: 0
    inputBinding:
      position: 102
      prefix: -P
  - id: output_root_name
    type:
      - 'null'
      - string
    doc: Root name for output files
    default: theseus
    inputBinding:
      position: 102
      prefix: -r
  - id: print_expert_options
    type:
      - 'null'
      - boolean
    doc: Print expert options
    inputBinding:
      position: 102
      prefix: -E
  - id: print_fasta_and_quit
    type:
      - 'null'
      - boolean
    doc: Print FASTA files of the sequences in PDB files and quit
    inputBinding:
      position: 102
      prefix: -F
  - id: read_first_model
    type:
      - 'null'
      - boolean
    doc: Only read the first model of a multi-model PDB file
    inputBinding:
      position: 102
      prefix: -f
  - id: residues_to_exclude
    type:
      - 'null'
      - string
    doc: Residues to exclude (e.g., -S15-45:50-55)
    default: none
    inputBinding:
      position: 102
      prefix: -S
  - id: residues_to_select
    type:
      - 'null'
      - string
    doc: Residues to select (e.g., -s15-45:50-55)
    default: all
    inputBinding:
      position: 102
      prefix: -s
  - id: sequence_mapping_file
    type:
      - 'null'
      - File
    doc: File that maps sequences in the alignment file to PDB files
    inputBinding:
      position: 102
      prefix: -M
  - id: use_covariance_matrix
    type:
      - 'null'
      - boolean
    doc: Use covariance matrix for PCA (correlation matrix is default)
    inputBinding:
      position: 102
      prefix: -C
  - id: use_least_squares
    type:
      - 'null'
      - boolean
    doc: Superimpose with conventional least squares method
    inputBinding:
      position: 102
      prefix: -l
  - id: use_ml_variance_weighting
    type:
      - 'null'
      - boolean
    doc: Use ML variance weighting (no correlations)
    inputBinding:
      position: 102
      prefix: -v
  - id: use_tps_morphometric_files
    type:
      - 'null'
      - boolean
    doc: Read and write Rohlf TPS morphometric landmark files
    inputBinding:
      position: 102
      prefix: -q
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/theseus:v3.3.0-8-deb_cv1
stdout: theseus.out
