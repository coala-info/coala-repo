cwlVersion: v1.2
class: CommandLineTool
baseCommand: maracluster
label: maracluster_batch
doc: "MaRaCluster version 1.02.1, Build Date Aug 11 2022 12:04:26\nCopyright (c) 2015-19
  Matthew The. All rights reserved.\nWritten by Matthew The (matthewt@kth.se) in the\n\
  School of Biotechnology at the Royal Institute of Technology in Stockholm.\n\nTool
  homepage: https://github.com/statisticalbiotechnology/maracluster"
inputs:
  - id: msfile_list
    type: File
    doc: File with spectrum files to be processed in batch, one per line. Files 
      should be readable by ProteoWizard (e.g. ms2, mgf, mzML).
    inputBinding:
      position: 1
  - id: batch_file
    type: File
    doc: File with spectrum files to be processed in batch, one per line. Files 
      should be readable by ProteoWizard (e.g. ms2, mgf, mzML).
    inputBinding:
      position: 102
      prefix: --batch
  - id: charge_uncertainty
    type:
      - 'null'
      - int
    doc: 'Set charge uncertainty, i.e. if set to 1, then for a spectrum with precursor
      ion charge C, also precursor ion charges C-1 and C+1 are considered (default:
      0).'
    default: 0
    inputBinding:
      position: 102
      prefix: --chargeUncertainty
  - id: cluster_file
    type:
      - 'null'
      - File
    doc: Input file for generating consensus spectra containing filepaths and 
      scan numbers, separated by tabs.
    inputBinding:
      position: 102
      prefix: --clusterFile
  - id: cluster_thresholds
    type:
      - 'null'
      - string
    doc: 'Clustering thresholds at which to produce cluster files; listed as a comma
      separated list (default: -30.0,-25.0,-20.0,-15.0,-10.0,-5.0)'
    default: -30.0,-25.0,-20.0,-15.0,-10.0,-5.0
    inputBinding:
      position: 102
      prefix: --clusterThresholds
  - id: clustering_matrix
    type:
      - 'null'
      - File
    doc: File containing the pvalue distance matrix input used for clustering in
      binary format.
    inputBinding:
      position: 102
      prefix: --clusteringMatrix
  - id: clustering_tree
    type:
      - 'null'
      - File
    doc: File containing the clustering tree result as a list of merged scannrs 
      with corresponding p value.
    inputBinding:
      position: 102
      prefix: --clusteringTree
  - id: dat_fn_file
    type:
      - 'null'
      - File
    doc: File with a list of binary spectrum files, one per line
    inputBinding:
      position: 102
      prefix: --datFNfile
  - id: lib
    type:
      - 'null'
      - File
    doc: File readable by ProteoWizard (e.g. ms2, mzML) with spectral library
    inputBinding:
      position: 102
      prefix: --lib
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: 'Set the minimum size for a cluster for producing consensus spectra (default:
      1).'
    default: 1
    inputBinding:
      position: 102
      prefix: --minClusterSize
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: 'Writable folder for output files (default: ./maracluster_output).'
    default: ./maracluster_output
    inputBinding:
      position: 102
      prefix: --output-folder
  - id: overlap_batch
    type:
      - 'null'
      - File
    doc: 'File with 2 tab separated columns as: tail_file <tab> head_file for which
      overlapping p-values should be calculated'
    inputBinding:
      position: 102
      prefix: --overlapBatch
  - id: overlap_batch_idx
    type:
      - 'null'
      - File
    doc: Index of overlap to process, requires -j/--datFNfile to be specified.
    inputBinding:
      position: 102
      prefix: --overlapBatchIdx
  - id: peak_counts_fn
    type:
      - 'null'
      - File
    doc: File to write/read peak counts binary file
    inputBinding:
      position: 102
      prefix: --peakCountsFN
  - id: precursor_tolerance
    type:
      - 'null'
      - string
    doc: 'Set precursor tolerance in units of ppm or Da. The units have to be "Da"
      or "ppm", case sensitive; if no unit is specified ppm is assumed (default: 20.0ppm).'
    default: 20.0ppm
    inputBinding:
      position: 102
      prefix: --precursorTolerance
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Output files will be prefixed as e.g. <prefix>.clusters_p10.tsv (default:
      'MaRaCluster')"
    default: MaRaCluster
    inputBinding:
      position: 102
      prefix: --prefix
  - id: pval_threshold
    type:
      - 'null'
      - float
    doc: 'Set log(p-value) threshold (default: -5.0).'
    default: -5.0
    inputBinding:
      position: 102
      prefix: --pvalThreshold
  - id: pvalue_vec_file
    type:
      - 'null'
      - File
    doc: Input file with pvalue vectors
    inputBinding:
      position: 102
      prefix: --pvalueVecFile
  - id: scan_info_fn
    type:
      - 'null'
      - File
    doc: File to write/read scan number list binary file
    inputBinding:
      position: 102
      prefix: --scanInfoFN
  - id: skip_filter_and_sort
    type:
      - 'null'
      - boolean
    doc: Skips filtering and sorting of the input matrix, only use if the input 
      is a filtered and sorted binary list p-values.
    inputBinding:
      position: 102
      prefix: --skipFilterAndSort
  - id: spec_in
    type:
      - 'null'
      - File
    doc: Input file readable by ProteoWizard (e.g. ms2, mzML). For multiple 
      input files use the -b/--batch option instead.
    inputBinding:
      position: 102
      prefix: --specIn
  - id: split_mass_charge_states
    type:
      - 'null'
      - boolean
    doc: 'Split mass charge states in spectrum output file into separate spectrum
      copies with the same peak list, as some formats (e.g. mgf) and software packages
      (e.g. MS-GF+) do not support multiple charge states for a single peak list (default:
      auto-detect from output file format).'
    inputBinding:
      position: 102
      prefix: --splitMassChargeStates
  - id: verbatim
    type:
      - 'null'
      - int
    doc: 'Set the verbatim level (lowest: 0, highest: 5, default: 3).'
    default: 3
    inputBinding:
      position: 102
      prefix: --verbatim
outputs:
  - id: spec_out
    type:
      - 'null'
      - File
    doc: Output file for the consensus spectra. Can be in any format supported 
      by ProteoWizard (e.g. ms2, mzML).
    outputBinding:
      glob: $(inputs.spec_out)
  - id: pvec_out
    type:
      - 'null'
      - File
    doc: Output file basename for p-values vectors.
    outputBinding:
      glob: $(inputs.pvec_out)
  - id: pval_out
    type:
      - 'null'
      - File
    doc: File where p-values will be written to.
    outputBinding:
      glob: $(inputs.pval_out)
  - id: perc_out
    type:
      - 'null'
      - File
    doc: Tab delimited percolator output file containing peptides and qvalues. 
      This is meant for annotation of the clusterfile.
    outputBinding:
      glob: $(inputs.perc_out)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maracluster:1.02.1_cv1
