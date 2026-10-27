cwlVersion: v1.2
class: CommandLineTool
baseCommand: genewisedb
label: wise2_genewisedb
doc: 'Search a protein, protein database or HMM library against a DNA database with a gene model (introns and frameshifts).


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
    doc: pfam old style model directory (2.1)
    inputBinding:
      position: 103
      prefix: -pfam2
  - id: hmmer
    type:
      - 'null'
      - boolean
    doc: single hmmer HMM (version 2 compatible)
    inputBinding:
      position: 103
      prefix: -hmmer
  - id: pro_db_start
    type:
      - 'null'
      - int
    doc: start position in protein/hmm database
    inputBinding:
      position: 103
      prefix: -pro_db_start
  - id: pro_db_end
    type:
      - 'null'
      - int
    doc: end position in protein/hmm database
    inputBinding:
      position: 103
      prefix: -pro_db_end
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
  - id: dna_db_start
    type:
      - 'null'
      - int
    doc: start position in dna database
    inputBinding:
      position: 103
      prefix: -dna_db_start
  - id: dna_db_end
    type:
      - 'null'
      - int
    doc: end position in dna database
    inputBinding:
      position: 103
      prefix: -dna_db_end
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
    doc: start-end policy [default/global/local/wing/endbias]
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
  - id: gene
    type:
      - 'null'
      - File
    doc: Gene parameter file (default human.gf)
    inputBinding:
      position: 103
      prefix: -gene
  - id: subs
    type:
      - 'null'
      - float
    doc: Substitution error rate (default 1e-05)
    inputBinding:
      position: 103
      prefix: -subs
  - id: indel
    type:
      - 'null'
      - float
    doc: Insertion/deletion error rate (default 1e-05)
    inputBinding:
      position: 103
      prefix: -indel
  - id: cfreq
    type:
      - 'null'
      - string
    doc: Using codon bias or not [model/flat] (default flat)
    inputBinding:
      position: 103
      prefix: -cfreq
  - id: splice
    type:
      - 'null'
      - string
    doc: Using splice model or GT/AG [model/flat] (default model)
    inputBinding:
      position: 103
      prefix: -splice
  - id: intron
    type:
      - 'null'
      - string
    doc: Use tied model for introns [model/tied] (default tied)
    inputBinding:
      position: 103
      prefix: -intron
  - id: null_model
    type:
      - 'null'
      - string
    doc: Random Model as synchronous or flat [syn/flat]
    inputBinding:
      position: 103
      prefix: -null
  - id: insert
    type:
      - 'null'
      - string
    doc: Use protein insert model [model/flat] (default flat)
    inputBinding:
      position: 103
      prefix: -insert
  - id: alg
    type:
      - 'null'
      - string
    doc: Algorithm used for searching [623/2193] (default 623)
    inputBinding:
      position: 103
      prefix: -alg
  - id: aalg
    type:
      - 'null'
      - string
    doc: Algorithm used for alignment [623/623L/2193/2193L] (default 623/623L)
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
  - id: alln
    type:
      - 'null'
      - float
    doc: Probability of matching a NNN codon (only for single HMM vs DNAdb) (default 0.9)
    inputBinding:
      position: 103
      prefix: -alln
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
  - id: genes
    type:
      - 'null'
      - boolean
    doc: show gene structure
    inputBinding:
      position: 103
      prefix: -genes
  - id: cdna
    type:
      - 'null'
      - boolean
    doc: show cDNA
    inputBinding:
      position: 103
      prefix: -cdna
  - id: trans
    type:
      - 'null'
      - boolean
    doc: show protein translation
    inputBinding:
      position: 103
      prefix: -trans
  - id: ace
    type:
      - 'null'
      - boolean
    doc: ace file gene structure
    inputBinding:
      position: 103
      prefix: -ace
  - id: gff
    type:
      - 'null'
      - boolean
    doc: Gene Feature Format file
    inputBinding:
      position: 103
      prefix: -gff
  - id: gener
    type:
      - 'null'
      - boolean
    doc: raw gene structure
    inputBinding:
      position: 103
      prefix: -gener
  - id: pseudo
    type:
      - 'null'
      - boolean
    doc: Mark genes with frameshifts as pseudogenes
    inputBinding:
      position: 103
      prefix: -pseudo
  - id: ctrans
    type:
      - 'null'
      - boolean
    doc: provide all translations
    inputBinding:
      position: 103
      prefix: -ctrans
  - id: ccdna
    type:
      - 'null'
      - boolean
    doc: provide all cdna
    inputBinding:
      position: 103
      prefix: -ccdna
  - id: cgene
    type:
      - 'null'
      - boolean
    doc: provide all gene structures
    inputBinding:
      position: 103
      prefix: -cgene
  - id: cace
    type:
      - 'null'
      - boolean
    doc: provide all gene structures in ace format
    inputBinding:
      position: 103
      prefix: -cace
  - id: cdiana
    type:
      - 'null'
      - boolean
    doc: provide all gene structures in diana EMBL FT format
    inputBinding:
      position: 103
      prefix: -cdiana
  - id: cembl
    type:
      - 'null'
      - boolean
    doc: provide all gene structures in EMBL FT format
    inputBinding:
      position: 103
      prefix: -cembl
  - id: caceh
    type:
      - 'null'
      - boolean
    doc: provide all gene structures in halfwise type ace format
    inputBinding:
      position: 103
      prefix: -caceh
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
stdout: wise2_genewisedb.out
