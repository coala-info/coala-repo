cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnal
label: wise2_dnal
doc: 'Align two DNA sequences with a simple score model (match, mismatch, gap, extension).


  Tool homepage: https://www.ebi.ac.uk/~birney/wise2/'
inputs:
  - id: dna_file1
    type: File
    doc: First DNA sequence in fasta format
    inputBinding:
      position: 1
  - id: dna_file2
    type: File
    doc: Second DNA sequence in fasta format
    inputBinding:
      position: 2
  - id: match
    type:
      - 'null'
      - int
    doc: Match score (default 4)
    inputBinding:
      position: 103
      prefix: -match
  - id: mis
    type:
      - 'null'
      - int
    doc: MisMatch score (default -1)
    inputBinding:
      position: 103
      prefix: -mis
  - id: gap
    type:
      - 'null'
      - int
    doc: Gap penalty (default 5)
    inputBinding:
      position: 103
      prefix: -gap
  - id: ext
    type:
      - 'null'
      - int
    doc: Gap extension penalty (default 1)
    inputBinding:
      position: 103
      prefix: -ext
  - id: bound
    type:
      - 'null'
      - string
    doc: Start/End policy [local/global/edge]
    inputBinding:
      position: 103
      prefix: -bound
  - id: pretty
    type:
      - 'null'
      - boolean
    doc: show pretty alignment (default yes)
    inputBinding:
      position: 103
      prefix: -pretty
  - id: nopretty
    type:
      - 'null'
      - boolean
    doc: do not show pretty alignment
    inputBinding:
      position: 103
      prefix: -nopretty
  - id: alb
    type:
      - 'null'
      - boolean
    doc: show alb alignment
    inputBinding:
      position: 103
      prefix: -alb
  - id: noalb
    type:
      - 'null'
      - boolean
    doc: do not show alb alignment (default)
    inputBinding:
      position: 103
      prefix: -noalb
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
stdout: wise2_dnal.out
