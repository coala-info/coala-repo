cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - TransDecoder.LongOrfs
label: transdecoder_TransDecoder.LongOrfs
doc: Transcriptome Protein Prediction - identify candidate open reading frames 
  (ORFs) within transcripts
inputs:
  - id: transcripts
    type: File
    doc: transcripts.fasta
    inputBinding:
      position: 101
      prefix: -t
  - id: gene_trans_map
    type:
      - 'null'
      - File
    doc: gene-to-transcript identifier mapping file (tab-delimited, 
      gene_id<tab>trans_id<return> )
    inputBinding:
      position: 101
      prefix: --gene_trans_map
  - id: min_protein_length
    type:
      - 'null'
      - int
    doc: 'minimum protein length (default: 100)'
    inputBinding:
      position: 101
      prefix: -m
  - id: strand_specific
    type:
      - 'null'
      - boolean
    doc: strand-specific (only analyzes top strand)
    inputBinding:
      position: 101
      prefix: -S
  - id: output_dir
    type:
      - 'null'
      - string
    doc: path to intended output directory
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: genetic_code
    type:
      - 'null'
      - string
    doc: 'genetic code (default: universal; see PerlDoc; options: Euplotes, Tetrahymena,
      Candida, Acetabularia, etc.)'
    inputBinding:
      position: 101
      prefix: --genetic_code
  - id: complete_orfs_only
    type:
      - 'null'
      - boolean
    doc: yields only complete ORFs (peps start with Met (M), end with stop (*))
    inputBinding:
      position: 101
      prefix: --complete_orfs_only
outputs:
  - id: output_output_dir
    type:
      - 'null'
      - Directory
    doc: path to intended output directory
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2
s:url: https://transdecoder.github.io
$namespaces:
  s: https://schema.org/
