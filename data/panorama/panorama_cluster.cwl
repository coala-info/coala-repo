cwlVersion: v1.2
class: CommandLineTool
baseCommand: panorama cluster
label: panorama_cluster
doc: "Perform gene family clustering across multiple pangenomes using MMseqs2 with
  support for both fast (linclust) and sensitive (cluster) clustering methods.\n\n\
  Tool homepage: https://github.com/labgem/panorama"
inputs:
  - id: cluster_align_mode
    type:
      - 'null'
      - int
    doc: 'Alignment mode: 0=automatic, 1=only score, 2=only extended, 3=score+extended,
      4=fast+extended'
    inputBinding:
      position: 101
      prefix: --cluster_align_mode
  - id: cluster_comp_bias_corr
    type:
      - 'null'
      - int
    doc: 'Compositional bias correction: 0=disabled, 1=enabled'
    inputBinding:
      position: 101
      prefix: --cluster_comp_bias_corr
  - id: cluster_cov_mode
    type:
      - 'null'
      - int
    doc: 'Coverage mode: 0=query, 1=target, 2=shorter seq, 3=longer seq, 4=query and
      target, 5=shorter and longer seq.'
    inputBinding:
      position: 101
      prefix: --cluster_cov_mode
  - id: cluster_coverage
    type:
      - 'null'
      - float
    doc: Minimum coverage threshold (0.0-1.0).
    inputBinding:
      position: 101
      prefix: --cluster_coverage
  - id: cluster_eval
    type:
      - 'null'
      - float
    doc: E-value threshold.
    inputBinding:
      position: 101
      prefix: --cluster_eval
  - id: cluster_identity
    type:
      - 'null'
      - float
    doc: Minimum sequence identity threshold (0.0-1.0).
    inputBinding:
      position: 101
      prefix: --cluster_identity
  - id: cluster_kmer_per_seq
    type:
      - 'null'
      - int
    doc: Number of k-mers per sequence
    inputBinding:
      position: 101
      prefix: --cluster_kmer_per_seq
  - id: cluster_max_reject
    type:
      - 'null'
      - int
    doc: Maximum number of rejected sequences
    inputBinding:
      position: 101
      prefix: --cluster_max_reject
  - id: cluster_max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length
    inputBinding:
      position: 101
      prefix: --cluster_max_seq_len
  - id: cluster_max_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of sequences per cluster representative (cluster method 
      only)
    inputBinding:
      position: 101
      prefix: --cluster_max_seqs
  - id: cluster_min_ungapped
    type:
      - 'null'
      - int
    doc: Minimum ungapped alignment score (cluster method only)
    inputBinding:
      position: 101
      prefix: --cluster_min_ungapped
  - id: cluster_mode
    type:
      - 'null'
      - int
    doc: 'Clustering mode: 0=Set Cover, 1=Connected Component, 2=Greedy, 3=Greedy
      Low Memory'
    inputBinding:
      position: 101
      prefix: --cluster_mode
  - id: cluster_sensitivity
    type:
      - 'null'
      - float
    doc: Search sensitivity (cluster method only). Higher values = more 
      sensitive but slower
    inputBinding:
      position: 101
      prefix: --cluster_sensitivity
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep temporary files after completion (useful for debugging)
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: log
    type:
      - 'null'
      - string
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: method
    type: string
    doc: 'Clustering method: linclust (fast) or cluster (sensitive)'
    inputBinding:
      position: 101
      prefix: --method
  - id: pangenomes_file
    type: File
    doc: Path to TSV file containing list of pangenome .h5 files to process
    inputBinding:
      position: 101
      prefix: --pangenomes
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel processing.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Directory for temporary files.
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory where clustering results will be written
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
