cwlVersion: v1.2
class: CommandLineTool
baseCommand: prank
label: prank
doc: "Minimal usage: 'prank sequence_file'\n\nTool homepage: https://github.com/n0xa/m5stick-nemo"
inputs:
  - id: sequence_file
    type: File
    doc: Input sequence file in FASTA format
    inputBinding:
      position: 1
  - id: anchorskip
    type:
      - 'null'
      - int
    doc: Min. sequence length for anchoring
    inputBinding:
      position: 102
      prefix: -anchorskip
  - id: codon
    type:
      - 'null'
      - boolean
    doc: 'For coding DNA: use empirical codon model'
    inputBinding:
      position: 102
      prefix: -codon
  - id: convert
    type:
      - 'null'
      - boolean
    doc: No alignment, just convert to another format
    inputBinding:
      position: 102
      prefix: -convert
  - id: dna_sequence_file
    type:
      - 'null'
      - File
    doc: DNA sequence file for backtranslation of protein alignment
    inputBinding:
      position: 102
      prefix: -dna
  - id: dnafreqs
    type:
      - 'null'
      - string
    doc: DNA frequencies ACGT
    inputBinding:
      position: 102
      prefix: -dnafreqs
  - id: fixedbranches
    type:
      - 'null'
      - string
    doc: Use fixed branch lengths
    inputBinding:
      position: 102
      prefix: -fixedbranches
  - id: force_skip_insertions
    type:
      - 'null'
      - boolean
    doc: Force insertions to be always skipped
    inputBinding:
      position: 102
      prefix: +F
  - id: force_skip_insertions_alt
    type:
      - 'null'
      - boolean
    doc: Force insertions to be always skipped
    inputBinding:
      position: 102
      prefix: -F
  - id: gapext
    type:
      - 'null'
      - float
    doc: Gap extension probability
    inputBinding:
      position: 102
      prefix: -gapext
  - id: gaprate
    type:
      - 'null'
      - float
    doc: Gap opening rate
    inputBinding:
      position: 102
      prefix: -gaprate
  - id: indelscore
    type:
      - 'null'
      - string
    doc: Indel penalties for alignment score (1,2,3,>3)
    inputBinding:
      position: 102
      prefix: -indelscore
  - id: iterate
    type:
      - 'null'
      - int
    doc: Rounds of re-alignment iteration
    inputBinding:
      position: 102
      prefix: -iterate
  - id: kappa
    type:
      - 'null'
      - float
    doc: TS/TV rate ratio
    inputBinding:
      position: 102
      prefix: -kappa
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep alignment "as is" (e.g. for ancestor inference)
    inputBinding:
      position: 102
      prefix: -keep
  - id: maxbranches
    type:
      - 'null'
      - string
    doc: Set maximum branch length
    inputBinding:
      position: 102
      prefix: -maxbranches
  - id: mergedist
    type:
      - 'null'
      - float
    doc: Merge distance (if no tree provided)
    inputBinding:
      position: 102
      prefix: -mergedist
  - id: model_file
    type:
      - 'null'
      - File
    doc: Model file
    inputBinding:
      position: 102
      prefix: -m
  - id: mttranslate
    type:
      - 'null'
      - boolean
    doc: Translate to protein using mt table
    inputBinding:
      position: 102
      prefix: -mttranslate
  - id: njtree
    type:
      - 'null'
      - boolean
    doc: Estimate tree from input alignment (and realign)
    inputBinding:
      position: 102
      prefix: -njtree
  - id: noanchors
    type:
      - 'null'
      - boolean
    doc: No Exonerate anchoring
    inputBinding:
      position: 102
      prefix: -noanchors
  - id: nomafft
    type:
      - 'null'
      - boolean
    doc: No MAFFT guide tree
    inputBinding:
      position: 102
      prefix: -nomafft
  - id: nomissing
    type:
      - 'null'
      - boolean
    doc: No missing data, use -F for terminal gaps
    inputBinding:
      position: 102
      prefix: -nomissing
  - id: once
    type:
      - 'null'
      - boolean
    doc: Run only once; same as -iterate=1
    inputBinding:
      position: 102
      prefix: -once
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format ('fasta', 'phylipi', 'phylips', 'paml', 'nexus')
    inputBinding:
      position: 102
      prefix: -f
  - id: prunedata
    type:
      - 'null'
      - boolean
    doc: Prune sequence data with no guide tree leaves
    inputBinding:
      position: 102
      prefix: -prunedata
  - id: prunetree
    type:
      - 'null'
      - boolean
    doc: Prune guide tree branches with no sequence data
    inputBinding:
      position: 102
      prefix: -prunetree
  - id: pwdist
    type:
      - 'null'
      - float
    doc: Expected pairwise distance for computing guide tree
    inputBinding:
      position: 102
      prefix: -pwdist
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode
    inputBinding:
      position: 102
      prefix: -quiet
  - id: realbranches
    type:
      - 'null'
      - boolean
    doc: Disable branch length truncation
    inputBinding:
      position: 102
      prefix: -realbranches
  - id: rho
    type:
      - 'null'
      - float
    doc: Pur/pyr rate ratio
    inputBinding:
      position: 102
      prefix: -rho
  - id: scalebranches
    type:
      - 'null'
      - string
    doc: Scale branch lengths
    inputBinding:
      position: 102
      prefix: -scalebranches
  - id: scoremafft
    type:
      - 'null'
      - boolean
    doc: Score also MAFFT alignment
    inputBinding:
      position: 102
      prefix: -scoremafft
  - id: seed
    type:
      - 'null'
      - int
    doc: Set random number seed
    inputBinding:
      position: 102
      prefix: -seed
  - id: sequence_file_1
    type:
      - 'null'
      - File
    doc: Sequence file 1 (in FASTA format)
    inputBinding:
      position: 102
      prefix: -d1
  - id: sequence_file_2
    type:
      - 'null'
      - File
    doc: Sequence file 2 (in FASTA format)
    inputBinding:
      position: 102
      prefix: -d2
  - id: shortnames
    type:
      - 'null'
      - boolean
    doc: Truncate names at first space
    inputBinding:
      position: 102
      prefix: -shortnames
  - id: show_dots
    type:
      - 'null'
      - boolean
    doc: Show insertion gaps as dots
    inputBinding:
      position: 102
      prefix: -dots
  - id: showall
    type:
      - 'null'
      - boolean
    doc: Output all of these
    inputBinding:
      position: 102
      prefix: -showall
  - id: showanc
    type:
      - 'null'
      - boolean
    doc: Output ancestral sequences
    inputBinding:
      position: 102
      prefix: -showanc
  - id: showevents
    type:
      - 'null'
      - boolean
    doc: Output evolutionary events
    inputBinding:
      position: 102
      prefix: -showevents
  - id: showtree
    type:
      - 'null'
      - boolean
    doc: Output dnd-files
    inputBinding:
      position: 102
      prefix: -showtree
  - id: showxml
    type:
      - 'null'
      - boolean
    doc: Output xml-files
    inputBinding:
      position: 102
      prefix: -showxml
  - id: skipins
    type:
      - 'null'
      - boolean
    doc: Skip insertions in posterior support
    inputBinding:
      position: 102
      prefix: -skipins
  - id: support
    type:
      - 'null'
      - boolean
    doc: Compute posterior support
    inputBinding:
      position: 102
      prefix: -support
  - id: termgap
    type:
      - 'null'
      - boolean
    doc: Penalise terminal gaps normally
    inputBinding:
      position: 102
      prefix: -termgap
  - id: translate
    type:
      - 'null'
      - boolean
    doc: Translate to protein
    inputBinding:
      position: 102
      prefix: -translate
  - id: tree_file
    type:
      - 'null'
      - File
    doc: Tree file
    inputBinding:
      position: 102
      prefix: -t
  - id: tree_file_1
    type:
      - 'null'
      - File
    doc: Tree file 1 (if not provided, generate NJ tree)
    inputBinding:
      position: 102
      prefix: -t1
  - id: tree_file_2
    type:
      - 'null'
      - File
    doc: Tree file 2 (if not provided, generate NJ tree)
    inputBinding:
      position: 102
      prefix: -t2
  - id: tree_string
    type:
      - 'null'
      - string
    doc: Tree in newick format; in double quotes
    inputBinding:
      position: 102
      prefix: -tree
  - id: treeonly
    type:
      - 'null'
      - boolean
    doc: Estimate tree only
    inputBinding:
      position: 102
      prefix: -treeonly
  - id: use_dna_model
    type:
      - 'null'
      - boolean
    doc: 'No autodetection: use DNA model'
    inputBinding:
      position: 102
      prefix: -DNA
  - id: use_protein_model
    type:
      - 'null'
      - boolean
    doc: 'No autodetection: use protein model'
    inputBinding:
      position: 102
      prefix: -protein
  - id: uselogs
    type:
      - 'null'
      - boolean
    doc: Slower but should work for a greater number of sequences
    inputBinding:
      position: 102
      prefix: -uselogs
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print progress etc. during runtime
    inputBinding:
      position: 102
      prefix: -verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prank:170427--h4ac6f70_0
