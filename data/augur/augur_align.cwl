cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur align
label: augur_align
doc: "Align multiple nucleotide sequences from FASTA. The \"N\" character is treated
  as missing or ambiguous sites, so aligning amino acid sequences is not supported.\n\
  \nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: sequences
    type:
      type: array
      items: File
    doc: sequences to align
    default: None
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Produce extra files (e.g. pre- and post-aligner files) which can help 
      with debugging poor alignments.
    default: false
    inputBinding:
      position: 102
      prefix: --debug
  - id: existing_alignment
    type:
      - 'null'
      - File
    doc: An existing alignment to which the sequences will be added. The ouput 
      alignment will be the same length as this existing alignment.
    default: false
    inputBinding:
      position: 102
      prefix: --existing-alignment
  - id: fill_gaps
    type:
      - 'null'
      - boolean
    doc: If gaps represent missing data rather than true indels, replace by N 
      after aligning.
    default: false
    inputBinding:
      position: 102
      prefix: --fill-gaps
  - id: method
    type:
      - 'null'
      - string
    doc: alignment program to use
    default: mafft
    inputBinding:
      position: 102
      prefix: --method
  - id: nthreads
    type:
      - 'null'
      - string
    doc: number of threads to use; specifying the value 'auto' will cause the 
      number of available CPU cores on your system, if determinable, to be used
    default: '1'
    inputBinding:
      position: 102
      prefix: --nthreads
  - id: reference_name
    type:
      - 'null'
      - string
    doc: strip insertions relative to reference sequence; use if the reference 
      is already in the input sequences
    default: None
    inputBinding:
      position: 102
      prefix: --reference-name
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Add this reference sequence to the dataset & strip insertions relative 
      to this. Use if the reference is NOT already in the input sequences
    default: None
    inputBinding:
      position: 102
      prefix: --reference-sequence
  - id: remove_reference
    type:
      - 'null'
      - boolean
    doc: remove reference sequence from the alignment
    default: false
    inputBinding:
      position: 102
      prefix: --remove-reference
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
