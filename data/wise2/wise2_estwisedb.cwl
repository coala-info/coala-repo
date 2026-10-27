cwlVersion: v1.2
class: CommandLineTool
baseCommand: estwisedb
label: wise2_estwisedb
doc: 'Search a protein, protein database or HMM library against a DNA (EST) database with frameshift-tolerant alignment.


  Tool homepage: https://www.ebi.ac.uk/~birney/wise2/'
inputs:
  - id: protein_input
    type: File
    doc: Protein input (single protein, protein database, Pfam library or HMM; see the type flags)
    inputBinding:
      position: 1
  - id: dna_input
    type: File
    doc: DNA input (DNA fasta database or a single DNA sequence)
    inputBinding:
      position: 2
  - id: protein
    type:
      - 'null'
      - boolean
    doc: single protein (default)
    inputBinding:
      position: 103
      prefix: -protein
  - id: prodb
    type:
      - 'null'
      - boolean
    doc: protein fasta format db
    inputBinding:
      position: 103
      prefix: -prodb
  - id: pfam
    type:
      - 'null'
      - boolean
    doc: pfam hmm library
    inputBinding:
      position: 103
      prefix: -pfam
  - id: pfam2
    type:
      - 'null'
      - boolean
    doc: pfam style model directory (2.1)
    inputBinding:
      position: 103
      prefix: -pfam2
  - id: hmmer
    type:
      - 'null'
      - boolean
    doc: single hmmer 1.x HMM
    inputBinding:
      position: 103
      prefix: -hmmer
  - id: dnadb
    type:
      - 'null'
      - boolean
    doc: dna fasta database (default)
    inputBinding:
      position: 103
      prefix: -dnadb
  - id: dnas
    type:
      - 'null'
      - boolean
    doc: a single dna fasta sequence
    inputBinding:
      position: 103
      prefix: -dnas
  - id: tfor
    type:
      - 'null'
      - boolean
    doc: search forward strands only
    inputBinding:
      position: 103
      prefix: -tfor
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
  - id: hname
    type:
      - 'null'
      - string
    doc: For single hmms, use this as the name, not filename
    inputBinding:
      position: 103
      prefix: -hname
  - id: init
    type:
      - 'null'
      - string
    doc: start-end policy [default/global/local/wing]
    inputBinding:
      position: 103
      prefix: -init
  - id: codon
    type:
      - 'null'
      - File
    doc: Codon file
    inputBinding:
      position: 103
      prefix: -codon
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
  - id: flati
    type:
      - 'null'
      - boolean
    doc: Flat insert probabilities
    inputBinding:
      position: 103
      prefix: -flati
  - id: alg
    type:
      - 'null'
      - string
    doc: Algorithm used for searching [333/312] (default 312)
    inputBinding:
      position: 103
      prefix: -alg
  - id: aalg
    type:
      - 'null'
      - string
    doc: Algorithm used for alignment [312/333/333L] (default 333)
    inputBinding:
      position: 103
      prefix: -aalg
  - id: cut
    type:
      - 'null'
      - float
    doc: Bits cutoff for reporting in search algorithm (default 20.00)
    inputBinding:
      position: 103
      prefix: -cut
  - id: ecut
    type:
      - 'null'
      - float
    doc: Evalue cutoff for single protein vs DNA searches
    inputBinding:
      position: 103
      prefix: -ecut
  - id: aln
    type:
      - 'null'
      - int
    doc: Max number of alignments (even if above cut) (default 50)
    inputBinding:
      position: 103
      prefix: -aln
  - id: nohis
    type:
      - 'null'
      - boolean
    doc: Don't show histogram on single protein/hmm vs DNA search
    inputBinding:
      position: 103
      prefix: -nohis
  - id: report
    type:
      - 'null'
      - int
    doc: Issue a report every x comparisons (default 0)
    inputBinding:
      position: 103
      prefix: -report
  - id: pep
    type:
      - 'null'
      - boolean
    doc: show protein translation, splicing frameshifts
    inputBinding:
      position: 103
      prefix: -pep
  - id: mul
    type:
      - 'null'
      - boolean
    doc: protein mul format alignments [only for one HMM vs DNA db]
    inputBinding:
      position: 103
      prefix: -mul
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
stdout: wise2_estwisedb.out
