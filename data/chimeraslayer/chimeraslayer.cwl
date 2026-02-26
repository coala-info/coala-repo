cwlVersion: v1.2
class: CommandLineTool
baseCommand: chimeraslayer
label: chimeraslayer
doc: Tool for identifying chimeric sequences.
inputs:
  - id: db_fasta
    type:
      - 'null'
      - File
    doc: db in fasta format (megablast formatted)
    default: /usr/share/microbiomeutil-data/RESOURCES/rRNA16S.gold.fasta
    inputBinding:
      position: 101
      prefix: --db_FASTA
  - id: db_nast
    type:
      - 'null'
      - File
    doc: db in NAST format
    default: 
      /usr/share/microbiomeutil-data/RESOURCES/rRNA16S.gold.NAST_ALIGNED.fasta
    inputBinding:
      position: 101
      prefix: --db_NAST
  - id: exec_dir
    type:
      - 'null'
      - Directory
    doc: chdir to here before running
    inputBinding:
      position: 101
      prefix: --exec_dir
  - id: low_range_finer_bs
    type:
      - 'null'
      - int
    doc: If computed BS is between minBS and (minBS - low_range_finer_BS), then 
      num_finer_BS_replicates computed.
    default: 10
    inputBinding:
      position: 101
      prefix: --low_range_finer_BS
  - id: match_score
    type:
      - 'null'
      - int
    doc: match score
    default: 5
    inputBinding:
      position: 101
      prefix: -M
  - id: max_chimera_parent_per_id
    type:
      - 'null'
      - int
    doc: Chimera/Parent alignments with perID above this are considered 
      non-chimeras (default 100; turned off)
    default: 100
    inputBinding:
      position: 101
      prefix: --MAX_CHIMERA_PARENT_PER_ID
  - id: max_traverses
    type:
      - 'null'
      - int
    doc: maximum traverses of the multiple alignment
    default: 1
    inputBinding:
      position: 101
      prefix: -T
  - id: min_bootstrap_support
    type:
      - 'null'
      - int
    doc: minimum bootstrap support for calling chimera
    default: 90
    inputBinding:
      position: 101
      prefix: --minBS
  - id: min_divergence_ratio
    type:
      - 'null'
      - float
    doc: min divergence ratio
    default: 1.007
    inputBinding:
      position: 101
      prefix: -R
  - id: min_percent_identity
    type:
      - 'null'
      - int
    doc: min percent identity among matching sequences
    default: 90
    inputBinding:
      position: 101
      prefix: -P
  - id: min_query_coverage
    type:
      - 'null'
      - int
    doc: min query coverage by matching database sequence
    default: 70
    inputBinding:
      position: 101
      prefix: -Q
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: mismatch penalty
    default: -4
    inputBinding:
      position: 101
      prefix: -N
  - id: num_bs_replicates
    type:
      - 'null'
      - int
    doc: number of bootstrap replicates
    default: 100
    inputBinding:
      position: 101
      prefix: --num_BS_replicates
  - id: num_finer_bs_replicates
    type:
      - 'null'
      - int
    doc: number of finer BS replicates
    default: 1000
    inputBinding:
      position: 101
      prefix: --num_finer_BS_replicates
  - id: num_parents_test
    type:
      - 'null'
      - int
    doc: number of potential parents to test for chimeras
    default: 3
    inputBinding:
      position: 101
      prefix: --num_parents_test
  - id: num_top_matches
    type:
      - 'null'
      - int
    doc: number of top matching database sequences to compare to
    default: 15
    inputBinding:
      position: 101
      prefix: -n
  - id: percent_snps_sample
    type:
      - 'null'
      - int
    doc: percent of SNPs to sample on each side of breakpoint for computing 
      bootstrap support
    default: 10
    inputBinding:
      position: 101
      prefix: -S
  - id: print_csalignments
    type:
      - 'null'
      - boolean
    doc: print ChimeraSlayer alignments in ChimeraSlayer output
    inputBinding:
      position: 101
      prefix: --printCSalignments
  - id: print_final_alignments
    type:
      - 'null'
      - boolean
    doc: shows alignment between query sequence and pair of candidate chimera 
      parents
    inputBinding:
      position: 101
      prefix: --printFinalAlignments
  - id: query_nast
    type: File
    doc: multi-fasta file containing query sequences in alignment format
    inputBinding:
      position: 101
      prefix: --query_NAST
  - id: window_size
    type:
      - 'null'
      - int
    doc: window size
    default: 50
    inputBinding:
      position: 101
      prefix: --windowSize
  - id: window_step
    type:
      - 'null'
      - int
    doc: window step
    default: 5
    inputBinding:
      position: 101
      prefix: --windowStep
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/chimeraslayer:v20101212dfsg1-2-deb_cv1
stdout: chimeraslayer.out
