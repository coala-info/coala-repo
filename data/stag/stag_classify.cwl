cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- stag
- classify
label: stag_classify
doc: 'Taxonomically annotate a gene with a STAG database.


  Tool homepage: https://github.com/zellerlab/stag'
inputs:
- id: database
  type: File
  doc: database created with create_db or train
  inputBinding:
    position: 1
    prefix: -d
- id: seq_file
  type:
  - 'null'
  - File
  doc: sequences to taxonomically annotate (fasta format)
  inputBinding:
    position: 1
    prefix: -i
- id: aligned_seqs
  type:
  - 'null'
  - File
  doc: aligned sequences, can be provided instead of -i
  inputBinding:
    position: 1
    prefix: -s
- id: protein_seqs
  type:
  - 'null'
  - File
  doc: protein sequences, corresponding to -i
  inputBinding:
    position: 1
    prefix: -p
- id: save_alignment_file
  type:
  - 'null'
  - string
  doc: save intermediate alignment file
  inputBinding:
    position: 1
    prefix: -S
- id: output_file
  type:
  - 'null'
  - string
  doc: output file name [stdout]
  inputBinding:
    position: 1
    prefix: -o
- id: long_output
  type:
  - 'null'
  - boolean
  doc: long output (with more information about the classification)
  inputBinding:
    position: 1
    prefix: -l
- id: features_threshold
  type:
  - 'null'
  - int
  doc: threshold for the number of features per sequence (percentage) [0]
  inputBinding:
    position: 1
    prefix: -m
- id: verbose_level
  type:
  - 'null'
  - int
  doc: 'verbose level: 1=error, 2=warning, 3=message, 4+=debugging [3]'
  inputBinding:
    position: 1
    prefix: -v
outputs:
- id: save_alignment_file_result
  type:
  - 'null'
  - File
  doc: save intermediate alignment file
  outputBinding:
    glob: $(inputs.save_alignment_file)
- id: output_file_result
  type:
  - 'null'
  - File
  doc: output file name [stdout]
  outputBinding:
    glob: $(inputs.output_file)
- id: stdout
  type: stdout
  doc: Standard output (used when no output file is given)
stdout: stag_classify.stdout.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/stag:0.8.3--pyhdfd78af_1
