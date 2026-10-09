cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maracluster
  - cluster
label: maracluster_cluster
doc: "MaRaCluster version 1.02.1, Build Date Aug 11 2022 12:04:26\nCopyright (c) 2015-19 Matthew The. All rights reserved.\nWritten by Matthew The (matthewt@kth.se) in the\nSchool of Biotechnology at the Royal Institute of Technology in Stockholm.\n\nCluster a p-value tree and write the cluster files for each threshold.\n\nTool homepage: https://github.com/statisticalbiotechnology/maracluster"
inputs:
  - id: spectrum_files
    type:
      type: array
      items: File
    doc: "Spectrum files named in the batch file; staged in the working directory so that the names in the batch file resolve."
  - id: index_dir
    type: Directory
    doc: "Output folder of maracluster index (or batch), staged writable under the name given by output_folder."
  - id: batch_file
    type: File
    doc: "File with spectrum files to be processed in batch, one per line. Files should be readable by ProteoWizard (e.g. ms2, mgf, mzML)."
    inputBinding:
      position: 101
      prefix: --batch
  - id: scan_info_fn
    type: string
    doc: "File to write/read scan number list binary file"
    inputBinding:
      position: 102
      prefix: --scanInfoFN
  - id: clustering_tree
    type:
      - 'null'
      - string
    doc: "File containing the clustering tree result as a list of merged scannrs with corresponding p value."
    inputBinding:
      position: 103
      prefix: --clusteringTree
  - id: clustering_matrix
    type:
      - 'null'
      - string
    doc: "File containing the pvalue distance matrix input used for clustering in binary format."
    inputBinding:
      position: 104
      prefix: --clusteringMatrix
  - id: skip_filter_and_sort
    type:
      - 'null'
      - boolean
    doc: "Skips filtering and sorting of the input matrix, only use if the input is a filtered and sorted binary list p-values."
    inputBinding:
      position: 105
      prefix: --skipFilterAndSort
  - id: output_folder
    type: string
    doc: "Writable folder for output files (default - ./maracluster_output)."
    default: maracluster_output
    inputBinding:
      position: 106
      prefix: --output-folder
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Output files will be prefixed as e.g. <prefix>.clusters_p10.tsv (default - 'MaRaCluster')"
    inputBinding:
      position: 107
      prefix: --prefix
  - id: cluster_thresholds
    type:
      - 'null'
      - string
    doc: "Clustering thresholds at which to produce cluster files; listed as a comma separated list (default - -30.0,-25.0,-20.0,-15.0,-10.0,-5.0)"
    inputBinding:
      position: 108
      prefix: --clusterThresholds
  - id: pval_threshold
    type:
      - 'null'
      - float
    doc: "Set log(p-value) threshold (default - -5.0)."
    inputBinding:
      position: 109
      prefix: --pvalThreshold
  - id: verbatim
    type:
      - 'null'
      - int
    doc: "Set the verbatim level (lowest 0, highest 5, default 3)."
    inputBinding:
      position: 110
      prefix: --verbatim
outputs:
  - id: output_folder_dir
    type: Directory
    doc: Output folder
    outputBinding:
      glob: $(inputs.output_folder)
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (progress and cluster statistics)
requirements:
  - class: InitialWorkDirRequirement
    listing: 
      - $(inputs.spectrum_files)
      - entry: $(inputs.index_dir)
        entryname: $(inputs.output_folder)
        writable: true
stdout: maracluster_cluster.out
stderr: maracluster_cluster.err
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maracluster:1.02.1_cv1
