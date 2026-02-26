cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - foldmason
  - easy-msa
label: foldmason_easy-msa
doc: "By Cameron Gilchrist <gamcil@snu.ac.kr> & Martin Steinegger <martin.steinegger@snu.ac.kr>\n\
  \nTool homepage: https://github.com/steineggerlab/foldmason"
inputs:
  - id: input_structures
    type:
      type: array
      items: File
    doc: Input PDB or mmCIF files
    inputBinding:
      position: 1
  - id: input_stdin
    type: File
    doc: Input from stdin
    inputBinding:
      position: 2
  - id: tmp_dir
    type: Directory
    doc: Temporary directory
    inputBinding:
      position: 3
  - id: bitfactor_3di
    type:
      - 'null'
      - float
    doc: 3Di matrix bit factor
    default: 2.1
    inputBinding:
      position: 104
      prefix: --bitfactor-3di
  - id: bitfactor_aa
    type:
      - 'null'
      - float
    doc: AA matrix bit factor
    default: 1.1
    inputBinding:
      position: 104
      prefix: --bitfactor-aa
  - id: chain_name_mode
    type:
      - 'null'
      - int
    doc: 'Add chain to name: 0: auto, 1: always add'
    default: 0
    inputBinding:
      position: 104
      prefix: --chain-name-mode
  - id: comp_bias_corr
    type:
      - 'null'
      - int
    doc: Correct for locally biased amino acid composition (range 0-1)
    default: 1
    inputBinding:
      position: 104
      prefix: --comp-bias-corr
  - id: coord_store_mode
    type:
      - 'null'
      - int
    doc: 'Coordinate storage mode: 1: C-alpha as float, 2: C-alpha as difference (uint16_t)'
    default: 2
    inputBinding:
      position: 104
      prefix: --coord-store-mode
  - id: db_extraction_mode
    type:
      - 'null'
      - int
    doc: 'createdb extraction mode: 0: chain 1: interface'
    default: 0
    inputBinding:
      position: 104
      prefix: --db-extraction-mode
  - id: diff
    type:
      - 'null'
      - int
    doc: Filter MSAs by selecting most diverse set of sequences, keeping at 
      least this many seqs in each MSA block of length 50
    inputBinding:
      position: 104
      prefix: --diff
  - id: distance_threshold
    type:
      - 'null'
      - float
    doc: Residues with C-beta below this threshold will be part of interface
    default: 8.0
    inputBinding:
      position: 104
      prefix: --distance-threshold
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Fast mode, disable residue neighbourhood similarity scoring
    default: 0
    inputBinding:
      position: 104
      prefix: --fast
  - id: file_exclude
    type:
      - 'null'
      - string
    doc: Exclude file names based on this regex
    default: ^$
    inputBinding:
      position: 104
      prefix: --file-exclude
  - id: file_include
    type:
      - 'null'
      - string
    doc: Include file names based on this regex
    default: .*
    inputBinding:
      position: 104
      prefix: --file-include
  - id: filter_msa
    type:
      - 'null'
      - int
    doc: 'Filter msa: 0: do not filter, 1: filter'
    default: 1
    inputBinding:
      position: 104
      prefix: --filter-msa
  - id: gap_extend
    type:
      - 'null'
      - string
    doc: Gap extension cost
    default: aa:2,nucl:2
    inputBinding:
      position: 104
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - string
    doc: Gap open cost
    default: aa:25,nucl:25
    inputBinding:
      position: 104
      prefix: --gap-open
  - id: gpu
    type:
      - 'null'
      - int
    doc: Use GPU (CUDA) if possible
    default: 0
    inputBinding:
      position: 104
      prefix: --gpu
  - id: guide_tree
    type:
      - 'null'
      - string
    doc: Guide tree in Newick format
    default: ''
    inputBinding:
      position: 104
      prefix: --guide-tree
  - id: input_format
    type:
      - 'null'
      - int
    doc: 'Format of input structures: 0: Auto-detect by extension, 1: PDB, 2: mmCIF,
      3: mmJSON, 4: ChemComp, 5: Foldcomp'
    default: 0
    inputBinding:
      position: 104
      prefix: --input-format
  - id: mask_bfactor_threshold
    type:
      - 'null'
      - float
    doc: mask residues for seeding if b-factor < thr
    default: 0.0
    inputBinding:
      position: 104
      prefix: --mask-bfactor-threshold
  - id: mask_profile
    type:
      - 'null'
      - int
    doc: Mask query sequence of profile using tantan
    default: 1
    inputBinding:
      position: 104
      prefix: --mask-profile
  - id: match_ratio
    type:
      - 'null'
      - float
    doc: Columns that have a residue in this ratio of all sequences are kept
    default: 0.9
    inputBinding:
      position: 104
      prefix: --match-ratio
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length
    default: 65535
    inputBinding:
      position: 104
      prefix: --max-seq-len
  - id: model_name_mode
    type:
      - 'null'
      - int
    doc: 'Add model to name: 0: auto, 1: always add'
    default: 0
    inputBinding:
      position: 104
      prefix: --model-name-mode
  - id: nb_ang_cut
    type:
      - 'null'
      - float
    doc: Maximum distance cutoff (angstrom) for neighboring residues
    default: 45.0
    inputBinding:
      position: 104
      prefix: --nb-ang-cut
  - id: nb_low_cut
    type:
      - 'null'
      - float
    doc: Minimum neighborhood score threshold
    default: 0.02
    inputBinding:
      position: 104
      prefix: --nb-low-cut
  - id: nb_multiplier
    type:
      - 'null'
      - float
    doc: Neighborhood score multiplier
    default: 13.0
    inputBinding:
      position: 104
      prefix: --nb-multiplier
  - id: nb_sigma
    type:
      - 'null'
      - float
    doc: Neighborhood score decay constant
    default: 3.841
    inputBinding:
      position: 104
      prefix: --nb-sigma
  - id: only_scoring_cols
    type:
      - 'null'
      - boolean
    doc: Normalise LDDT by no. scoring columns
    default: 0
    inputBinding:
      position: 104
      prefix: --only-scoring-cols
  - id: pair_threshold
    type:
      - 'null'
      - float
    doc: '% of pair subalignments with LDDT information'
    default: 0.0
    inputBinding:
      position: 104
      prefix: --pair-threshold
  - id: precluster
    type:
      - 'null'
      - boolean
    doc: Pre-cluster structures before constructing MSA
    default: 0
    inputBinding:
      position: 104
      prefix: --precluster
  - id: prostt5_model
    type:
      - 'null'
      - string
    doc: Path to ProstT5 model
    default: ''
    inputBinding:
      position: 104
      prefix: --prostt5-model
  - id: pseudo_cnt_mode
    type:
      - 'null'
      - int
    doc: 'use 0: substitution-matrix or 1: context-specific pseudocounts'
    default: 0
    inputBinding:
      position: 104
      prefix: --pseudo-cnt-mode
  - id: qsc
    type:
      - 'null'
      - float
    doc: Reduce diversity of output MSAs using min. score per aligned residue 
      with query sequences
    default: -20.0
    inputBinding:
      position: 104
      prefix: --qsc
  - id: recompute_scores
    type:
      - 'null'
      - boolean
    doc: Recompute all-vs-all alignment scores every iteration
    default: 0
    inputBinding:
      position: 104
      prefix: --recompute-scores
  - id: refine_iters
    type:
      - 'null'
      - int
    doc: Number of alignment refinement iterations
    default: 0
    inputBinding:
      position: 104
      prefix: --refine-iters
  - id: refine_seed
    type:
      - 'null'
      - int
    doc: Random number generator seed
    default: -1
    inputBinding:
      position: 104
      prefix: --refine-seed
  - id: report_command
    type:
      - 'null'
      - string
    doc: Report command
    default: ''
    inputBinding:
      position: 104
      prefix: --report-command
  - id: report_mode
    type:
      - 'null'
      - int
    doc: 'MSA report mode 0: AA/3Di FASTA files only, 1: Compute LDDT and generate
      HTML report, 2: Compute LDDT and generate JSON'
    default: 0
    inputBinding:
      position: 104
      prefix: --report-mode
  - id: report_paths
    type:
      - 'null'
      - boolean
    doc: Report paths
    default: 1
    inputBinding:
      position: 104
      prefix: --report-paths
  - id: score_bias_pssm
    type:
      - 'null'
      - float
    doc: PSSM score bias
    default: -0.6
    inputBinding:
      position: 104
      prefix: --score-bias-pssm
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file
    default: aa:3di.out,nucl:3di.out
    inputBinding:
      position: 104
      prefix: --sub-mat
  - id: sw_gap_extend
    type:
      - 'null'
      - int
    doc: Gap extension cost for all-vs-all Smith-Waterman alignment
    default: 8
    inputBinding:
      position: 104
      prefix: --sw-gap-extend
  - id: sw_gap_open
    type:
      - 'null'
      - int
    doc: Gap open cost for all-vs-all Smith-Waterman alignment
    default: 9
    inputBinding:
      position: 104
      prefix: --sw-gap-open
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    default: 20
    inputBinding:
      position: 104
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    default: 3
    inputBinding:
      position: 104
      prefix: -v
  - id: wg
    type:
      - 'null'
      - boolean
    doc: Use global sequence weighting for profile calculation
    default: 1
    inputBinding:
      position: 104
      prefix: --wg
  - id: write_lookup
    type:
      - 'null'
      - int
    doc: write .lookup file containing mapping from internal id, fasta id and 
      file number
    default: 1
    inputBinding:
      position: 104
      prefix: --write-lookup
  - id: write_mapping
    type:
      - 'null'
      - int
    doc: write _mapping file containing mapping from internal id to taxonomic 
      identifier
    default: 0
    inputBinding:
      position: 104
      prefix: --write-mapping
outputs:
  - id: alignment_file
    type: File
    doc: Output alignment file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldmason:4.dd3c235--h5021889_0
