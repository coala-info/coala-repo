cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maracluster
  - consensus
label: maracluster_consensus
doc: "MaRaCluster version 1.02.1, Build Date Aug 11 2022 12:04:26\nCopyright (c) 2015-19 Matthew The. All rights reserved.\nWritten by Matthew The (matthewt@kth.se) in the\nSchool of Biotechnology at the Royal Institute of Technology in Stockholm.\n\nCreate consensus spectra from a cluster file.\n\nTool homepage: https://github.com/statisticalbiotechnology/maracluster"
inputs:
  - id: spectrum_files
    type:
      type: array
      items: File
    doc: "Spectrum files named in the cluster file; staged in the working directory so that the names in the cluster file resolve."
  - id: cluster_file
    type: File
    doc: "Input file for generating consensus spectra containing filepaths and scan numbers, separated by tabs."
    inputBinding:
      position: 101
      prefix: --clusterFile
  - id: spec_out_path
    type: string
    doc: "Output file for the consensus spectra. Can be in any format supported by ProteoWizard (e.g. ms2, mzML)."
    inputBinding:
      position: 102
      prefix: --specOut
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: "Set the minimum size for a cluster for producing consensus spectra (default 1)."
    inputBinding:
      position: 103
      prefix: --minClusterSize
  - id: split_mass_charge_states
    type:
      - 'null'
      - boolean
    doc: "Split mass charge states in spectrum output file into separate spectrum copies with the same peak list (default - auto-detect from output file format)."
    inputBinding:
      position: 104
      prefix: --splitMassChargeStates
  - id: output_folder
    type: string
    doc: "Writable folder for output files (default - ./maracluster_output)."
    default: maracluster_output
    inputBinding:
      position: 105
      prefix: --output-folder
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Output files will be prefixed as e.g. <prefix>.clusters_p10.tsv (default - 'MaRaCluster')"
    inputBinding:
      position: 106
      prefix: --prefix
  - id: verbatim
    type:
      - 'null'
      - int
    doc: "Set the verbatim level (lowest 0, highest 5, default 3)."
    inputBinding:
      position: 107
      prefix: --verbatim
outputs:
  - id: consensus_spectra
    type:
      type: array
      items: File
    doc: Consensus spectra file(s); large outputs are split into .partN files
    outputBinding:
      glob: $(inputs.spec_out_path.split('.').slice(0, -1).join('.'))*
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
stdout: maracluster_consensus.out
stderr: maracluster_consensus.err
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maracluster:1.02.1_cv1
