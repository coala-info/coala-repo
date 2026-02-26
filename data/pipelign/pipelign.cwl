cwlVersion: v1.2
class: CommandLineTool
baseCommand: pipelign
label: pipelign
doc: "creates multiple sequence alignment from FASTA formatted sequence file\n\nTool
  homepage: https://github.com/asmmhossain/pipelign/"
inputs:
  - id: alphabet
    type:
      - 'null'
      - string
    doc: Input sequences can be dna/rna/aa
    default: dna
    inputBinding:
      position: 101
      prefix: --alphabet
  - id: ambig_per
    type:
      - 'null'
      - float
    doc: Proportion of ambiguous characters allowed in the long sequences
    default: 0.1
    inputBinding:
      position: 101
      prefix: --ambigPer
  - id: clear_existing_directory
    type:
      - 'null'
      - boolean
    doc: Remove files from existing output directory
    inputBinding:
      position: 101
      prefix: --clearExistingDirectory
  - id: exclude_clusters
    type:
      - 'null'
      - boolean
    doc: Exclude clusters from final alignment
    inputBinding:
      position: 101
      prefix: --excludeClusters
  - id: input_file
    type: File
    doc: Input sequence file in FASTA format
    inputBinding:
      position: 101
      prefix: --inFile
  - id: keep_bad_seqs
    type:
      - 'null'
      - boolean
    doc: Add long sequences with too many ambiguous residues
    inputBinding:
      position: 101
      prefix: --keepBadSeqs
  - id: keep_orphans
    type:
      - 'null'
      - boolean
    doc: Add fragments without clusters
    inputBinding:
      position: 101
      prefix: --keepOrphans
  - id: len_thr
    type:
      - 'null'
      - float
    doc: Length threshold for full sequences
    default: 0.7
    inputBinding:
      position: 101
      prefix: --lenThr
  - id: m_iterate_long
    type:
      - 'null'
      - int
    doc: Number of iterations to refine long alignments
    default: 1
    inputBinding:
      position: 101
      prefix: --mIterateLong
  - id: m_iterate_merge
    type:
      - 'null'
      - int
    doc: Number of iterations to refine merged alignment
    default: 1
    inputBinding:
      position: 101
      prefix: --mIterateMerge
  - id: m_zip
    type:
      - 'null'
      - boolean
    doc: Create zipped intermediate output files
    inputBinding:
      position: 101
      prefix: --mZip
  - id: merge
    type:
      - 'null'
      - string
    doc: Merge using (P)arallel/(C)onsensus strategy
    default: P
    inputBinding:
      position: 101
      prefix: --merge
  - id: out_dir
    type: Directory
    doc: Name for output directory to hold intermediate files
    inputBinding:
      position: 101
      prefix: --outDir
  - id: run
    type:
      - 'null'
      - string
    doc: Run either (J)oblib/(G)NU parallel version
    default: G
    inputBinding:
      position: 101
      prefix: --run
  - id: sim_per
    type:
      - 'null'
      - float
    doc: Percent sequence similarity for clustering
    default: 0.8
    inputBinding:
      position: 101
      prefix: --simPer
  - id: stage
    type:
      - 'null'
      - int
    doc: "1  Make cluster alignments and HMM of long sequences\n                 \
      \       2  Align long sequences only\n                        3  Assign fragments
      to clusters\n                        4  Make cluster alignments with fragments\n\
      \                        5  Align all sequences"
    inputBinding:
      position: 101
      prefix: --stage
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU/threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --thread
outputs:
  - id: output_file
    type: File
    doc: FASTA formatted output alignment file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pipelign:0.2--py36_0
