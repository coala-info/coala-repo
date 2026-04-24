cwlVersion: v1.2
class: CommandLineTool
baseCommand: EukRep
label: eukrep_EukRep
doc: "Identify sequences of predicted eukaryotic origin from a nucleotide fasta file.
  Individual sequences are split into 5kb chunks. Prediction is performed on each
  5kb chunk and sequence origin is determined by majority rule of the chunks.\n\n\
  Tool homepage: https://github.com/patrickwest/EukRep"
inputs:
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Force overwrite of existing output files
    inputBinding:
      position: 101
      prefix: -ff
  - id: input_fasta
    type: File
    doc: input fasta file
    inputBinding:
      position: 101
      prefix: -i
  - id: kmer_len
    type:
      - 'null'
      - int
    doc: Kmer length to use for making predictions. Lengths between 3-7bp are 
      available by default. If using a custom trained model, specify kmer length
      here.
    inputBinding:
      position: 101
      prefix: --kmer_len
  - id: min_sequence_length
    type:
      - 'null'
      - string
    doc: Minimum sequence length cutoff for sequences to be included in 
      prediction.
    inputBinding:
      position: 101
      prefix: --min
  - id: model
    type:
      - 'null'
      - string
    doc: Path to an alternate trained linear SVM model.
    inputBinding:
      position: 101
      prefix: --model
  - id: prokarya_output_file
    type:
      - 'null'
      - File
    doc: Name of file to output predicted prokaryotic sequences to. Default is 
      to not output prokaryotic sequences.
    inputBinding:
      position: 101
      prefix: --prokarya
  - id: sequence_names_only
    type:
      - 'null'
      - boolean
    doc: Only output fasta headers of identified sequences. Default is full 
      fasta entry
    inputBinding:
      position: 101
      prefix: --seq_names
  - id: stringency_mode
    type:
      - 'null'
      - string
    doc: How stringent the algorithm is in identifying eukaryotic scaffolds. 
      Strict has a lower false positive rate and true positive rate; vice verso 
      for leneient. Default is balanced.
    inputBinding:
      position: 101
      prefix: -m
  - id: tie_breaking_rule
    type:
      - 'null'
      - string
    doc: "Specify how to handle cases where an equal number of a sequences chunks
      are predicted to be of eukaryotic and prokaryotic origin (Generally occurs infrequently).\n\
      \                                euk = classify as euk\n                   \
      \             prok = classify as prok\n                                rand
      = assign randomly\n                                skip = do not classify\n\
      \                                Default is to classify as eukaryotic."
    inputBinding:
      position: 101
      prefix: --tie
outputs:
  - id: output_file
    type: File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eukrep:0.6.7--pyh7e72e81_3
