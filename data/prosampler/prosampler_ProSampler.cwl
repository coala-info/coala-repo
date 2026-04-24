cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./ProSampler
label: prosampler_ProSampler
doc: "ProSampler is a tool for motif discovery in DNA sequences.\n\nTool homepage:
  https://github.com/zhengchangsulab/ProSampler"
inputs:
  - id: background_file
    type:
      - 'null'
      - string
    doc: Name of the background file in FASTA format or order of the Markov 
      model to generate background sequences
    inputBinding:
      position: 101
      prefix: -b
  - id: delete_redundant_motifs_cutoff
    type:
      - 'null'
      - float
    doc: Cutoff of Hamming distance to delete redundant motifs basedn on 
      consensus
    inputBinding:
      position: 101
      prefix: -r
  - id: extend_motif_zvalue_cutoff
    type:
      - 'null'
      - float
    doc: Cutoff of z-value to extend preliniary motifs
    inputBinding:
      position: 101
      prefix: -z
  - id: flanking_lmer_length
    type:
      - 'null'
      - int
    doc: Length of the flanking l-mers
    inputBinding:
      position: 101
      prefix: -l
  - id: gibbs_sampling_cycles
    type:
      - 'null'
      - int
    doc: Number of cycles of Gibbs Sampling to find each preliminary motif
    inputBinding:
      position: 101
      prefix: -f
  - id: hamming_distance_cutoff
    type:
      - 'null'
      - float
    doc: The cutoff of Hamming Distance between any two k-mers in a PWM
    inputBinding:
      position: 101
      prefix: -d
  - id: input_file
    type: File
    doc: Name of the input file in FASTA format
    inputBinding:
      position: 101
      prefix: -i
  - id: merge_kmer_distance_cutoff
    type:
      - 'null'
      - float
    doc: Cutoff of Hamming distance to merge similar k-mers
    inputBinding:
      position: 101
      prefix: -c
  - id: motif_length
    type:
      - 'null'
      - int
    doc: Length of preliminary motifs
    inputBinding:
      position: 101
      prefix: -k
  - id: num_motifs
    type:
      - 'null'
      - string
    doc: 'Number of motifs to be output (default: All)'
    inputBinding:
      position: 101
      prefix: -m
  - id: num_strands
    type:
      - 'null'
      - int
    doc: Number(1 or 2) of strands to be considered
    inputBinding:
      position: 101
      prefix: -p
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix of the names of output files
    inputBinding:
      position: 101
      prefix: -o
  - id: print_help
    type:
      - 'null'
      - boolean
    doc: Print this message
    inputBinding:
      position: 101
      prefix: -h
  - id: significant_kmer_zvalue_cutoff
    type:
      - 'null'
      - float
    doc: Cutoff of z-value to choose significant k-mers
    inputBinding:
      position: 101
      prefix: -t
  - id: subsignificant_kmer_zvalue_cutoff
    type:
      - 'null'
      - float
    doc: Cutoff of z-value to choose sub-significant k-mers
    inputBinding:
      position: 101
      prefix: -w
  - id: sw_score_cutoff
    type:
      - 'null'
      - float
    doc: Cutoff of SW score to construct graph
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prosampler:1.5--h9948957_2
stdout: prosampler_ProSampler.out
