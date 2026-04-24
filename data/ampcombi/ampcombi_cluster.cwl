cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ampcombi
  - cluster
label: ampcombi_cluster
doc: "Clustering of AMPs using mmseqs2 based on the Ampcombi summary results.\n\n
  Tool homepage: https://github.com/Darcy220606/AMPcombi"
inputs:
  - id: ampcombi_summary
    type:
      - 'null'
      - File
    doc: Enter a file path corresponding to the Ampcombi_summary.tsv that can be generated
      by running --ampcombi complete.
    inputBinding:
      position: 101
      prefix: --ampcombi_summary
  - id: cluster_cov_mode
    type:
      - 'null'
      - int
    doc: This assigns the cov. mode to the mmseqs2 cluster module. More information
      can be obtained in mmseqs2 docs.
    inputBinding:
      position: 101
      prefix: --cluster_cov_mode
  - id: cluster_coverage
    type:
      - 'null'
      - float
    doc: This assigns the coverage to the mmseqs2 cluster module. More information
      can be obtained in mmseqs2 docs.
    inputBinding:
      position: 101
      prefix: --cluster_coverage
  - id: cluster_min_member
    type:
      - 'null'
      - int
    doc: This removes any cluster that has a hit number lower than this
    inputBinding:
      position: 101
      prefix: --cluster_min_member
  - id: cluster_mode
    type:
      - 'null'
      - string
    doc: This assigns the cluster mode to the mmseqs2 cluster module. More information
      can be obtained in mmseqs2 docs.
    inputBinding:
      position: 101
      prefix: --cluster_mode
  - id: cluster_remove_singletons
    type:
      - 'null'
      - boolean
    doc: This removes any hits that did not form a cluster
    inputBinding:
      position: 101
      prefix: --cluster_remove_singletons
  - id: cluster_retain_label
    type:
      - 'null'
      - string
    doc: This removes any cluster that only has a certain label in the sample name.
      For example if you have samples labels with 'S1_metaspades' and 'S1_megahit',
      you can retain clusters that have samples with suffix '_megahit' by running
      '--retain_clusters_label megahit'
    inputBinding:
      position: 101
      prefix: --cluster_retain_label
  - id: cluster_sensitivity
    type:
      - 'null'
      - float
    doc: This assigns sensitivity of alignment to the mmseqs2 cluster module. More
      information can be obtained in mmseqs2 docs.
    inputBinding:
      position: 101
      prefix: --cluster_sensitivity
  - id: cluster_seq_id
    type:
      - 'null'
      - float
    doc: This assigns the seqsid to the mmseqs2 cluster module. More information can
      be obtained in mmseqs2 docs.
    inputBinding:
      position: 101
      prefix: --cluster_seq_id
  - id: threads
    type:
      - 'null'
      - int
    doc: Changes the threads used for DIAMOND alignment
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: log
    type:
      - 'null'
      - File
    doc: Silences the standard output and captures it in a log file
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ampcombi:2.0.1--pyhdfd78af_0
