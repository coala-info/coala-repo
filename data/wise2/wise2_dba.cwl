cwlVersion: v1.2
class: CommandLineTool
baseCommand: dba
label: wise2_dba
doc: 'DNA block aligner: align two DNA sequences with conserved blocks (for example promoters).


  Tool homepage: https://www.ebi.ac.uk/~birney/wise2/'
inputs:
  - id: seq1
    type: File
    doc: First DNA sequence in fasta format
    inputBinding:
      position: 200
  - id: seq2
    type: File
    doc: Second DNA sequence in fasta format
    inputBinding:
      position: 201
  - id: matchA
    type:
      - 'null'
      - float
    doc: match level A (default 0.65)
    inputBinding:
      position: 103
      prefix: -matchA
  - id: matchB
    type:
      - 'null'
      - float
    doc: match level B (default 0.75)
    inputBinding:
      position: 103
      prefix: -matchB
  - id: matchC
    type:
      - 'null'
      - float
    doc: match level C (default 0.85)
    inputBinding:
      position: 103
      prefix: -matchC
  - id: matchD
    type:
      - 'null'
      - float
    doc: match level D (default 0.95)
    inputBinding:
      position: 103
      prefix: -matchD
  - id: gapA
    type:
      - 'null'
      - float
    doc: (big only) Gap probability for A (default 0.1)
    inputBinding:
      position: 103
      prefix: -gapA
  - id: gapAA
    type:
      - 'null'
      - float
    doc: (big only) Gap probability for AA (default 0.1)
    inputBinding:
      position: 103
      prefix: -gapAA
  - id: gap
    type:
      - 'null'
      - float
    doc: gap probability (default 0.05)
    inputBinding:
      position: 103
      prefix: -gap
  - id: blockopen
    type:
      - 'null'
      - float
    doc: block open probability (default 0.01)
    inputBinding:
      position: 103
      prefix: -blockopen
  - id: umatch
    type:
      - 'null'
      - float
    doc: unmatched gap probability (default 0.99)
    inputBinding:
      position: 103
      prefix: -umatch
  - id: single
    type:
      - 'null'
      - boolean
    doc: use only one match level, set with -matchA
    inputBinding:
      position: 103
      prefix: -single
  - id: nomatchn
    type:
      - 'null'
      - boolean
    doc: do not match N to any base
    inputBinding:
      position: 103
      prefix: -nomatchn
  - id: align
    type:
      - 'null'
      - boolean
    doc: show alignment for computer parsing
    inputBinding:
      position: 103
      prefix: -align
  - id: anchor
    type:
      - 'null'
      - boolean
    doc: show anchored alignment to first sequence
    inputBinding:
      position: 103
      prefix: -anchor
  - id: pretty
    type:
      - 'null'
      - boolean
    doc: show alignment for ASCII viewing
    inputBinding:
      position: 103
      prefix: -pretty
  - id: pff
    type:
      - 'null'
      - boolean
    doc: show phylogenetic footprinting format output (gapped fasta)
    inputBinding:
      position: 103
      prefix: -pff
  - id: label
    type:
      - 'null'
      - boolean
    doc: show label alignment
    inputBinding:
      position: 103
      prefix: -label
  - id: slim
    type:
      - 'null'
      - boolean
    doc: use slim DBA alignment
    inputBinding:
      position: 103
      prefix: -slim
  - id: big
    type:
      - 'null'
      - boolean
    doc: use big DBA alignment with AA block
    inputBinding:
      position: 103
      prefix: -big
  - id: params
    type:
      - 'null'
      - boolean
    doc: print parameters
    inputBinding:
      position: 103
      prefix: -params
  - id: dymem
    type:
      - 'null'
      - string
    doc: memory style [default/linear/explicit]
    inputBinding:
      position: 103
      prefix: -dymem
  - id: kbyte
    type:
      - 'null'
      - int
    doc: memory amount to use (default 4000)
    inputBinding:
      position: 103
      prefix: -kbyte
  - id: dycache
    type:
      - 'null'
      - boolean
    doc: implicitly cache dy matrix usage (default yes)
    inputBinding:
      position: 103
      prefix: -dycache
  - id: nodycache
    type:
      - 'null'
      - boolean
    doc: do not cache dy matrix usage
    inputBinding:
      position: 103
      prefix: -nodycache
  - id: dydebug
    type:
      - 'null'
      - boolean
    doc: drop into dynamite dp matrix debugger
    inputBinding:
      position: 103
      prefix: -dydebug
  - id: paldebug
    type:
      - 'null'
      - boolean
    doc: print PackAln after debugger run if used
    inputBinding:
      position: 103
      prefix: -paldebug
  - id: silent
    type:
      - 'null'
      - boolean
    doc: No messages on stderr
    inputBinding:
      position: 103
      prefix: -silent
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No report/info on stderr
    inputBinding:
      position: 103
      prefix: -quiet
  - id: erroroffstd
    type:
      - 'null'
      - boolean
    doc: No warning messages to stderr
    inputBinding:
      position: 103
      prefix: -erroroffstd
  - id: errorlog
    type:
      - 'null'
      - string
    doc: Log warning messages to this file
    inputBinding:
      position: 103
      prefix: -errorlog
  - id: errorstyle
    type:
      - 'null'
      - string
    doc: style of error reporting [server/program] (default program)
    inputBinding:
      position: 103
      prefix: -errorstyle
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: errorlog_file
    type:
      - 'null'
      - File
    doc: Warning log written by -errorlog
    outputBinding:
      glob: $(inputs.errorlog)
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: WISECONFIGDIR
        envValue: /usr/local/share/wise2/wisecfg
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wise2:2.4.1--h08bb679_0
stdout: wise2_dba.out
