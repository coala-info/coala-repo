cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmalign
label: hmmer_hmmalign
doc: "align sequences to a profile HMM\n\nTool homepage: http://hmmer.org/"
inputs:
  - id: hmmfile
    type: File
    doc: Input profile HMM file
    inputBinding:
      position: 1
  - id: seqfile
    type: File
    doc: Input sequence file
    inputBinding:
      position: 2
  - id: amino
    type:
      - 'null'
      - boolean
    doc: 'assert <seqfile>, <hmmfile> both protein: no autodetection'
    inputBinding:
      position: 103
      prefix: --amino
  - id: dna
    type:
      - 'null'
      - boolean
    doc: 'assert <seqfile>, <hmmfile> both DNA: no autodetection'
    inputBinding:
      position: 103
      prefix: --dna
  - id: informat
    type:
      - 'null'
      - string
    doc: 'assert <seqfile> is in format <s>: no autodetection'
    inputBinding:
      position: 103
      prefix: --informat
  - id: mapali
    type:
      - 'null'
      - File
    doc: include alignment in file <f> (same ali that HMM came from)
    inputBinding:
      position: 103
      prefix: --mapali
  - id: outformat
    type:
      - 'null'
      - string
    doc: output alignment in format <s>
    inputBinding:
      position: 103
      prefix: --outformat
  - id: rna
    type:
      - 'null'
      - boolean
    doc: 'assert <seqfile>, <hmmfile> both RNA: no autodetection'
    inputBinding:
      position: 103
      prefix: --rna
  - id: trim
    type:
      - 'null'
      - boolean
    doc: trim terminal tails of nonaligned residues from alignment
    inputBinding:
      position: 103
      prefix: --trim
outputs:
  - id: output_alignment
    type:
      - 'null'
      - File
    doc: output alignment to file <f>, not stdout
    outputBinding:
      glob: $(inputs.output_alignment)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
