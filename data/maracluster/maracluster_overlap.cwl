cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maracluster
  - overlap
label: maracluster_overlap
doc: "MaRaCluster version 1.02.1, Build Date Aug 11 2022 12:04:26\nCopyright (c) 2015-19 Matthew The. All rights reserved.\nWritten by Matthew The (matthewt@kth.se) in the\nSchool of Biotechnology at the Royal Institute of Technology in Stockholm.\n\nCalculate and cluster p-values in the overlap between two neighbouring precursor m/z batches.\n\nTool homepage: https://github.com/statisticalbiotechnology/maracluster"
inputs:
  - id: index_dir
    type: Directory
    doc: "Output folder of maracluster index (or batch), staged writable under the name given by output_folder."
  - id: batch_file
    type: File
    doc: "File with spectrum files to be processed in batch, one per line. Files should be readable by ProteoWizard (e.g. ms2, mgf, mzML)."
    inputBinding:
      position: 101
      prefix: --batch
  - id: dat_fn_file
    type: string
    doc: "File with a list of binary spectrum files, one per line"
    inputBinding:
      position: 102
      prefix: --datFNfile
  - id: overlap_batch_idx
    type: int
    doc: "Index of overlap to process, requires datFNfile to be specified."
    inputBinding:
      position: 103
      prefix: --overlapBatchIdx
  - id: output_folder
    type: string
    doc: "Writable folder for output files (default - ./maracluster_output)."
    default: maracluster_output
    inputBinding:
      position: 104
      prefix: --output-folder
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
  - id: verbatim
    type:
      - 'null'
      - int
    doc: "Set the verbatim level (lowest 0, highest 5, default 3)."
    inputBinding:
      position: 107
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
stdout: maracluster_overlap.out
stderr: maracluster_overlap.err
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maracluster:1.02.1_cv1
