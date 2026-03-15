cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmemit
label: hmmer_hmmemit
doc: sample sequence(s) from a profile HMM
inputs:
  - id: hmmfile
    type: File
    doc: Input HMM file
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: send sequence output to file <f>, not stdout
    inputBinding:
      position: 102
      prefix: -o
  - id: num_seqs
    type:
      - 'null'
      - int
    doc: number of seqs to sample
    inputBinding:
      position: 102
      prefix: -N
  - id: emit_alignment
    type:
      - 'null'
      - boolean
    doc: emit alignment
    inputBinding:
      position: 102
      prefix: -a
  - id: emit_simple_consensus
    type:
      - 'null'
      - boolean
    doc: emit simple majority-rule consensus sequence
    inputBinding:
      position: 102
      prefix: -c
  - id: emit_fancy_consensus
    type:
      - 'null'
      - boolean
    doc: emit fancier consensus sequence (req's --minl, --minu)
    inputBinding:
      position: 102
      prefix: -C
  - id: sample_from_profile
    type:
      - 'null'
      - boolean
    doc: sample sequences from profile, not core model
    inputBinding:
      position: 102
      prefix: -p
  - id: profile_length
    type:
      - 'null'
      - int
    doc: set expected length from profile to <n>
    inputBinding:
      position: 102
      prefix: -L
  - id: local_mode
    type:
      - 'null'
      - boolean
    doc: configure profile in multihit local mode
    inputBinding:
      position: 102
      prefix: --local
  - id: unilocal_mode
    type:
      - 'null'
      - boolean
    doc: configure profile in unilocal mode
    inputBinding:
      position: 102
      prefix: --unilocal
  - id: glocal_mode
    type:
      - 'null'
      - boolean
    doc: configure profile in multihit glocal mode
    inputBinding:
      position: 102
      prefix: --glocal
  - id: uniglocal_mode
    type:
      - 'null'
      - boolean
    doc: configure profile in unihit glocal mode
    inputBinding:
      position: 102
      prefix: --uniglocal
  - id: min_lower
    type:
      - 'null'
      - float
    doc: show consensus as 'any' (X/N) unless >= this fraction
    inputBinding:
      position: 102
      prefix: --minl
  - id: min_upper
    type:
      - 'null'
      - float
    doc: show consensus as upper case if >= this fraction
    inputBinding:
      position: 102
      prefix: --minu
  - id: seed
    type:
      - 'null'
      - int
    doc: set RNG seed to <n>
    inputBinding:
      position: 102
      prefix: --seed
outputs:
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: send sequence output to file <f>, not stdout
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
s:url: http://hmmer.org/
$namespaces:
  s: https://schema.org/
