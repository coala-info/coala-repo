cwlVersion: v1.2
class: CommandLineTool
baseCommand: clustalo
label: clustal-omega_clustalo
doc: "Fast, scalable generation of high-quality protein multiple sequence alignments
  using Clustal Omega\n\nTool homepage: https://github.com/hybsearch/clustalo"
inputs:
  - id: auto
    type:
      - 'null'
      - boolean
    doc: Set options automatically (might overwrite some of your options)
    inputBinding:
      position: 101
      prefix: --auto
  - id: cluster_size
    type:
      - 'null'
      - int
    doc: soft maximum of sequences in sub-clusters
    inputBinding:
      position: 101
      prefix: --cluster-size
  - id: dealign
    type:
      - 'null'
      - boolean
    doc: Dealign input sequences
    inputBinding:
      position: 101
      prefix: --dealign
  - id: distmat_in
    type:
      - 'null'
      - File
    doc: Pairwise distance matrix input file (skips distance computation)
    inputBinding:
      position: 101
      prefix: --distmat-in
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force file overwriting
    inputBinding:
      position: 101
      prefix: --force
  - id: full
    type:
      - 'null'
      - boolean
    doc: Use full distance matrix for guide-tree calculation (might be slow; 
      mBed is default)
    inputBinding:
      position: 101
      prefix: --full
  - id: full_iter
    type:
      - 'null'
      - boolean
    doc: Use full distance matrix for guide-tree calculation during iteration 
      (might be slowish; mBed is default)
    inputBinding:
      position: 101
      prefix: --full-iter
  - id: guidetree_in
    type:
      - 'null'
      - File
    doc: Guide tree input file (skips distance computation and guide-tree 
      clustering step)
    inputBinding:
      position: 101
      prefix: --guidetree-in
  - id: hmm_in
    type:
      - 'null'
      - type: array
        items: File
    doc: HMM input files
    inputBinding:
      position: 101
      prefix: --hmm-in
  - id: infile
    type:
      - 'null'
      - File
    doc: Multiple sequence input file (- for stdin)
    inputBinding:
      position: 101
      prefix: --in
  - id: infmt
    type:
      - 'null'
      - string
    doc: 'Forced sequence input file format (a2m, clu, msf, phy, selex, st, vie; default:
      auto)'
    inputBinding:
      position: 101
      prefix: --infmt
  - id: is_profile
    type:
      - 'null'
      - boolean
    doc: disable check if profile, force profile (default no)
    inputBinding:
      position: 101
      prefix: --is-profile
  - id: iterations
    type:
      - 'null'
      - int
    doc: Number of (combined guide-tree/HMM) iterations
    inputBinding:
      position: 101
      prefix: --iterations
  - id: mac_ram
    type:
      - 'null'
      - int
    doc: Maximum RAM to use
    inputBinding:
      position: 101
      prefix: --MAC-RAM
  - id: max_guidetree_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of guidetree iterations
    inputBinding:
      position: 101
      prefix: --max-guidetree-iterations
  - id: max_hmm_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of HMM iterations
    inputBinding:
      position: 101
      prefix: --max-hmm-iterations
  - id: maxnumseq
    type:
      - 'null'
      - int
    doc: Maximum allowed number of sequences
    inputBinding:
      position: 101
      prefix: --maxnumseq
  - id: maxseqlen
    type:
      - 'null'
      - int
    doc: Maximum allowed sequence length
    inputBinding:
      position: 101
      prefix: --maxseqlen
  - id: outfmt
    type:
      - 'null'
      - string
    doc: 'MSA output file format (a2m, clu, msf, phy, selex, st, vie; default: fasta)'
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: output_order
    type:
      - 'null'
      - string
    doc: MSA output order like in input/guide-tree (input-order, tree-order)
    inputBinding:
      position: 101
      prefix: --output-order
  - id: percent_id
    type:
      - 'null'
      - boolean
    doc: convert distances into percent identities (default no)
    inputBinding:
      position: 101
      prefix: --percent-id
  - id: pileup
    type:
      - 'null'
      - boolean
    doc: Sequentially align sequences
    inputBinding:
      position: 101
      prefix: --pileup
  - id: profile1
    type:
      - 'null'
      - File
    doc: Pre-aligned multiple sequence file (aligned columns will be kept fix)
    inputBinding:
      position: 101
      prefix: --profile1
  - id: profile2
    type:
      - 'null'
      - File
    doc: Pre-aligned multiple sequence file (aligned columns will be kept fix)
    inputBinding:
      position: 101
      prefix: --profile2
  - id: pseudo
    type:
      - 'null'
      - File
    doc: Input file for pseudo-count parameters
    inputBinding:
      position: 101
      prefix: --pseudo
  - id: residuenumber
    type:
      - 'null'
      - boolean
    doc: in Clustal format print residue numbers (default no)
    inputBinding:
      position: 101
      prefix: --residuenumber
  - id: seqtype
    type:
      - 'null'
      - string
    doc: 'Force a sequence type (Protein, RNA, DNA; default: auto)'
    inputBinding:
      position: 101
      prefix: --seqtype
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processors to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: trans
    type:
      - 'null'
      - int
    doc: use transitivity
    inputBinding:
      position: 101
      prefix: --trans
  - id: use_kimura
    type:
      - 'null'
      - boolean
    doc: use Kimura distance correction for aligned sequences (default no)
    inputBinding:
      position: 101
      prefix: --use-kimura
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output (increases if given multiple times)
    inputBinding:
      position: 101
      prefix: --verbose
  - id: wrap
    type:
      - 'null'
      - int
    doc: number of residues before line-wrap in output
    inputBinding:
      position: 101
      prefix: --wrap
outputs:
  - id: distmat_out
    type:
      - 'null'
      - File
    doc: Pairwise distance matrix output file
    outputBinding:
      glob: $(inputs.distmat_out)
  - id: guidetree_out
    type:
      - 'null'
      - File
    doc: Guide tree output file
    outputBinding:
      glob: $(inputs.guidetree_out)
  - id: clustering_out
    type:
      - 'null'
      - File
    doc: Clustering output file
    outputBinding:
      glob: $(inputs.clustering_out)
  - id: posterior_out
    type:
      - 'null'
      - File
    doc: Posterior probability output file
    outputBinding:
      glob: $(inputs.posterior_out)
  - id: outfile
    type:
      - 'null'
      - File
    doc: 'Multiple sequence alignment output file (default: stdout)'
    outputBinding:
      glob: $(inputs.outfile)
  - id: log
    type:
      - 'null'
      - File
    doc: Log all non-essential output to this file
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/clustal-omega:v1.2.1-1_cv3
