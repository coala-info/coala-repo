cwlVersion: v1.2
class: CommandLineTool
baseCommand: sourmash sketch dna
label: bactopia-sketcher_sketch
doc: "The 'sketch dna' command reads in DNA sequences and outputs DNA sketches.\n\n\
  Tool homepage: https://bactopia.github.io/"
inputs:
  - id: filenames
    type:
      type: array
      items: File
    doc: file(s) of sequences
    inputBinding:
      position: 1
  - id: check_sequence
    type:
      - 'null'
      - boolean
    doc: complain if input sequence is invalid DNA
    inputBinding:
      position: 102
      prefix: --check-sequence
  - id: force
    type:
      - 'null'
      - boolean
    doc: recompute signatures even if the file exists
    inputBinding:
      position: 102
      prefix: --force
  - id: from_file
    type:
      - 'null'
      - File
    doc: a text file containing a list of sequence files to load
    inputBinding:
      position: 102
      prefix: --from-file
  - id: license
    type:
      - 'null'
      - string
    doc: signature license. Currently only CC0 is supported.
    inputBinding:
      position: 102
      prefix: --license
  - id: merge_name
    type:
      - 'null'
      - File
    doc: merge all input files into one signature file with the specified name
    inputBinding:
      position: 102
      prefix: --merge
  - id: name_from_first
    type:
      - 'null'
      - boolean
    doc: name the signature generated from each file after the first record in 
      the file
    inputBinding:
      position: 102
      prefix: --name-from-first
  - id: param_string
    type:
      - 'null'
      - type: array
        items: string
    doc: signature parameters to use.
    inputBinding:
      position: 102
      prefix: --param-string
  - id: randomize
    type:
      - 'null'
      - boolean
    doc: shuffle the list of input filenames randomly
    inputBinding:
      position: 102
      prefix: --randomize
  - id: singleton
    type:
      - 'null'
      - boolean
    doc: compute a signature for each sequence record individually
    inputBinding:
      position: 102
      prefix: --singleton
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output computed signatures to this file
    outputBinding:
      glob: $(inputs.output)
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output computed signatures to this directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia-sketcher:1.0.2--hdfd78af_0
