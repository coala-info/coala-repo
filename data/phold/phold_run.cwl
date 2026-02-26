cwlVersion: v1.2
class: CommandLineTool
baseCommand: phold_run
label: phold_run
doc: "phold predict then comapare all in one - GPU recommended\n\nTool homepage: https://github.com/gbouras13/phold"
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
    default: 1
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: card_vfdb_evalue
    type:
      - 'null'
      - float
    doc: Stricter E-value threshold for Foldseek CARD and VFDB hits
    default: '1e-10'
    inputBinding:
      position: 101
      prefix: --card_vfdb_evalue
  - id: custom_database
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
  - id: evalue_threshold
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
      prefix: --extra_foldseek_params
  - id: finetune
    type:
      - 'null'
      - boolean
    doc: Use gbouras13/ProstT5Phold encoder + CNN model both finetuned on phage 
      proteins
    inputBinding:
      position: 101
      prefix: --finetune
  - id: foldseek_gpu_acceleration
    type:
      - 'null'
      - boolean
    doc: Use this to enable compatibility with Foldseek-GPU search acceleration
    inputBinding:
      position: 101
      prefix: --foldseek_gpu
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
  - id: keep_temporary_files
    type:
      - 'null'
      - boolean
    doc: Keep temporary intermediate files, particularly the large 
      foldseek_results.tsv of all Foldseek hits
    inputBinding:
      position: 101
      prefix: --keep_tmp_files
  - id: mask_threshold
    type:
      - 'null'
      - float
    doc: Masks 3Di residues below this value of ProstT5 confidence for Foldseek 
      searches
    default: 25
    inputBinding:
      position: 101
      prefix: --mask_threshold
  - id: max_sequences
    type:
      - 'null'
      - int
    doc: Maximum results per query sequence allowed to pass the prefilter. You 
      may want to reduce this to save disk space for enormous datasets
    default: 1000
    inputBinding:
      position: 101
      prefix: --max_seqs
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
    default: output_phold
    inputBinding:
      position: 101
      prefix: --output
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    default: phold
    inputBinding:
      position: 101
      prefix: --prefix
  - id: restart_from_foldseek_output
    type:
      - 'null'
      - boolean
    doc: Use this to restart phold from 'Processing Foldseek output' after 
      foldseek_results.tsv is generated
    inputBinding:
      position: 101
      prefix: --restart
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
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: Sensitivity parameter for foldseek
    default: 9.5
    inputBinding:
      position: 101
      prefix: --sensitivity
  - id: separate_contigs
    type:
      - 'null'
      - boolean
    doc: Output separate GenBank files for each contig
    inputBinding:
      position: 101
      prefix: --separate
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
    doc: Runs phold with maximum sensitivity by skipping Foldseek prefilter. Not
      recommended for large datasets.
    inputBinding:
      position: 101
      prefix: --ultra_sensitive
  - id: use_cpu_only
    type:
      - 'null'
      - boolean
    doc: Use cpus only.
    inputBinding:
      position: 101
      prefix: --cpu
  - id: vanilla_cnn
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
stdout: phold_run.out
