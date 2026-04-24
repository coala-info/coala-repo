cwlVersion: v1.2
class: CommandLineTool
baseCommand: TransDecoder.LongOrfs
label: transdecoder_TransDecoder.LongOrfs
doc: "TransDecoder.LongOrfs identifies candidate coding regions within transcript
  sequences by identifying the longest Open Reading Frames (ORFs).\n\nTool homepage:
  https://transdecoder.github.io/"
inputs:
  - id: gene_trans_map
    type:
      - 'null'
      - File
    doc: gene-to-transcript identifier mapping file (tab-delimited, gene_id<tab>trans_id)
    inputBinding:
      position: 101
      prefix: --gene_trans_map
  - id: genetic_code
    type:
      - 'null'
      - string
    doc: "genetic code (default: universal; see Perl's Bio::Tools::CodonTable for
      others)"
    inputBinding:
      position: 101
      prefix: -G
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
    doc: strand-specific (only examines top strand)
    inputBinding:
      position: 101
      prefix: -S
  - id: target_transcripts
    type: File
    doc: target transcripts (fasta file)
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: 'output directory (default: same as target_transcripts file name + .transdecoder_dir)'
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2
