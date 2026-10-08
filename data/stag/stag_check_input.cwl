cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- stag
- check_input
label: stag_check_input
doc: 'Check the input files for the train command.


  Tool homepage: https://github.com/zellerlab/stag'
inputs:
- id: fasta_seqs
  type: File
  doc: sequences to be aligned (fasta format)
  inputBinding:
    position: 1
    prefix: -i
- id: protein_seqs
  type:
  - 'null'
  - File
  doc: protein sequences, corresponding to -i
  inputBinding:
    position: 1
    prefix: -p
- id: hmmfile
  type: File
  doc: hmmfile or cmfile to used as template for the alignment
  inputBinding:
    position: 1
    prefix: -a
- id: use_cmfile
  type:
  - 'null'
  - boolean
  doc: set if you are using a cmfile
  inputBinding:
    position: 1
    prefix: -c
- id: taxonomy_file
  type: File
  doc: taxonomy file (tab separated)
  inputBinding:
    position: 1
    prefix: -x
- id: warnings_file
  type:
  - 'null'
  - string
  doc: save warning messages to a file
  inputBinding:
    position: 1
    prefix: -w
- id: verbose_level
  type:
  - 'null'
  - int
  doc: 'verbose level: 1=error, 2=warning, 3=message, 4+=debugging [3]'
  inputBinding:
    position: 1
    prefix: -v
outputs:
- id: warnings_file_result
  type:
  - 'null'
  - File
  doc: save warning messages to a file
  outputBinding:
    glob: $(inputs.warnings_file)
- id: log
  type: stderr
  doc: Standard error (check messages)
stderr: stag_check_input.log.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/stag:0.8.3--pyhdfd78af_1
