cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar RAPPAS.jar
label: rappas
doc: "Rapid Alignment-free Phylogenetic Placement via Ancestral Sequences\n\nTool
  homepage: https://github.com/blinard-BIOINFO/RAPPAS"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: Gammma shape parameter used in AR . (b phase)
    default: 1.0
    inputBinding:
      position: 101
      prefix: --alpha
  - id: ambwithmax
    type:
      - 'null'
      - boolean
    doc: Treat ambiguities with max, not mean. (p phase)
    inputBinding:
      position: 101
      prefix: --ambwithmax
  - id: arbinary
    type:
      - 'null'
      - string
    doc: Binary for marginal AR, currently 'phyml' and 'baseml' (from PAML) are 
      supported. (b phase)
    inputBinding:
      position: 101
      prefix: --arbinary
  - id: ardir
    type:
      - 'null'
      - Directory
    doc: Skip ancestral sequence reconstruction, and uses outputs from the 
      specified directory. (b phase)
    inputBinding:
      position: 101
      prefix: --ardir
  - id: arinputonly
    type:
      - 'null'
      - boolean
    doc: Generate only AR inputs. (b phase)
    inputBinding:
      position: 101
      prefix: --arinputonly
  - id: aronly
    type:
      - 'null'
      - boolean
    doc: Launch AR, but not DB build. (b phase)
    inputBinding:
      position: 101
      prefix: --aronly
  - id: arparameters
    type:
      - 'null'
      - string
    doc: "Parameters passed to the software used for anc. seq. reconstuct. Overrides
      -a,-c,-m options. Value must be quoted by ' or \". Do not set options -i,-u,--ancestral
      (managed by RAPPAS). (b phase) PhyML example: \"-m HIVw -c 10 -f m -v 0.0 --r_seed
      1\""
    inputBinding:
      position: 101
      prefix: --arparameters
  - id: categories
    type:
      - 'null'
      - int
    doc: '# categories used in AR . (b phase)'
    default: 4
    inputBinding:
      position: 101
      prefix: --categories
  - id: convertUO
    type:
      - 'null'
      - boolean
    doc: U,O amino acids are converted to C,L. (b|p phase)
    inputBinding:
      position: 101
      prefix: --convertUO
  - id: database
    type:
      - 'null'
      - File
    doc: The database of ancestral kmers. (b|p phase)
    inputBinding:
      position: 101
      prefix: --database
  - id: dbfilename
    type:
      - 'null'
      - string
    doc: Set DB filename. (b phase)
    inputBinding:
      position: 101
      prefix: --dbfilename
  - id: dbinram
    type:
      - 'null'
      - boolean
    doc: Build DB, do not save it to a file, but directly place queries given 
      via -q instead.
    inputBinding:
      position: 101
      prefix: --dbinram
  - id: do_n_jumps
    type:
      - 'null'
      - boolean
    doc: Shifts from 1 to n jumps. (b phase)
    inputBinding:
      position: 101
      prefix: --do-n-jumps
  - id: force_gap_jump
    type:
      - 'null'
      - boolean
    doc: Forces gap jump even if %gap<thresh. (b phase)
    inputBinding:
      position: 101
      prefix: --force-gap-jump
  - id: force_root
    type:
      - 'null'
      - boolean
    doc: Root input tree (if unrooted) by adding a root node on righmost branch 
      of the trifurcation.(b phase)
    inputBinding:
      position: 101
      prefix: --force-root
  - id: gap_jump_thresh
    type:
      - 'null'
      - float
    doc: Gap ratio above which gap jumps are activated.
    default: 0.3
    inputBinding:
      position: 101
      prefix: --gap-jump-thresh
  - id: ghosts
    type:
      - 'null'
      - int
    doc: '# ghost nodes injected per branches. (b phase)'
    default: 1
    inputBinding:
      position: 101
      prefix: --ghosts
  - id: guppy_compat
    type:
      - 'null'
      - boolean
    doc: Ensures output is Guppy compatible. (p phase)
    inputBinding:
      position: 101
      prefix: --guppy-compat
  - id: jsondb
    type:
      - 'null'
      - boolean
    doc: DB written as json. (careful, huge file outputs!)
    inputBinding:
      position: 101
      prefix: --jsondb
  - id: k
    type:
      - 'null'
      - int
    doc: k-mer length used at DB build. (b mode)
    default: 8
    inputBinding:
      position: 101
      prefix: --k
  - id: keep_at_most
    type:
      - 'null'
      - int
    doc: Max number of placement per query kept in the jplace output. (p phase)
    default: 7
    inputBinding:
      position: 101
      prefix: --keep-at-most
  - id: keep_factor
    type:
      - 'null'
      - float
    doc: Report placement with likelihood_ratio higher than (factor x 
      best_likelihood_ratio). (p phase)
    default: 0.01
    inputBinding:
      position: 101
      prefix: --keep-factor
  - id: model
    type:
      - 'null'
      - string
    doc: 'Model used in AR, one of the following: nucl : JC69, HKY85, K80, F81, TN93,
      GTR amino : LG, WAG, JTT, Dayhoff, DCMut, CpREV, mMtREV, MtMam, MtArt'
    inputBinding:
      position: 101
      prefix: --model
  - id: no_reduction
    type:
      - 'null'
      - boolean
    doc: Do not operate alignment reduction. This will keep all sites of input 
      reference alignment and may produce erroneous ancestral k-mers. (b phase)
    inputBinding:
      position: 101
      prefix: --no-reduction
  - id: noamb
    type:
      - 'null'
      - boolean
    doc: Do not treat ambiguous states. (p phase)
    inputBinding:
      position: 101
      prefix: --noamb
  - id: omega
    type:
      - 'null'
      - float
    doc: Modifier levelling the threshold used during phylo-kmer filtering, 
      T=(omega/#states)^k .(b phase)
    default: 1.0
    inputBinding:
      position: 101
      prefix: --omega
  - id: phase
    type:
      - 'null'
      - string
    doc: "One of 'b' for \"Build\" or 'p' for \"Place\". b: Build DB of phylo-kmers
      (done 1 time). p: Phylogenetic placement itself (done n times) requires the
      DB generated during 'build' phase."
    inputBinding:
      position: 101
      prefix: --phase
  - id: queries
    type:
      - 'null'
      - type: array
        items: File
    doc: Fasta queries to place on the tree. Can be a list of files separated by
      ','.
    inputBinding:
      position: 101
      prefix: --queries
  - id: ratio_reduction
    type:
      - 'null'
      - float
    doc: Ratio for alignment reduction, e.g. sites holding >99% gaps are 
      ignored. (b phase)
    default: 0.99
    inputBinding:
      position: 101
      prefix: --ratio-reduction
  - id: refalign
    type:
      - 'null'
      - File
    doc: Reference alignment in fasta format. It must be the multiple alignment 
      from which was built the reference tree loaded with -t. (b phase)
    inputBinding:
      position: 101
      prefix: --refalign
  - id: reftree
    type:
      - 'null'
      - File
    doc: Reference tree, in newick format.
    inputBinding:
      position: 101
      prefix: --reftree
  - id: states
    type:
      - 'null'
      - string
    doc: States used in analysis. ('nucl'|'amino') (b|p phase)
    inputBinding:
      position: 101
      prefix: --states
  - id: threads
    type:
      - 'null'
      - int
    doc: '#threads used in AR (if raxml-ng). (b phase)'
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_unrooted
    type:
      - 'null'
      - boolean
    doc: Confirms you accept to use an unrooted reference tree (option -t). The 
      trifurcation described by the newick file will be considered as root. Be 
      aware that meaningless roots may impact accuracy. (b phase)
    inputBinding:
      position: 101
      prefix: --use_unrooted
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: -1=none ; 0=default ; 1=high'
    default: 0
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: Working directory for temp files. (b|p phase)
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: write_reduction
    type:
      - 'null'
      - File
    doc: Write reduced alignment to file. (b phase)
    outputBinding:
      glob: $(inputs.write_reduction)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rappas:1.22--hdfd78af_0
