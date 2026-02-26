cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe multiple_align
label: haphpipe_multiple_align
doc: "Aligns multiple sequences using MAFFT.\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs:
  - id: aamatrix
    type:
      - 'null'
      - File
    doc: Path to user-defined AA scoring matrix
    inputBinding:
      position: 101
      prefix: --aamatrix
  - id: algo
    type:
      - 'null'
      - string
    doc: 'Use different algorithm in command: linsi, ginsi, einsi, fftnsi, fftns,
      nwns, nwnsi'
    inputBinding:
      position: 101
      prefix: --algo
  - id: alignall
    type:
      - 'null'
      - boolean
    doc: Do not separate files by region, align entire file
    default: false
    inputBinding:
      position: 101
      prefix: --alignall
  - id: amino
    type:
      - 'null'
      - boolean
    doc: Assume amino
    default: false
    inputBinding:
      position: 101
      prefix: --amino
  - id: auto
    type:
      - 'null'
      - boolean
    doc: Automatically select algorithm
    default: false
    inputBinding:
      position: 101
      prefix: --auto
  - id: bl
    type:
      - 'null'
      - string
    doc: 'BLOSUM matrix: 30, 45, 62, or 80'
    inputBinding:
      position: 101
      prefix: --bl
  - id: clustalout
    type:
      - 'null'
      - boolean
    doc: Clustal output format
    default: false
    inputBinding:
      position: 101
      prefix: --clustalout
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print commands but do not run
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: dir_list
    type:
      - 'null'
      - Directory
    doc: List of directories which include either a final.fna or 
      ph_haplotypes.fna file, one on each line
    inputBinding:
      position: 101
      prefix: --dir_list
  - id: dpparttree
    type:
      - 'null'
      - boolean
    doc: Use PartTree algorithm with distances based on DP
    inputBinding:
      position: 101
      prefix: --dpparttree
  - id: fastaonly
    type:
      - 'null'
      - boolean
    doc: Output fasta files separated by region but do not align
    default: false
    inputBinding:
      position: 101
      prefix: --fastaonly
  - id: fastapair
    type:
      - 'null'
      - boolean
    doc: Use FASTA for pairwise alignment
    default: false
    inputBinding:
      position: 101
      prefix: --fastapair
  - id: fastaparttree
    type:
      - 'null'
      - boolean
    doc: Use PartTree algorithm with distances based on FASTA
    inputBinding:
      position: 101
      prefix: --fastaparttree
  - id: fmodel
    type:
      - 'null'
      - boolean
    doc: Incorporate AA/nuc composition info into scoring matrix
    inputBinding:
      position: 101
      prefix: --fmodel
  - id: genafpair
    type:
      - 'null'
      - boolean
    doc: Use local algorithm with generalized affine gap cost
    default: false
    inputBinding:
      position: 101
      prefix: --genafpair
  - id: globalpair
    type:
      - 'null'
      - boolean
    doc: Use Needleman-Wunsch algorithm
    default: false
    inputBinding:
      position: 101
      prefix: --globalpair
  - id: groupsize
    type:
      - 'null'
      - int
    doc: Max number of sequences for PartTree
    inputBinding:
      position: 101
      prefix: --groupsize
  - id: inputorder
    type:
      - 'null'
      - boolean
    doc: Output order same as input
    default: false
    inputBinding:
      position: 101
      prefix: --inputorder
  - id: jtt
    type:
      - 'null'
      - int
    doc: JTT PAM number >0
    inputBinding:
      position: 101
      prefix: --jtt
  - id: lep
    type:
      - 'null'
      - float
    doc: Offset value
    inputBinding:
      position: 101
      prefix: --lep
  - id: lexp
    type:
      - 'null'
      - float
    doc: Gap extension penalty
    inputBinding:
      position: 101
      prefix: --lexp
  - id: lexp_skip
    type:
      - 'null'
      - float
    doc: Gap extension penalty to skip alignment
    inputBinding:
      position: 101
      prefix: --LEXP
  - id: localpair
    type:
      - 'null'
      - boolean
    doc: Use Smith-Waterman algorithm
    default: false
    inputBinding:
      position: 101
      prefix: --localpair
  - id: lop
    type:
      - 'null'
      - float
    doc: Gap opening penalty
    inputBinding:
      position: 101
      prefix: --lop
  - id: lop_skip
    type:
      - 'null'
      - float
    doc: Gap opening penalty to skip alignment
    inputBinding:
      position: 101
      prefix: --LOP
  - id: maxiterate
    type:
      - 'null'
      - int
    doc: Number of cycles for iterative refinement
    inputBinding:
      position: 101
      prefix: --maxiterate
  - id: memsave
    type:
      - 'null'
      - boolean
    doc: Use Myers-Miller algorithm
    inputBinding:
      position: 101
      prefix: --memsave
  - id: ncpu
    type:
      - 'null'
      - int
    doc: Number of CPU to use
    default: 1
    inputBinding:
      position: 101
      prefix: --ncpu
  - id: noscore
    type:
      - 'null'
      - boolean
    doc: Do not check alignment score in iterative alignment
    default: false
    inputBinding:
      position: 101
      prefix: --noscore
  - id: nuc
    type:
      - 'null'
      - boolean
    doc: Assume nucleotide
    default: false
    inputBinding:
      position: 101
      prefix: --nuc
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: partsize
    type:
      - 'null'
      - int
    doc: Number of partitions for PartTree
    inputBinding:
      position: 101
      prefix: --partsize
  - id: parttree
    type:
      - 'null'
      - boolean
    doc: Use fast tree-building method with 6mer distance
    inputBinding:
      position: 101
      prefix: --parttree
  - id: phylipout
    type:
      - 'null'
      - boolean
    doc: PHYLIP output format
    default: false
    inputBinding:
      position: 101
      prefix: --phylipout
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not write output to console (silence stdout and stderr)
    default: false
    inputBinding:
      position: 101
      prefix: --quiet
  - id: quiet_mafft
    type:
      - 'null'
      - boolean
    doc: Do not report progress
    default: false
    inputBinding:
      position: 101
      prefix: --quiet_mafft
  - id: ref_gtf
    type:
      - 'null'
      - File
    doc: Reference GTF file
    inputBinding:
      position: 101
      prefix: --ref_gtf
  - id: reorder
    type:
      - 'null'
      - boolean
    doc: Output order aligned
    default: false
    inputBinding:
      position: 101
      prefix: --reorder
  - id: retree
    type:
      - 'null'
      - int
    doc: Number of times to build guide tree
    inputBinding:
      position: 101
      prefix: --retree
  - id: seqs
    type:
      - 'null'
      - File
    doc: FASTA file with sequences to be aligned
    inputBinding:
      position: 101
      prefix: --seqs
  - id: sixmerpair
    type:
      - 'null'
      - boolean
    doc: Calculate distance based on shared 6mers, on by default
    default: false
    inputBinding:
      position: 101
      prefix: --sixmerpair
  - id: tm
    type:
      - 'null'
      - int
    doc: Transmembrane PAM number >0
    inputBinding:
      position: 101
      prefix: --tm
  - id: treeout
    type:
      - 'null'
      - boolean
    doc: Guide tree is output to the input.tree file
    default: false
    inputBinding:
      position: 101
      prefix: --treeout
  - id: weighti
    type:
      - 'null'
      - float
    doc: Weighting factor for consistency term
    inputBinding:
      position: 101
      prefix: --weighti
outputs:
  - id: out_align
    type:
      - 'null'
      - File
    doc: Name for alignment file
    outputBinding:
      glob: $(inputs.out_align)
  - id: logfile
    type:
      - 'null'
      - File
    doc: Name for log file (output)
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
