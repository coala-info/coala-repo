cwlVersion: v1.2
class: CommandLineTool
baseCommand: vhh-predict
label: viral-host-hunter_vhh-predict
doc: "Run the Viral-Host-Hunter prediction pipeline for viral host identification
  based on protein and DNA sequences.\n\nTool homepage: https://github.com/YuehuaOu/Viral-Host-Hunter"
inputs:
  - id: dna
    type: File
    doc: Path to the corresponding DNA FASTA file.
    inputBinding:
      position: 101
      prefix: --dna
  - id: embedding_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save/load precomputed embeddings (prot_embedding.h5, 
      dna_embedding.h5). If embeddings already exist, they will be reused to 
      speed up prediction.
    inputBinding:
      position: 101
      prefix: --embedding_dir
  - id: level
    type:
      - 'null'
      - string
    doc: 'Taxonomic prediction level: "all", "family", "genus", or "species".'
    inputBinding:
      position: 101
      prefix: --level
  - id: lineage
    type:
      - 'null'
      - boolean
    doc: If set, append lineage columns in the output.
    inputBinding:
      position: 101
      prefix: --lineage
  - id: model_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing the trained Viral-Host-Hunter models.
    inputBinding:
      position: 101
      prefix: --model_dir
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format for prediction results.
    inputBinding:
      position: 101
      prefix: --output_format
  - id: phage_type
    type:
      - 'null'
      - string
    doc: 'Phage source type: "gut" for intestinal phages or "environment" for environmental
      phages.'
    inputBinding:
      position: 101
      prefix: --phage_type
  - id: protein
    type: File
    doc: Path to the protein FASTA file to be predicted.
    inputBinding:
      position: 101
      prefix: --protein
  - id: prott5_dir
    type:
      - 'null'
      - Directory
    doc: Path to a local ProtT5 model directory for offline embedding 
      generation. Use this option if the system cannot download the model from 
      the internet.
    inputBinding:
      position: 101
      prefix: --prott5_dir
  - id: seq_type
    type: string
    doc: 'Protein type used for prediction: "tail" or "lysin".'
    inputBinding:
      position: 101
      prefix: --seq_type
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save prediction results.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-host-hunter:0.2.0--pyhdfd78af_1
