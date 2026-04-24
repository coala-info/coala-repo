cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phold
  - predict
label: phold_predict
doc: "Uses ProstT5 to predict 3Di tokens - GPU recommended\n\nTool homepage: https://github.com/gbouras13/phold"
inputs:
  - id: annotate_hypothetical_proteins
    type:
      - 'null'
      - boolean
    doc: Use this to only annotate hypothetical proteins from a Pharokka GenBank
      input
    inputBinding:
      position: 101
      prefix: --hyps
  - id: autotune
    type:
      - 'null'
      - boolean
    doc: Run autotuning to detect and automatically use best batch size for your
      hardware. Recommended only if you have a large dataset (e.g. thousands of 
      proteins), or else autotuning will add rather than save runtime.
    inputBinding:
      position: 101
      prefix: --autotune
  - id: batch_size
    type:
      - 'null'
      - int
    doc: batch size for ProstT5.
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: database
    type:
      - 'null'
      - string
    doc: Specific path to installed phold database
    inputBinding:
      position: 101
      prefix: --database
  - id: finetune_phage_models
    type:
      - 'null'
      - boolean
    doc: Use gbouras13/ProstT5Phold encoder + CNN model both finetuned on phage 
      proteins
    inputBinding:
      position: 101
      prefix: --finetune
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
    inputBinding:
      position: 101
      prefix: --mask_threshold
  - id: omit_probabilities
    type:
      - 'null'
      - boolean
    doc: Do not output per residue 3Di probabilities from ProstT5. Mean per 
      protein 3Di probabilities will always be output.
    inputBinding:
      position: 101
      prefix: --omit_probs
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --output
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
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
      prefix: --save_per_protein_embeddings
  - id: save_per_residue_embeddings
    type:
      - 'null'
      - boolean
    doc: Save the ProstT5 embeddings per resuide in a h5 file
    inputBinding:
      position: 101
      prefix: --save_per_residue_embeddings
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_cpu_only
    type:
      - 'null'
      - boolean
    doc: Use cpus only.
    inputBinding:
      position: 101
      prefix: --cpu
  - id: use_vanilla_cnn
    type:
      - 'null'
      - boolean
    doc: Use vanilla CNN model (trained on CASP14) with ProstT5Phold encoder 
      instead of the one trained on phage proteins
    inputBinding:
      position: 101
      prefix: --vanilla
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
stdout: phold_predict.out
