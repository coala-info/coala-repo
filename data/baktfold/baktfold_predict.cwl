cwlVersion: v1.2
class: CommandLineTool
baseCommand: baktfold predict
label: baktfold_predict
doc: "Uses ProstT5 to predict 3Di tokens - GPU recommended\n\nTool homepage: https://github.com/gbouras13/baktfold"
inputs:
  - id: annotate_all_proteins
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
  - id: database
    type:
      - 'null'
      - string
    doc: Specific path to installed baktfold database
    inputBinding:
      position: 101
      prefix: --database
  - id: force_overwrite
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
  - id: omit_per_residue_probabilities
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
  - id: output_prefix
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
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
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
stdout: baktfold_predict.out
