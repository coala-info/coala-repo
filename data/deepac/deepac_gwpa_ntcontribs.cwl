cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac
  - gwpa
  - ntcontribs
label: deepac_gwpa_ntcontribs
doc: "Generate a genome-wide nt contribution map.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: model
    type: File
    doc: "Model file (.h5)"
    inputBinding:
      position: 101
      prefix: --model
  - id: dir_fragmented_genomes
    type: Directory
    doc: "Directory containing the fragmented genomes (.fasta)"
    inputBinding:
      position: 101
      prefix: --dir-fragmented-genomes
  - id: genomes_dir
    type: Directory
    doc: "Directory containing genomes (.genome)"
    inputBinding:
      position: 101
      prefix: --genomes-dir
  - id: out_dir
    type: string
    doc: "Output directory"
    default: "nt_contribs"
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: ref_mode
    type:
      - 'null'
      - type: enum
        symbols:
          - "N"
          - "GC"
          - "own_ref_file"
    doc: "Modus to calculate reference sequences"
    inputBinding:
      position: 101
      prefix: --ref-mode
  - id: train_data
    type:
      - 'null'
      - File
    doc: "Train data (.npy), necessary to calculate reference sequences if ref_mode is 'GC'"
    inputBinding:
      position: 101
      prefix: --train-data
  - id: ref_seqs
    type:
      - 'null'
      - File
    doc: "User provided reference sequences (.fasta) if ref_mode is 'own_ref_file'"
    inputBinding:
      position: 101
      prefix: --ref-seqs
  - id: read_length
    type:
      - 'null'
      - int
    doc: "Fragment length"
    inputBinding:
      position: 101
      prefix: --read-length
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: "Sequence chunk size. Decrease for lower memory usage."
    inputBinding:
      position: 101
      prefix: --seq-chunk
  - id: gradient
    type:
      - 'null'
      - boolean
    doc: "Use Integrated Gradients instead of DeepLIFT."
    inputBinding:
      position: 101
      prefix: --gradient
  - id: no_check
    type:
      - 'null'
      - boolean
    doc: "Disable additivity check."
    inputBinding:
      position: 101
      prefix: --no-check
  - id: target_class
    type:
      - 'null'
      - int
    doc: "Target class ID. Leave unset for binary classification"
    inputBinding:
      position: 101
      prefix: --target-class
outputs:
  - id: out
    type: Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
