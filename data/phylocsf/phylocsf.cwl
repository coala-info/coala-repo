cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PhyloCSF
label: phylocsf
doc: "PhyloCSF (Phylogenetic Codon Substitution Frequencies) scores how likely a multi-species alignment is to be protein-coding, using a comparative genomics approach. The first sequence of the alignment is the reference.\n\nTool homepage: https://github.com/mlin/PhyloCSF/wiki"
inputs:
  - id: parameter_set
    type: string
    doc: "name of the parameter set (species tree and codon models), for example 12flies, 29mammals, 100vertebrates, 7yeast"
    inputBinding:
      position: 1
  - id: strategy
    type:
      - 'null'
      - string
    doc: "evaluation strategy: mle, fixed or omega (default mle)"
    inputBinding:
      position: 2
      prefix: "--strategy="
      separate: false
  - id: files
    type:
      - 'null'
      - boolean
    doc: "input list(s) of alignment filenames instead of individual alignment(s)"
    inputBinding:
      position: 2
      prefix: "--files"
  - id: remove_ref_gaps
    type:
      - 'null'
      - boolean
    doc: "automatically remove any alignment columns that are gapped in the reference sequence (nucleotide columns are removed individually; be careful about reading frame). By default, it is an error for the reference sequence to contain gaps"
    inputBinding:
      position: 2
      prefix: "--removeRefGaps"
  - id: species
    type:
      - 'null'
      - string
    doc: "hint that only this subset of species (comma separated) will be used in any of the alignments; this does not change the calculation mathematically, but can speed it up"
    inputBinding:
      position: 2
      prefix: "--species="
      separate: false
  - id: frames
    type:
      - 'null'
      - int
    doc: "how many reading frames to search: 1, 3 or 6 (default 1)"
    inputBinding:
      position: 2
      prefix: "--frames="
      separate: false
  - id: orf
    type:
      - 'null'
      - string
    doc: "search for ORFs: AsIs, ATGStop, StopStop, StopStop3, ToFirstStop, FromLastStop or ToOrFromStop (default AsIs)"
    inputBinding:
      position: 2
      prefix: "--orf="
      separate: false
  - id: min_codons
    type:
      - 'null'
      - int
    doc: "minimum ORF length for searching over ORFs (default 25 codons)"
    inputBinding:
      position: 2
      prefix: "--minCodons="
      separate: false
  - id: all_scores
    type:
      - 'null'
      - boolean
    doc: "report scores of all regions evaluated, not just the max"
    inputBinding:
      position: 2
      prefix: "--allScores"
  - id: parallel
    type:
      - 'null'
      - int
    doc: "search frames/ORFs using up to this many parallel subprocesses"
    inputBinding:
      position: 2
      prefix: "-p"
      separate: false
  - id: bls
    type:
      - 'null'
      - boolean
    doc: "include alignment branch length score (BLS) for the reported region in output"
    inputBinding:
      position: 2
      prefix: "--bls"
  - id: anc_comp
    type:
      - 'null'
      - boolean
    doc: "include ancestral sequence composition score in output"
    inputBinding:
      position: 2
      prefix: "--ancComp"
  - id: dna
    type:
      - 'null'
      - boolean
    doc: "include DNA sequence in output, the part of the reference (first) sequence whose score is reported"
    inputBinding:
      position: 2
      prefix: "--dna"
  - id: aa
    type:
      - 'null'
      - boolean
    doc: "include amino acid translation in output"
    inputBinding:
      position: 2
      prefix: "--aa"
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "print extra information about parameters and errors"
    inputBinding:
      position: 2
      prefix: "--debug"
  - id: alignment_files
    type:
      type: array
      items: File
    doc: "alignment file(s) in FASTA or MAF format (or list files with --files)"
    inputBinding:
      position: 3
outputs:
  - id: scores
    type: stdout
    doc: "Scores table (standard output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylocsf:1.0.1--h3eba124_0
stdout: phylocsf.out
