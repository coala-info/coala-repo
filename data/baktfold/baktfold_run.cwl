cwlVersion: v1.2
class: CommandLineTool
baseCommand: baktfold run
label: baktfold_run
doc: "baktfold predict then comapare all in one - GPU recommended\n\nTool homepage:
  https://github.com/gbouras13/baktfold"
inputs:
  - id: all_proteins
    type:
      - 'null'
      - boolean
    doc: annotate all proteins (not just hypotheticals)
    inputBinding:
      position: 101
      prefix: --all-proteins
  - id: batch_size
    type:
      - 'null'
      - int
    doc: batch size for ProstT5. 1 is usually fastest.
    default: 1
    inputBinding:
      position: 101
      prefix: --batch-size
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
    default: '1e-3'
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
    doc: Path to input file in Bakta Genbank format or Bakta JSON format
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
  - id: mask_threshold
    type:
      - 'null'
      - float
    doc: Masks 3Di residues below this value of ProstT5 confidence for Foldseek 
      searches
    default: 25
    inputBinding:
      position: 101
      prefix: --mask-threshold
  - id: max_seqs
    type:
      - 'null'
      - int
    doc: Maximum results per query sequence allowed to pass the prefilter. You 
      may want to reduce this to save disk space for enormous datasets
    default: 1000
    inputBinding:
      position: 101
      prefix: --max-seqs
  - id: omit_probs
    type:
      - 'null'
      - boolean
    doc: Do not output per residue 3Di probabilities from ProstT5. Mean per 
      protein 3Di probabilities will always be output.
    inputBinding:
      position: 101
      prefix: --omit-probs
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: output_baktfold
    inputBinding:
      position: 101
      prefix: --output
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    default: baktfold
    inputBinding:
      position: 101
      prefix: --prefix
  - id: save_per_protein_embeddings
    type:
      - 'null'
      - boolean
    doc: Save the ProstT5 embeddings as means per protein in a h5 file
    inputBinding:
      position: 101
      prefix: --save-per-protein-embeddings
  - id: save_per_residue_embeddings
    type:
      - 'null'
      - boolean
    doc: Save the ProstT5 embeddings per resuide in a h5 file
    inputBinding:
      position: 101
      prefix: --save-per-residue-embeddings
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: Sensitivity parameter for foldseek
    default: 9.5
    inputBinding:
      position: 101
      prefix: --sensitivity
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
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
  - id: use_cpus_only
    type:
      - 'null'
      - boolean
    doc: Use cpus only.
    inputBinding:
      position: 101
      prefix: --cpu
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/baktfold:0.0.3--pyhdfd78af_0
stdout: baktfold_run.out
