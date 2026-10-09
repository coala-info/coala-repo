cwlVersion: v1.2
class: CommandLineTool
baseCommand: mdasim
label: mdasim
doc: "mdasim\n\nTool homepage: https://sourceforge.net/projects/mdasim/"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: normalized number of primers attached in each step
    inputBinding:
      position: 101
      prefix: --alpha=
      separate: false
  - id: attach_num
    type:
      - 'null'
      - string
    doc: number of primers attached per single strand of reference sequence in 
      the first step. It can be any positive number. (overrides -A; alpha = 
      attachNum / (input reference length * primerNo))
    inputBinding:
      position: 101
      prefix: --attachNum=
      separate: false
  - id: coverage
    type:
      - 'null'
      - int
    doc: expected average coverage
    inputBinding:
      position: 101
      prefix: --coverage=
      separate: false
  - id: frg_length
    type:
      - 'null'
      - int
    doc: average number of synthesized bases per phi29
    inputBinding:
      position: 101
      prefix: --frgLngth=
      separate: false
  - id: input_fasta
    type: File
    doc: file name of reference DNA sequence
    inputBinding:
      position: 101
      prefix: --input=
      separate: false
  - id: log_file
    type:
      - 'null'
      - string
    doc: file name for a log file of all single nucleotide errors that happen 
      during amplification
    inputBinding:
      position: 101
      prefix: --log=
      separate: false
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: chance of a nucleotide substitution
    inputBinding:
      position: 101
      prefix: --mutationrate=
      separate: false
  - id: output_fragments
    type:
      - 'null'
      - boolean
    doc: writes the lists of fragments and primer positions at the end of 
      simulation in two txt files suffixed by Fragments.txt and 
      PrimerPositions.txt
    inputBinding:
      position: 101
      prefix: --outputfragments
  - id: primer_no
    type:
      - 'null'
      - string
    doc: average number of initial available primers
    inputBinding:
      position: 101
      prefix: --primerNo=
      separate: false
  - id: primers_fasta
    type: File
    doc: file name of input primers in fasta format
    inputBinding:
      position: 101
      prefix: --primers=
      separate: false
  - id: read_length
    type:
      - 'null'
      - int
    doc: minimum length of output amplicons
    inputBinding:
      position: 101
      prefix: --readLength=
      separate: false
  - id: single_strand
    type:
      - 'null'
      - boolean
    doc: Input reference is amplified as a single strand sequence
    inputBinding:
      position: 101
      prefix: --single
  - id: step_size
    type:
      - 'null'
      - int
    doc: number of synthesized bases per phi29 in each step
    inputBinding:
      position: 101
      prefix: --stepSize=
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: extended verbose for debug mode
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_prefix_path
    type: string
    doc: output files prefix, `Amplicons.fasta` will be appended to the prefix (default is out)
    inputBinding:
      position: 102
      prefix: --output=
      separate: false
outputs:
  - id: log_output
    type:
      - 'null'
      - File
    doc: log of all single nucleotide errors that happen during amplification
    outputBinding:
      glob: $(inputs.log_file)
  - id: output_prefix
    type:
      type: array
      items: File
    doc: output files prefix , `Amplicons.fasta` will be appended to the prefix
    outputBinding:
      glob: $(inputs.output_prefix_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mdasim:2.1.1--hf316886_7
