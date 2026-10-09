cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cmemit
label: infernal_cmemit
doc: "sample sequences from a covariance model\n\nTool homepage: http://eddylab.org/infernal"
inputs:
  - id: cmfile
    type: File
    doc: 'Covariance model file'
    inputBinding:
      position: 200
  - id: outfile
    type:
      - 'null'
      - string
    doc: 'send sequence output to file <f>, not stdout'
    inputBinding:
      position: 101
      prefix: -o
  - id: number
    type:
      - 'null'
      - int
    doc: 'generate <n> sequences [10]'
    inputBinding:
      position: 101
      prefix: -N
  - id: unaligned
    type:
      - 'null'
      - boolean
    doc: 'write generated sequences as unaligned FASTA [default]'
    inputBinding:
      position: 101
      prefix: -u
  - id: alignment
    type:
      - 'null'
      - boolean
    doc: 'write generated sequences as an alignment'
    inputBinding:
      position: 101
      prefix: -a
  - id: consensus
    type:
      - 'null'
      - boolean
    doc: 'generate a single "consensus" sequence only'
    inputBinding:
      position: 101
      prefix: -c
  - id: embed_len
    type:
      - 'null'
      - int
    doc: 'embed emitted sequences within larger random sequences of length <n>'
    inputBinding:
      position: 101
      prefix: -e
  - id: local
    type:
      - 'null'
      - boolean
    doc: 'local; emit from a locally configured model [default: global]'
    inputBinding:
      position: 101
      prefix: -l
  - id: u5p
    type:
      - 'null'
      - boolean
    doc: 'truncate unaligned sequences 5'', choosing a random start posn'
    inputBinding:
      position: 101
      prefix: --u5p
  - id: u3p
    type:
      - 'null'
      - boolean
    doc: 'truncate unaligned sequences 3'', choosing a random end posn'
    inputBinding:
      position: 101
      prefix: --u3p
  - id: a5p
    type:
      - 'null'
      - int
    doc: 'truncate aln 5'', start at match column <n> (use 0 for random posn)'
    inputBinding:
      position: 101
      prefix: --a5p
  - id: a3p
    type:
      - 'null'
      - int
    doc: 'truncate aln 3'', end at match column <n> (use 0 for random posn)'
    inputBinding:
      position: 101
      prefix: --a3p
  - id: seed
    type:
      - 'null'
      - int
    doc: 'set RNG seed to <n> [default: one-time arbitrary seed] [0]'
    inputBinding:
      position: 101
      prefix: --seed
  - id: iid
    type:
      - 'null'
      - boolean
    doc: 'with -e, generate larger sequences as 25% ACGU (iid)'
    inputBinding:
      position: 101
      prefix: --iid
  - id: rna
    type:
      - 'null'
      - boolean
    doc: 'output as RNA sequence data [default]'
    inputBinding:
      position: 101
      prefix: --rna
  - id: dna
    type:
      - 'null'
      - boolean
    doc: 'output as DNA sequence data'
    inputBinding:
      position: 101
      prefix: --dna
  - id: idx
    type:
      - 'null'
      - int
    doc: 'start sequence numbering at <n> [1]'
    inputBinding:
      position: 101
      prefix: --idx
  - id: outformat
    type:
      - 'null'
      - string
    doc: 'w/-a output alignment in format <s> [Stockholm]'
    inputBinding:
      position: 101
      prefix: --outformat
  - id: tfile
    type:
      - 'null'
      - string
    doc: 'dump parsetrees to file <f>'
    inputBinding:
      position: 101
      prefix: --tfile
  - id: exp
    type:
      - 'null'
      - float
    doc: 'exponentiate CM probabilities by <x> before emitting'
    inputBinding:
      position: 101
      prefix: --exp
  - id: hmmonly
    type:
      - 'null'
      - boolean
    doc: 'emit from filter HMM, not from CM'
    inputBinding:
      position: 101
      prefix: --hmmonly
  - id: nohmmonly
    type:
      - 'null'
      - boolean
    doc: 'always emit from CM, even for models with 0 basepairs'
    inputBinding:
      position: 101
      prefix: --nohmmonly
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_outfile
    type:
      - 'null'
      - File
    doc: 'send sequence output to file <f>, not stdout'
    outputBinding:
      glob: $(inputs.outfile)
  - id: output_tfile
    type:
      - 'null'
      - File
    doc: 'dump parsetrees to file <f>'
    outputBinding:
      glob: $(inputs.tfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
stdout: infernal_cmemit.out
