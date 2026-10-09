cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maracluster
  - index
label: maracluster_index
doc: "MaRaCluster version 1.02.1, Build Date Aug 11 2022 12:04:26\nCopyright (c) 2015-19 Matthew The. All rights reserved.\nWritten by Matthew The (matthewt@kth.se) in the\nSchool of Biotechnology at the Royal Institute of Technology in Stockholm.\n\nConvert spectrum files to binary files and split them into batches by precursor m/z.\n\nTool homepage: https://github.com/statisticalbiotechnology/maracluster"
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
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Output files will be prefixed as e.g. <prefix>.clusters_p10.tsv (default - 'MaRaCluster')"
    inputBinding:
      position: 103
      prefix: --prefix
  - id: precursor_tolerance
    type:
      - 'null'
      - string
    doc: "Set precursor tolerance in units of ppm or Da. The units have to be \"Da\" or \"ppm\", case sensitive; if no unit is specified ppm is assumed (default - 20.0ppm)."
    inputBinding:
      position: 104
      prefix: --precursorTolerance
  - id: charge_uncertainty
    type:
      - 'null'
      - int
    doc: "Set charge uncertainty, i.e. if set to 1, then for a spectrum with precursor ion charge C, also precursor ion charges C-1 and C+1 are considered (default 0)."
    inputBinding:
      position: 105
      prefix: --chargeUncertainty
  - id: peak_counts_fn
    type:
      - 'null'
      - string
    doc: "File to write/read peak counts binary file"
    inputBinding:
      position: 106
      prefix: --peakCountsFN
  - id: scan_info_fn
    type:
      - 'null'
      - string
    doc: "File to write/read scan number list binary file"
    inputBinding:
      position: 107
      prefix: --scanInfoFN
  - id: dat_fn_file
    type:
      - 'null'
      - string
    doc: "File with a list of binary spectrum files, one per line"
    inputBinding:
      position: 108
      prefix: --datFNfile
  - id: verbatim
    type:
      - 'null'
      - int
    doc: "Set the verbatim level (lowest 0, highest 5, default 3)."
    inputBinding:
      position: 109
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
    listing: $(inputs.spectrum_files)
stdout: maracluster_index.out
stderr: maracluster_index.err
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maracluster:1.02.1_cv1
