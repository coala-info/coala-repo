cwlVersion: v1.2
class: CommandLineTool
baseCommand: kMetaShot_classifier_NV.py
label: kmetashot_kMetaShot_classifier_NV.py
doc: "kMetaShot is able to taxonomically classiy bins/MAGs and long reads by using
  an alignment free and k-mer/minimizer based approach.\n\nTool homepage: https://github.com/gdefazio/kMetaShot"
inputs:
  - id: ass2ref
    type:
      - 'null'
      - float
    doc: Classification filtering based on ass2ref parameter ranging between 0 
      and 1.
    inputBinding:
      position: 101
      prefix: --ass2ref
  - id: bins_dir
    type: Directory
    doc: Path to directory containing bins or path to multi-fasta file
    inputBinding:
      position: 101
      prefix: --bins_dir
  - id: processes
    type: int
    doc: 'Multiprocess parallelism. Warning: high parallelism <==> high RAM usage'
    inputBinding:
      position: 101
      prefix: --processes
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: Path to HDF5 file containing reference
    inputBinding:
      position: 101
      prefix: --reference
  - id: out_dir_path
    type: Directory
    doc: Output or path parameter `out_dir_path`
    inputBinding:
      position: 102
      prefix: --out-dir
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output file path name
    outputBinding:
      glob: $(inputs.out_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmetashot:2.0--pyh7e72e81_1
