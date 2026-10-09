cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maracluster
  - pvalue
label: maracluster_pvalue
doc: "MaRaCluster version 1.02.1, Build Date Aug 11 2022 12:04:26\nCopyright (c) 2015-19 Matthew The. All rights reserved.\nWritten by Matthew The (matthewt@kth.se) in the\nSchool of Biotechnology at the Royal Institute of Technology in Stockholm.\n\nCalculate p-values for one binary spectrum file (.dat) from maracluster index and cluster them into a p-value tree.\n\nTool homepage: https://github.com/statisticalbiotechnology/maracluster"
inputs:
  - id: index_dir
    type: Directory
    doc: "Output folder of maracluster index (or batch), staged writable under the name given by output_folder."
  - id: spec_in
    type: string
    doc: "Binary spectrum (.dat) file written by maracluster index, as a path inside the staged output folder, e.g. maracluster_output/268.dat"
    inputBinding:
      position: 101
      prefix: --specIn
  - id: batch_file
    type:
      - 'null'
      - File
    doc: "File with spectrum files to be processed in batch, one per line. Files should be readable by ProteoWizard (e.g. ms2, mgf, mzML)."
    inputBinding:
      position: 102
      prefix: --batch
  - id: peak_counts_fn
    type: string
    doc: "File to write/read peak counts binary file"
    inputBinding:
      position: 103
      prefix: --peakCountsFN
  - id: clustering_tree
    type:
      - 'null'
      - string
    doc: "File containing the clustering tree result as a list of merged scannrs with corresponding p value."
    inputBinding:
      position: 104
      prefix: --clusteringTree
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
  - id: precursor_tolerance
    type:
      - 'null'
      - string
    doc: "Set precursor tolerance in units of ppm or Da. The units have to be \"Da\" or \"ppm\", case sensitive; if no unit is specified ppm is assumed (default - 20.0ppm)."
    inputBinding:
      position: 107
      prefix: --precursorTolerance
  - id: pval_threshold
    type:
      - 'null'
      - float
    doc: "Set log(p-value) threshold (default - -5.0)."
    inputBinding:
      position: 108
      prefix: --pvalThreshold
  - id: pval_out_path
    type:
      - 'null'
      - string
    doc: "File where p-values will be written to."
    inputBinding:
      position: 109
      prefix: --pvalOut
  - id: pvec_out_path
    type:
      - 'null'
      - string
    doc: "Output file basename for p-values vectors."
    inputBinding:
      position: 110
      prefix: --pvecOut
  - id: verbatim
    type:
      - 'null'
      - int
    doc: "Set the verbatim level (lowest 0, highest 5, default 3)."
    inputBinding:
      position: 111
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
      - entry: $(inputs.index_dir)
        entryname: $(inputs.output_folder)
        writable: true
stdout: maracluster_pvalue.out
stderr: maracluster_pvalue.err
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maracluster:1.02.1_cv1
