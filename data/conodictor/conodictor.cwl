cwlVersion: v1.2
class: CommandLineTool
baseCommand: conodictor
label: conodictor
doc: "Improved prediction of conopeptide superfamilies with ConoDictor 2.0\n\nTool
  homepage: https://github.com/koualab/conodictor"
inputs:
  - id: file
    type: File
    doc: Specifies input file.
    inputBinding:
      position: 1
  - id: cpus
    type:
      - 'null'
      - int
    doc: Specify the number of threads.
    inputBinding:
      position: 102
      prefix: --cpus
  - id: create_fasta
    type:
      - 'null'
      - boolean
    doc: Create a fasta file of matched sequences.
    inputBinding:
      position: 102
      prefix: --faa
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Activate debug mode
    inputBinding:
      position: 102
      prefix: --debug
  - id: display_all_sequences
    type:
      - 'null'
      - boolean
    doc: Display sequence without hits in output.
    inputBinding:
      position: 102
      prefix: --all
  - id: filter_signal_proregions
    type:
      - 'null'
      - boolean
    doc: Activate the removal of sequences that matches only the signal and/or 
      proregions.
    inputBinding:
      position: 102
      prefix: --filter
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Force re-use output directory.
    inputBinding:
      position: 102
      prefix: --force
  - id: min_sequence_length
    type:
      - 'null'
      - int
    doc: Set the minimum length of the sequence to be considered as a match
    inputBinding:
      position: 102
      prefix: --mlen
  - id: min_sequence_occurrence
    type:
      - 'null'
      - int
    doc: Minimum sequence occurence of a sequence to be considered
    inputBinding:
      position: 102
      prefix: --ndup
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease program verbosity
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Specify output folder.
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/conodictor:v2.3.1_cv1
