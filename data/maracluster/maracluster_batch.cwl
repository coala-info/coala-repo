cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maracluster
  - batch
label: maracluster_batch
doc: "MaRaCluster version 1.02.1, Build Date Aug 11 2022 12:04:26\nCopyright (c) 2015-19 Matthew The. All rights reserved.\nWritten by Matthew The (matthewt@kth.se) in the\nSchool of Biotechnology at the Royal Institute of Technology in Stockholm.\n\nCluster MS/MS spectra from one or more spectrum files in a single run (index, p-values, clustering, optional consensus spectra).\n\nTool homepage: https://github.com/statisticalbiotechnology/maracluster"
inputs:
  - id: spectrum_files
    type:
      type: array
      items: File
    doc: "Spectrum files named in the batch file; staged in the working directory so that the names in the batch file resolve."
  - id: batch_file
    type: File
    doc: "File with spectrum files to be processed in batch, one per line. Files should be readable by ProteoWizard (e.g. ms2, mgf, mzML)."
    inputBinding:
      position: 101
      prefix: --batch
  - id: output_folder
    type: string
    doc: "Writable folder for output files (default - ./maracluster_output)."
    default: maracluster_output
    inputBinding:
      position: 102
      prefix: --output-folder
  - id: precursor_tolerance
    type:
      - 'null'
      - string
    doc: "Set precursor tolerance in units of ppm or Da. The units have to be \"Da\" or \"ppm\", case sensitive; if no unit is specified ppm is assumed (default - 20.0ppm)."
    inputBinding:
      position: 103
      prefix: --precursorTolerance
  - id: pval_threshold
    type:
      - 'null'
      - float
    doc: "Set log(p-value) threshold (default - -5.0)."
    inputBinding:
      position: 104
      prefix: --pvalThreshold
  - id: cluster_thresholds
    type:
      - 'null'
      - string
    doc: "Clustering thresholds at which to produce cluster files; listed as a comma separated list (default - -30.0,-25.0,-20.0,-15.0,-10.0,-5.0)"
    inputBinding:
      position: 105
      prefix: --clusterThresholds
  - id: verbatim
    type:
      - 'null'
      - int
    doc: "Set the verbatim level (lowest 0, highest 5, default 3)."
    inputBinding:
      position: 106
      prefix: --verbatim
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Output files will be prefixed as e.g. <prefix>.clusters_p10.tsv (default - 'MaRaCluster')"
    inputBinding:
      position: 107
      prefix: --prefix
  - id: cluster_file
    type:
      - 'null'
      - File
    doc: "Input file for generating consensus spectra containing filepaths and scan numbers, separated by tabs."
    inputBinding:
      position: 108
      prefix: --clusterFile
  - id: spec_out_path
    type:
      - 'null'
      - string
    doc: "Output file for the consensus spectra. Can be in any format supported by ProteoWizard (e.g. ms2, mzML)."
    inputBinding:
      position: 109
      prefix: --specOut
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: "Set the minimum size for a cluster for producing consensus spectra (default 1)."
    inputBinding:
      position: 110
      prefix: --minClusterSize
  - id: split_mass_charge_states
    type:
      - 'null'
      - boolean
    doc: "Split mass charge states in spectrum output file into separate spectrum copies with the same peak list (default - auto-detect from output file format)."
    inputBinding:
      position: 111
      prefix: --splitMassChargeStates
  - id: charge_uncertainty
    type:
      - 'null'
      - int
    doc: "Set charge uncertainty, i.e. if set to 1, then for a spectrum with precursor ion charge C, also precursor ion charges C-1 and C+1 are considered (default 0)."
    inputBinding:
      position: 112
      prefix: --chargeUncertainty
outputs:
  - id: output_folder_dir
    type: Directory
    doc: Output folder
    outputBinding:
      glob: $(inputs.output_folder)
  - id: consensus_spectra
    type:
      type: array
      items: File
    doc: Consensus spectra file(s), written when spec_out_path is given; large outputs are split into .partN files
    outputBinding:
      glob: "$(inputs.spec_out_path ? inputs.spec_out_path.split('.').slice(0, -1).join('.') + '*' : 'no_consensus_spectra')"
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (progress and cluster statistics)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.spectrum_files)
stdout: maracluster_batch.out
stderr: maracluster_batch.err
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maracluster:1.02.1_cv1
