cwlVersion: v1.2
class: CommandLineTool
baseCommand: phold_proteins-compare
label: phold_proteins-compare
doc: "Runs Foldseek vs phold db on proteins input\n\nTool homepage: https://github.com/gbouras13/phold"
inputs:
  - id: card_vfdb_evalue
    type:
      - 'null'
      - float
    doc: Stricter E-value threshold for Foldseek CARD and VFDB hits
    inputBinding:
      position: 101
      prefix: --card_vfdb_evalue
  - id: custom_db
    type:
      - 'null'
      - string
    doc: Path to custom database
    inputBinding:
      position: 101
      prefix: --custom_db
  - id: database
    type:
      - 'null'
      - string
    doc: Specific path to installed phold database
    inputBinding:
      position: 101
      prefix: --database
  - id: evalue
    type:
      - 'null'
      - float
    doc: Evalue threshold for Foldseek
    inputBinding:
      position: 101
      prefix: --evalue
  - id: extra_foldseek_params
    type:
      - 'null'
      - string
    doc: Extra foldseek search params
    inputBinding:
      position: 101
      prefix: --extra_foldseek_params
  - id: filter_structures
    type:
      - 'null'
      - boolean
    doc: Flag that creates a copy of the .pdb or .cif files structures with 
      matching record IDs found in the input GenBank file. Helpful if you have a
      directory with lots of .pdb files and want to annotate only e.g. 1 phage.
    inputBinding:
      position: 101
      prefix: --filter_structures
  - id: foldseek_gpu
    type:
      - 'null'
      - boolean
    doc: Use this to enable compatibility with Foldseek-GPU search acceleration
    inputBinding:
      position: 101
      prefix: --foldseek_gpu
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrites the output directory
    inputBinding:
      position: 101
      prefix: --force
  - id: input
    type: File
    doc: Path to input file in multiFASTA format
    inputBinding:
      position: 101
      prefix: --input
  - id: keep_tmp_files
    type:
      - 'null'
      - boolean
    doc: Keep temporary intermediate files, particularly the large 
      foldseek_results.tsv of all Foldseek hits
    inputBinding:
      position: 101
      prefix: --keep_tmp_files
  - id: max_seqs
    type:
      - 'null'
      - int
    doc: Maximum results per query sequence allowed to pass the prefilter. You 
      may want to reduce this to save disk space for enormous datasets
    inputBinding:
      position: 101
      prefix: --max_seqs
  - id: predictions_dir
    type:
      - 'null'
      - Directory
    doc: Path to output directory from phold proteins-predict
    inputBinding:
      position: 101
      prefix: --predictions_dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: restart
    type:
      - 'null'
      - boolean
    doc: Use this to restart phold from 'Processing Foldseek output' after 
      foldseek_results.tsv is generated
    inputBinding:
      position: 101
      prefix: --restart
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: Sensitivity parameter for foldseek
    inputBinding:
      position: 101
      prefix: --sensitivity
  - id: separate
    type:
      - 'null'
      - boolean
    doc: Output separate GenBank files for each contig
    inputBinding:
      position: 101
      prefix: --separate
  - id: structure_dir
    type:
      - 'null'
      - Directory
    doc: Path to directory with .pdb or .cif file structures. The CDS IDs need 
      to be in the name of the file
    inputBinding:
      position: 101
      prefix: --structure_dir
  - id: structures
    type:
      - 'null'
      - boolean
    doc: Use if you have .pdb or .cif file structures for the input proteins 
      (e.g. with AF2/Colabfold) in a directory that you specify with 
      --structure_dir
    inputBinding:
      position: 101
      prefix: --structures
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: ultra_sensitive
    type:
      - 'null'
      - boolean
    doc: Runs phold with maximum sensitivity by skipping Foldseek prefilter. Not
      recommended for large datasets.
    inputBinding:
      position: 101
      prefix: --ultra_sensitive
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
