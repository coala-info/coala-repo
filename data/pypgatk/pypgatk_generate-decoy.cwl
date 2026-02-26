cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgatk generate-decoy
label: pypgatk_generate-decoy
doc: "Generate decoy protein sequences for a target protein database.\n\nTool homepage:
  http://github.com/bigbio/py-pgatk"
inputs:
  - id: cleavage_position
    type:
      - 'null'
      - string
    doc: Set cleavage to be c or n terminal of specified cleavage sites. Options
      [c, n], Default = c
    default: c
    inputBinding:
      position: 101
      prefix: --cleavage_position
  - id: config_file
    type:
      - 'null'
      - File
    doc: Configuration file for the protein database decoy generation
    inputBinding:
      position: 101
      prefix: --config_file
  - id: decoy_prefix
    type:
      - 'null'
      - string
    doc: Set accession prefix for decoy proteins in output.
    default: DECOY_
    inputBinding:
      position: 101
      prefix: --decoy_prefix
  - id: do_not_shuffle
    type:
      - 'null'
      - boolean
    doc: Turn OFF shuffling of decoy peptides that are in the target database. 
      Default=false
    default: false
    inputBinding:
      position: 101
      prefix: --do_not_shuffle
  - id: do_not_switch
    type:
      - 'null'
      - boolean
    doc: Turn OFF switching of cleavage site with preceding amino acid. 
      Default=false
    default: false
    inputBinding:
      position: 101
      prefix: --do_not_switch
  - id: enzyme
    type:
      - 'null'
      - string
    doc: 'Enzyme used for clevage the protein sequence (Default: Trypsin)'
    default: Trypsin
    inputBinding:
      position: 101
      prefix: --enzyme
  - id: input_database
    type:
      - 'null'
      - File
    doc: FASTA file of target proteins sequences for which to create decoys 
      (*.fasta|*.fa)
    inputBinding:
      position: 101
      prefix: --input_database
  - id: keep_target_hits
    type:
      - 'null'
      - boolean
    doc: Keep peptides duplicate in target and decoy databases
    inputBinding:
      position: 101
      prefix: --keep_target_hits
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Set maximum number of times to shuffle a peptide to make it non-target 
      before failing. Default=100
    default: 100
    inputBinding:
      position: 101
      prefix: --max_iterations
  - id: max_missed_cleavages
    type:
      - 'null'
      - int
    doc: Number of allowed missed cleavages in the protein sequence when 
      digestion is performed
    inputBinding:
      position: 101
      prefix: --max_missed_cleavages
  - id: max_peptide_length
    type:
      - 'null'
      - int
    doc: Set maximum length of peptides (Default = 100)
    default: 100
    inputBinding:
      position: 101
      prefix: --max_peptide_length
  - id: memory_save
    type:
      - 'null'
      - boolean
    doc: Slower but uses less memory (does not store decoy peptide list). 
      Default=false
    default: false
    inputBinding:
      position: 101
      prefix: --memory_save
  - id: method
    type:
      - 'null'
      - string
    doc: 'The method that would be used to generate the decoys: protein-reverse: reverse
      protein sequences protein-shuffle: shuffle protein sequences decoypyrat: method
      developed for proteogenomics that shuffle redundant peptides in decoy databases
      pgdbdeep: method developed for proteogenomics developed by pypgatk'
    inputBinding:
      position: 101
      prefix: --method
  - id: min_peptide_length
    type:
      - 'null'
      - int
    doc: Set minimum length of peptides (Default = 5)
    default: 5
    inputBinding:
      position: 101
      prefix: --min_peptide_length
  - id: no_isobaric
    type:
      - 'null'
      - boolean
    doc: Do not make decoy peptides isobaric. Default=false
    default: false
    inputBinding:
      position: 101
      prefix: --no_isobaric
  - id: temp_file
    type:
      - 'null'
      - File
    doc: Set temporary file to write decoys prior to shuffling. Default=tmp.fa
    default: tmp.fa
    inputBinding:
      position: 101
      prefix: --temp_file
outputs:
  - id: output_database
    type:
      - 'null'
      - File
    doc: Output file for decoy database
    outputBinding:
      glob: $(inputs.output_database)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
