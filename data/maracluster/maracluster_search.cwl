cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maracluster
  - search
label: maracluster_search
doc: "MaRaCluster version 1.02.1, Build Date Aug 11 2022 12:04:26\nCopyright (c) 2015-19 Matthew The. All rights reserved.\nWritten by Matthew The (matthewt@kth.se) in the\nSchool of Biotechnology at the Royal Institute of Technology in Stockholm.\n\nSearch query spectra against a spectral library and write the p-values.\n\nTool homepage: https://github.com/statisticalbiotechnology/maracluster"
inputs:
  - id: lib
    type: File
    doc: "File readable by ProteoWizard (e.g. ms2, mzML) with spectral library"
    inputBinding:
      position: 101
      prefix: --lib
  - id: spec_in
    type: File
    doc: "Input file readable by ProteoWizard (e.g. ms2, mzML). For multiple input files use the batch file option instead."
    inputBinding:
      position: 102
      prefix: --specIn
  - id: output_folder
    type: string
    doc: "Writable folder for output files (default - ./maracluster_output)."
    default: maracluster_output
    inputBinding:
      position: 103
      prefix: --output-folder
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Output files will be prefixed as e.g. <prefix>.clusters_p10.tsv (default - 'MaRaCluster')"
    inputBinding:
      position: 104
      prefix: --prefix
  - id: precursor_tolerance
    type:
      - 'null'
      - string
    doc: "Set precursor tolerance in units of ppm or Da. The units have to be \"Da\" or \"ppm\", case sensitive; if no unit is specified ppm is assumed (default - 20.0ppm)."
    inputBinding:
      position: 105
      prefix: --precursorTolerance
  - id: pval_threshold
    type:
      - 'null'
      - float
    doc: "Set log(p-value) threshold (default - -5.0)."
    inputBinding:
      position: 106
      prefix: --pvalThreshold
  - id: peak_counts_fn
    type:
      - 'null'
      - string
    doc: "File to write/read peak counts binary file"
    inputBinding:
      position: 107
      prefix: --peakCountsFN
  - id: pval_out_path
    type:
      - 'null'
      - string
    doc: "File where p-values will be written to."
    inputBinding:
      position: 108
      prefix: --pvalOut
  - id: pvec_out_path
    type:
      - 'null'
      - string
    doc: "Output file basename for p-values vectors."
    inputBinding:
      position: 109
      prefix: --pvecOut
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
stdout: maracluster_search.out
stderr: maracluster_search.err
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maracluster:1.02.1_cv1
