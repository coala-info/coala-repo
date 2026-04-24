cwlVersion: v1.2
class: CommandLineTool
baseCommand: singlem regenerate
label: singlem_regenerate
doc: "Update a SingleM package with new sequences and taxonomy (expert mode).\n\n\
  Tool homepage: https://github.com/wwood/singlem"
inputs:
  - id: input_sequences
    type: File
    doc: all on-target amino acid sequences fasta file for new package
    inputBinding:
      position: 1
  - id: input_taxonomy
    type: File
    doc: tab-separated sequence ID to taxonomy file of on-target sequence 
      taxonomy
    inputBinding:
      position: 2
  - id: candidate_decoy_sequences
    type:
      - 'null'
      - File
    doc: candidate amino acid sequences fasta file to search for decoys
    inputBinding:
      position: 103
      prefix: --candidate-decoy-sequences
  - id: candidate_decoy_taxonomy
    type:
      - 'null'
      - File
    doc: tab-separated sequence ID to taxonomy file of candidate decoy sequences
    inputBinding:
      position: 103
      prefix: --candidate-decoy-taxonomy
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 103
      prefix: --debug
  - id: euk_sequences
    type:
      - 'null'
      - File
    doc: candidate amino acid sequences fasta file to search for decoys
    inputBinding:
      position: 103
      prefix: --euk-sequences
  - id: euk_taxonomy
    type:
      - 'null'
      - File
    doc: tab-separated sequence ID to taxonomy file of candidate decoy sequences
    inputBinding:
      position: 103
      prefix: --euk-taxonomy
  - id: full_help
    type:
      - 'null'
      - boolean
    doc: print longer help message
    inputBinding:
      position: 103
      prefix: --full-help
  - id: full_help_roff
    type:
      - 'null'
      - boolean
    doc: print longer help message in ROFF (manpage) format
    inputBinding:
      position: 103
      prefix: --full-help-roff
  - id: input_singlem_package
    type: File
    doc: input package path
    inputBinding:
      position: 103
      prefix: --input-singlem-package
  - id: min_aligned_percent
    type:
      - 'null'
      - float
    doc: remove sequences from the alignment which do not cover this percentage 
      of the HMM
    inputBinding:
      position: 103
      prefix: --min-aligned-percent
  - id: no_candidate_decoy_sequences
    type:
      - 'null'
      - boolean
    doc: Do not include any euk sequences beyond what is already in the current 
      SingleM package
    inputBinding:
      position: 103
      prefix: --no-candidate-decoy-sequences
  - id: no_further_euks
    type:
      - 'null'
      - boolean
    doc: Do not include any euk sequences beyond what is already in the current 
      SingleM package
    inputBinding:
      position: 103
      prefix: --no-further-euks
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 103
      prefix: --quiet
  - id: sequence_prefix
    type:
      - 'null'
      - string
    doc: add a prefix to sequence names
    inputBinding:
      position: 103
      prefix: --sequence-prefix
  - id: window_position
    type:
      - 'null'
      - string
    doc: change window position of output package
    inputBinding:
      position: 103
      prefix: --window-position
outputs:
  - id: output_singlem_package
    type: File
    doc: output package path
    outputBinding:
      glob: $(inputs.output_singlem_package)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
