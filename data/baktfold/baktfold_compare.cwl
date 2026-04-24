cwlVersion: v1.2
class: CommandLineTool
baseCommand: baktfold compare
label: baktfold_compare
doc: "Runs Foldseek vs baktfold db\n\nTool homepage: https://github.com/gbouras13/baktfold"
inputs:
  - id: all_proteins
    type:
      - 'null'
      - boolean
    doc: annotate all proteins (not just hypotheticals)
    inputBinding:
      position: 101
      prefix: --all-proteins
  - id: custom_annotations
    type:
      - 'null'
      - File
    doc: Custom Foldseek DB annotations, 2 column tsv. Column 1 matches the 
      Foldseek headers, column 2 is the description.
    inputBinding:
      position: 101
      prefix: --custom-annotations
  - id: custom_db
    type:
      - 'null'
      - string
    doc: Path to custom database
    inputBinding:
      position: 101
      prefix: --custom-db
  - id: database
    type:
      - 'null'
      - string
    doc: Specific path to installed baktfold database
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
      prefix: --extra-foldseek-params
  - id: foldseek_gpu
    type:
      - 'null'
      - boolean
    doc: Use this to enable compatibility with Foldseek-GPU search acceleration
    inputBinding:
      position: 101
      prefix: --foldseek-gpu
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrites the output directory
    inputBinding:
      position: 101
      prefix: --force
  - id: input_file
    type: File
    doc: Path to input file in Genbank format or nucleotide FASTA format
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
      prefix: --keep-tmp-files
  - id: max_seqs
    type:
      - 'null'
      - int
    doc: Maximum results per query sequence allowed to pass the prefilter. You 
      may want to reduce this to save disk space for enormous datasets
    inputBinding:
      position: 101
      prefix: --max-seqs
  - id: predictions_dir
    type:
      - 'null'
      - Directory
    doc: Path to output directory from baktfold predict
    inputBinding:
      position: 101
      prefix: --predictions-dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: Sensitivity parameter for foldseek
    inputBinding:
      position: 101
      prefix: --sensitivity
  - id: structure_dir
    type:
      - 'null'
      - Directory
    doc: Path to directory with .pdb or .cif file structures. The IDs need to be
      in the name of the file i.e id.pdb or id.cif
    inputBinding:
      position: 101
      prefix: --structure-dir
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
    doc: Runs baktfold with maximum sensitivity by skipping Foldseek prefilter. 
      Not recommended for large datasets.
    inputBinding:
      position: 101
      prefix: --ultra-sensitive
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/baktfold:0.0.3--pyhdfd78af_0
