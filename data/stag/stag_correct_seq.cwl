cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- stag
- correct_seq
label: stag_correct_seq
doc: 'Correct sequences that are in the wrong orientation.


  Tool homepage: https://github.com/zellerlab/stag'
inputs:
- id: fasta_seqs
  type: File
  doc: sequences to be aligned (fasta format)
  inputBinding:
    position: 1
    prefix: -i
- id: hmmfile
  type: File
  doc: hmmfile or cmfile to use as template for the alignment
  inputBinding:
    position: 1
    prefix: -a
- id: output_file
  type:
  - 'null'
  - string
  doc: output file name [stdout]
  inputBinding:
    position: 1
    prefix: -o
- id: use_cmfile
  type:
  - 'null'
  - boolean
  doc: set if you are using a cmfile
  inputBinding:
    position: 1
    prefix: -c
- id: features_threshold
  type:
  - 'null'
  - int
  doc: threshold for the number of features per sequence (percentage) [5]
  inputBinding:
    position: 1
    prefix: -m
- id: threads
  type:
  - 'null'
  - int
  doc: number of threads [1]
  inputBinding:
    position: 1
    prefix: -t
- id: verbose_level
  type:
  - 'null'
  - int
  doc: 'verbose level: 1=error, 2=warning, 3=message, 4+=debugging [3]'
  inputBinding:
    position: 1
    prefix: -v
outputs:
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
stdout: stag_correct_seq.stdout.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/stag:0.8.3--pyhdfd78af_1
