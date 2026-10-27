cwlVersion: v1.2
class: CommandLineTool
baseCommand: pswdb
label: wise2_pswdb
doc: 'Smith-Waterman search of a protein query database against a target protein database.


  Tool homepage: https://www.ebi.ac.uk/~birney/wise2/'
inputs:
  - id: query_db
    type: File
    doc: Query sequences in fasta format
    inputBinding:
      position: 1
  - id: target_db
    type: File
    doc: Target sequence database in fasta format
    inputBinding:
      position: 2
  - id: g
    type:
      - 'null'
      - int
    doc: gap penalty (default 12)
    inputBinding:
      position: 103
      prefix: -g
  - id: e
    type:
      - 'null'
      - int
    doc: extension penalty (default 2)
    inputBinding:
      position: 103
      prefix: -e
  - id: m
    type:
      - 'null'
      - string
    doc: comparison matrix (default BLOSUM62.bla)
    inputBinding:
      position: 103
      prefix: -m
  - id: abc
    type:
      - 'null'
      - boolean
    doc: use the abc model
    inputBinding:
      position: 103
      prefix: -abc
  - id: a
    type:
      - 'null'
      - int
    doc: a penalty for the abc model (default 120)
    inputBinding:
      position: 103
      prefix: -a
  - id: b
    type:
      - 'null'
      - int
    doc: b penalty for the abc model (default 10)
    inputBinding:
      position: 103
      prefix: -b
  - id: c
    type:
      - 'null'
      - int
    doc: c penalty for the abc model (default 3)
    inputBinding:
      position: 103
      prefix: -c
  - id: pba
    type:
      - 'null'
      - boolean
    doc: use the pba model
    inputBinding:
      position: 103
      prefix: -pba
  - id: max_desc
    type:
      - 'null'
      - int
    doc: Number of one line descriptions (default 500)
    inputBinding:
      position: 103
      prefix: -max_desc
  - id: max_aln
    type:
      - 'null'
      - int
    doc: Number of alignments to show (default 50)
    inputBinding:
      position: 103
      prefix: -max_aln
  - id: cut
    type:
      - 'null'
      - int
    doc: Search cutoff score (default 40)
    inputBinding:
      position: 103
      prefix: -cut
  - id: ids
    type:
      - 'null'
      - boolean
    doc: Output seq ids with alignments
    inputBinding:
      position: 103
      prefix: -ids
  - id: nohis
    type:
      - 'null'
      - boolean
    doc: do not fit histogram
    inputBinding:
      position: 103
      prefix: -nohis
  - id: serial
    type:
      - 'null'
      - boolean
    doc: use serial code (single processor)
    inputBinding:
      position: 103
      prefix: -serial
  - id: pthread
    type:
      - 'null'
      - boolean
    doc: use pthread code (SMP box)
    inputBinding:
      position: 103
      prefix: -pthread
  - id: pthr_no
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 103
      prefix: -pthr_no
  - id: mpi
    type:
      - 'null'
      - boolean
    doc: use MPI code (distributed memory system)
    inputBinding:
      position: 103
      prefix: -mpi
  - id: pvm
    type:
      - 'null'
      - boolean
    doc: use parallel virtual machine search system
    inputBinding:
      position: 103
      prefix: -pvm
  - id: dbtrace
    type:
      - 'null'
      - int
    doc: Trace level of the database code (for debugging only)
    inputBinding:
      position: 103
      prefix: -dbtrace
  - id: sroutine
    type:
      - 'null'
      - string
    doc: Search type routine [exact/kbest/forward]
    inputBinding:
      position: 103
      prefix: -sroutine
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
stdout: wise2_pswdb.out
