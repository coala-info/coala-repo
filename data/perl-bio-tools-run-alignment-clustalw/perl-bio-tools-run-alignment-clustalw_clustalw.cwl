cwlVersion: v1.2
class: CommandLineTool
baseCommand: clustalw
label: perl-bio-tools-run-alignment-clustalw_clustalw
doc: "CLUSTAL 2.1 Multiple Sequence Alignments\n\nTool homepage: https://metacpan.org/release/Bio-Tools-Run-Alignment-Clustalw"
inputs:
  - id: align
    type:
      - 'null'
      - boolean
    doc: do full multiple alignment.
    inputBinding:
      position: 101
      prefix: -ALIGN
  - id: bootlabels
    type:
      - 'null'
      - string
    doc: position of bootstrap values in tree display (node OR branch)
    inputBinding:
      position: 101
      prefix: -BOOTLABELS=
      separate: false
  - id: bootstrap
    type:
      - 'null'
      - int
    doc: bootstrap a NJ tree (n= number of bootstraps; def. = 1000).
    inputBinding:
      position: 101
      prefix: -BOOTSTRAP
  - id: case
    type:
      - 'null'
      - string
    doc: LOWER or UPPER (for GDE output only)
    inputBinding:
      position: 101
      prefix: -CASE
  - id: clustering
    type:
      - 'null'
      - string
    doc: NJ or UPGMA
    inputBinding:
      position: 101
      prefix: -CLUSTERING=
      separate: false
  - id: convert
    type:
      - 'null'
      - boolean
    doc: output the input sequences in a different file format.
    inputBinding:
      position: 101
      prefix: -CONVERT
  - id: dnamatrix
    type:
      - 'null'
      - string
    doc: DNA weight matrix=IUB, CLUSTALW or filename
    inputBinding:
      position: 101
      prefix: -DNAMATRIX=
      separate: false
  - id: endgaps
    type:
      - 'null'
      - boolean
    doc: no end gap separation pen.
    inputBinding:
      position: 101
      prefix: -ENDGAPS
  - id: gapdist
    type:
      - 'null'
      - int
    doc: gap separation pen. range
    inputBinding:
      position: 101
      prefix: -GAPDIST=
      separate: false
  - id: gapext
    type:
      - 'null'
      - float
    doc: gap extension penalty
    inputBinding:
      position: 101
      prefix: -GAPEXT=
      separate: false
  - id: gapopen
    type:
      - 'null'
      - float
    doc: gap opening penalty
    inputBinding:
      position: 101
      prefix: -GAPOPEN=
      separate: false
  - id: helixendin
    type:
      - 'null'
      - int
    doc: number of residues inside helix to be treated as terminal
    inputBinding:
      position: 101
      prefix: -HELIXENDIN=
      separate: false
  - id: helixendout
    type:
      - 'null'
      - int
    doc: number of residues outside helix to be treated as terminal
    inputBinding:
      position: 101
      prefix: -HELIXENDOUT=
      separate: false
  - id: helixgap
    type:
      - 'null'
      - int
    doc: gap penalty for helix core residues
    inputBinding:
      position: 101
      prefix: -HELIXGAP=
      separate: false
  - id: hgapresidues
    type:
      - 'null'
      - string
    doc: list hydrophilic res.
    inputBinding:
      position: 101
      prefix: -HGAPRESIDUES=
      separate: false
  - id: infile
    type:
      - 'null'
      - File
    doc: input sequences.
    inputBinding:
      position: 101
      prefix: -INFILE=
      separate: false
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: read command line, then enter normal interactive menus
    inputBinding:
      position: 101
      prefix: -INTERACTIVE
  - id: iteration
    type:
      - 'null'
      - string
    doc: NONE or TREE or ALIGNMENT
    inputBinding:
      position: 101
      prefix: -ITERATION=
      separate: false
  - id: kimura
    type:
      - 'null'
      - boolean
    doc: use Kimura's correction.
    inputBinding:
      position: 101
      prefix: -KIMURA
  - id: ktuple
    type:
      - 'null'
      - int
    doc: word size
    inputBinding:
      position: 101
      prefix: -KTUPLE=
      separate: false
  - id: loopgap
    type:
      - 'null'
      - int
    doc: gap penalty for loop regions
    inputBinding:
      position: 101
      prefix: -LOOPGAP=
      separate: false
  - id: matrix
    type:
      - 'null'
      - string
    doc: Protein weight matrix=BLOSUM, PAM, GONNET, ID or filename
    inputBinding:
      position: 101
      prefix: -MATRIX=
      separate: false
  - id: maxdiv
    type:
      - 'null'
      - int
    doc: '% ident. for delay'
    inputBinding:
      position: 101
      prefix: -MAXDIV=
      separate: false
  - id: maxseqlen
    type:
      - 'null'
      - int
    doc: maximum allowed input sequence length
    inputBinding:
      position: 101
      prefix: -MAXSEQLEN=
      separate: false
  - id: negative
    type:
      - 'null'
      - boolean
    doc: protein alignment with negative values in matrix
    inputBinding:
      position: 101
      prefix: -NEGATIVE
  - id: nohgap
    type:
      - 'null'
      - boolean
    doc: hydrophilic gaps off
    inputBinding:
      position: 101
      prefix: -NOHGAP
  - id: nopgap
    type:
      - 'null'
      - boolean
    doc: residue-specific gaps off
    inputBinding:
      position: 101
      prefix: -NOPGAP
  - id: nosecstr1
    type:
      - 'null'
      - boolean
    doc: do not use secondary structure-gap penalty mask for profile 1
    inputBinding:
      position: 101
      prefix: -NOSECSTR1
  - id: nosecstr2
    type:
      - 'null'
      - boolean
    doc: do not use secondary structure-gap penalty mask for profile 2
    inputBinding:
      position: 101
      prefix: -NOSECSTR2
  - id: noweights
    type:
      - 'null'
      - boolean
    doc: disable sequence weighting
    inputBinding:
      position: 101
      prefix: -NOWEIGHTS
  - id: numiter
    type:
      - 'null'
      - int
    doc: maximum number of iterations to perform
    inputBinding:
      position: 101
      prefix: -NUMITER=
      separate: false
  - id: outorder
    type:
      - 'null'
      - string
    doc: INPUT or ALIGNED
    inputBinding:
      position: 101
      prefix: -OUTORDER=
      separate: false
  - id: output
    type:
      - 'null'
      - string
    doc: CLUSTAL(default), GCG, GDE, PHYLIP, PIR, NEXUS and FASTA
    inputBinding:
      position: 101
      prefix: -OUTPUT=
      separate: false
  - id: outputtree
    type:
      - 'null'
      - string
    doc: nj OR phylip OR dist OR nexus
    inputBinding:
      position: 101
      prefix: -OUTPUTTREE=
      separate: false
  - id: pairgap
    type:
      - 'null'
      - int
    doc: gap penalty
    inputBinding:
      position: 101
      prefix: -PAIRGAP=
      separate: false
  - id: pim
    type:
      - 'null'
      - boolean
    doc: output percent identity matrix (while calculating the tree)
    inputBinding:
      position: 101
      prefix: -PIM
  - id: profile
    type:
      - 'null'
      - boolean
    doc: Merge two alignments by profile alignment
    inputBinding:
      position: 101
      prefix: -PROFILE
  - id: profile1
    type:
      - 'null'
      - File
    doc: profiles (old alignment).
    inputBinding:
      position: 101
      prefix: -PROFILE1=
      separate: false
  - id: profile2
    type:
      - 'null'
      - File
    doc: profiles (old alignment).
    inputBinding:
      position: 101
      prefix: -PROFILE2=
      separate: false
  - id: pwdnamatrix
    type:
      - 'null'
      - string
    doc: DNA weight matrix=IUB, CLUSTALW or filename
    inputBinding:
      position: 101
      prefix: -PWDNAMATRIX=
      separate: false
  - id: pwgapext
    type:
      - 'null'
      - float
    doc: gap opening penalty
    inputBinding:
      position: 101
      prefix: -PWGAPEXT=
      separate: false
  - id: pwgapopen
    type:
      - 'null'
      - float
    doc: gap opening penalty
    inputBinding:
      position: 101
      prefix: -PWGAPOPEN=
      separate: false
  - id: pwmatrix
    type:
      - 'null'
      - string
    doc: Protein weight matrix=BLOSUM, PAM, GONNET, ID or filename
    inputBinding:
      position: 101
      prefix: -PWMATRIX=
      separate: false
  - id: quicktree
    type:
      - 'null'
      - boolean
    doc: use FAST algorithm for the alignment guide tree
    inputBinding:
      position: 101
      prefix: -QUICKTREE
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Reduce console output to minimum
    inputBinding:
      position: 101
      prefix: -QUIET
  - id: range
    type:
      - 'null'
      - string
    doc: sequence range to write starting m to m+n
    inputBinding:
      position: 101
      prefix: -RANGE=
      separate: false
  - id: score
    type:
      - 'null'
      - string
    doc: PERCENT or ABSOLUTE
    inputBinding:
      position: 101
      prefix: -SCORE
  - id: secstrout
    type:
      - 'null'
      - string
    doc: output in alignment file (STRUCTURE or MASK or BOTH or NONE)
    inputBinding:
      position: 101
      prefix: -SECSTROUT=
      separate: false
  - id: seed
    type:
      - 'null'
      - int
    doc: seed number for bootstraps.
    inputBinding:
      position: 101
      prefix: -SEED=
      separate: false
  - id: seqno_range
    type:
      - 'null'
      - string
    doc: 'OFF or ON (NEW: for all output formats)'
    inputBinding:
      position: 101
      prefix: -SEQNO_RANGE=
      separate: false
  - id: seqnos
    type:
      - 'null'
      - string
    doc: OFF or ON (for Clustal output only)
    inputBinding:
      position: 101
      prefix: -SEQNOS=
      separate: false
  - id: sequences
    type:
      - 'null'
      - boolean
    doc: Sequentially add profile2 sequences to profile1 alignment
    inputBinding:
      position: 101
      prefix: -SEQUENCES
  - id: strandendin
    type:
      - 'null'
      - int
    doc: number of residues inside strand to be treated as terminal
    inputBinding:
      position: 101
      prefix: -STRANDENDIN=
      separate: false
  - id: strandendout
    type:
      - 'null'
      - int
    doc: number of residues outside strand to be treated as terminal
    inputBinding:
      position: 101
      prefix: -STRANDENDOUT=
      separate: false
  - id: strandgap
    type:
      - 'null'
      - int
    doc: gap penalty for strand core residues
    inputBinding:
      position: 101
      prefix: -STRANDGAP=
      separate: false
  - id: terminalgap
    type:
      - 'null'
      - int
    doc: gap penalty for structure termini
    inputBinding:
      position: 101
      prefix: -TERMINALGAP=
      separate: false
  - id: topdiags
    type:
      - 'null'
      - int
    doc: number of best diags.
    inputBinding:
      position: 101
      prefix: -TOPDIAGS=
      separate: false
  - id: tossgaps
    type:
      - 'null'
      - boolean
    doc: ignore positions with gaps.
    inputBinding:
      position: 101
      prefix: -TOSSGAPS
  - id: transweight
    type:
      - 'null'
      - float
    doc: transitions weighting
    inputBinding:
      position: 101
      prefix: -TRANSWEIGHT=
      separate: false
  - id: tree
    type:
      - 'null'
      - boolean
    doc: calculate NJ tree.
    inputBinding:
      position: 101
      prefix: -TREE
  - id: type
    type:
      - 'null'
      - string
    doc: PROTEIN or DNA sequences
    inputBinding:
      position: 101
      prefix: -TYPE=
      separate: false
  - id: usetree
    type:
      - 'null'
      - File
    doc: file for old guide tree
    inputBinding:
      position: 101
      prefix: -USETREE=
      separate: false
  - id: usetree1
    type:
      - 'null'
      - File
    doc: file for old guide tree for profile1
    inputBinding:
      position: 101
      prefix: -USETREE1=
      separate: false
  - id: usetree2
    type:
      - 'null'
      - File
    doc: file for old guide tree for profile2
    inputBinding:
      position: 101
      prefix: -USETREE2=
      separate: false
  - id: window
    type:
      - 'null'
      - int
    doc: window around best diags.
    inputBinding:
      position: 101
      prefix: -WINDOW=
      separate: false
  - id: newtree_path
    type:
      - 'null'
      - string
    doc: :file for new guide tree
    inputBinding:
      position: 102
      prefix: -NEWTREE=
      separate: false
  - id: newtree1_path
    type:
      - 'null'
      - string
    doc: :file for new guide tree for profile1
    inputBinding:
      position: 103
      prefix: -NEWTREE1=
      separate: false
  - id: newtree2_path
    type:
      - 'null'
      - string
    doc: :file for new guide tree for profile2
    inputBinding:
      position: 104
      prefix: -NEWTREE2=
      separate: false
  - id: outfile_path
    type:
      - 'null'
      - string
    doc: :sequence alignment file name
    inputBinding:
      position: 105
      prefix: -OUTFILE=
      separate: false
  - id: stats_path
    type:
      - 'null'
      - string
    doc: :Log some alignents statistics to file
    inputBinding:
      position: 106
      prefix: -STATS=
      separate: false
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: sequence alignment file name
    outputBinding:
      glob: $(inputs.outfile_path)
  - id: stats
    type:
      - 'null'
      - File
    doc: Log some alignents statistics to file
    outputBinding:
      glob: $(inputs.stats_path)
  - id: newtree
    type:
      - 'null'
      - File
    doc: file for new guide tree
    outputBinding:
      glob: $(inputs.newtree_path)
  - id: newtree1
    type:
      - 'null'
      - File
    doc: file for new guide tree for profile1
    outputBinding:
      glob: $(inputs.newtree1_path)
  - id: newtree2
    type:
      - 'null'
      - File
    doc: file for new guide tree for profile2
    outputBinding:
      glob: $(inputs.newtree2_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-bio-tools-run-alignment-clustalw:1.7.4--pl526_0
