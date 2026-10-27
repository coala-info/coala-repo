cwlVersion: v1.2
class: CommandLineTool
baseCommand: estwise
label: wise2_estwise
doc: 'Compare a protein or HMM against an EST/cDNA sequence (protein-to-EST alignment, allowing frameshifts).


  Tool homepage: https://www.ebi.ac.uk/~birney/wise2/'
inputs:
  - id: protein_file
    type: File
    doc: Protein sequence in fasta format
    inputBinding:
      position: 1
  - id: dna_file
    type: File
    doc: DNA (EST) sequence in fasta format
    inputBinding:
      position: 2
  - id: dna_start
    type:
      - 'null'
      - int
    doc: start position in dna
    inputBinding:
      position: 103
      prefix: -u
  - id: dna_end
    type:
      - 'null'
      - int
    doc: end position in dna
    inputBinding:
      position: 103
      prefix: -v
  - id: trev
    type:
      - 'null'
      - boolean
    doc: reverse complement dna
    inputBinding:
      position: 103
      prefix: -trev
  - id: tfor
    type:
      - 'null'
      - boolean
    doc: use forward strands only
    inputBinding:
      position: 103
      prefix: -tfor
  - id: both
    type:
      - 'null'
      - boolean
    doc: do both strands (default)
    inputBinding:
      position: 103
      prefix: -both
  - id: tabs
    type:
      - 'null'
      - boolean
    doc: Positions reported as absolute to DNA
    inputBinding:
      position: 103
      prefix: -tabs
  - id: protein_start
    type:
      - 'null'
      - int
    doc: start position in protein
    inputBinding:
      position: 103
      prefix: -s
  - id: protein_end
    type:
      - 'null'
      - int
    doc: end position in protein
    inputBinding:
      position: 103
      prefix: -t
  - id: gap
    type:
      - 'null'
      - int
    doc: gap penalty (default 12)
    inputBinding:
      position: 103
      prefix: -gap
  - id: ext
    type:
      - 'null'
      - int
    doc: extension penalty (default 2)
    inputBinding:
      position: 103
      prefix: -ext
  - id: matrix
    type:
      - 'null'
      - string
    doc: Comparison matrix (default BLOSUM62.bla)
    inputBinding:
      position: 103
      prefix: -matrix
  - id: hmmer
    type:
      - 'null'
      - boolean
    doc: Protein file is HMMer file (version 2 compatible)
    inputBinding:
      position: 103
      prefix: -hmmer
  - id: hname
    type:
      - 'null'
      - string
    doc: Name of HMM rather than using the filename
    inputBinding:
      position: 103
      prefix: -hname
  - id: init
    type:
      - 'null'
      - string
    doc: start end policy of HMM/protein match [default/global/local/wing]
    inputBinding:
      position: 103
      prefix: -init
  - id: subs
    type:
      - 'null'
      - float
    doc: Substitution error rate (default 0.01)
    inputBinding:
      position: 103
      prefix: -subs
  - id: indel
    type:
      - 'null'
      - float
    doc: Insertion/deletion error rate (default 0.01)
    inputBinding:
      position: 103
      prefix: -indel
  - id: null_model
    type:
      - 'null'
      - string
    doc: Random Model as synchronous or flat [syn/flat]
    inputBinding:
      position: 103
      prefix: -null
  - id: alln
    type:
      - 'null'
      - float
    doc: Probability of matching a NNN codon (default 1.0)
    inputBinding:
      position: 103
      prefix: -alln
  - id: alg
    type:
      - 'null'
      - string
    doc: Algorithm used [333,333L,312,312L,333F]
    inputBinding:
      position: 103
      prefix: -alg
  - id: pep
    type:
      - 'null'
      - boolean
    doc: show protein translation, splicing frameshifts
    inputBinding:
      position: 103
      prefix: -pep
  - id: pretty
    type:
      - 'null'
      - boolean
    doc: show pretty ascii output
    inputBinding:
      position: 103
      prefix: -pretty
  - id: para
    type:
      - 'null'
      - boolean
    doc: show parameters
    inputBinding:
      position: 103
      prefix: -para
  - id: sum
    type:
      - 'null'
      - boolean
    doc: show summary output
    inputBinding:
      position: 103
      prefix: -sum
  - id: alb
    type:
      - 'null'
      - boolean
    doc: show logical AlnBlock alignment
    inputBinding:
      position: 103
      prefix: -alb
  - id: pal
    type:
      - 'null'
      - boolean
    doc: show raw matrix alignment
    inputBinding:
      position: 103
      prefix: -pal
  - id: block
    type:
      - 'null'
      - int
    doc: Length of main block in pretty output (default 50)
    inputBinding:
      position: 103
      prefix: -block
  - id: divide
    type:
      - 'null'
      - string
    doc: divide string for multiple outputs (default //)
    inputBinding:
      position: 103
      prefix: -divide
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
stdout: wise2_estwise.out
