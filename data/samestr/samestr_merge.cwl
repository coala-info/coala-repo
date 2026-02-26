cwlVersion: v1.2
class: CommandLineTool
baseCommand: samestr_merge
label: samestr_merge
doc: "Merge SNV profiles from multiple samples.\n\nTool homepage: https://github.com/danielpodlesny/samestr/"
inputs:
  - id: clade
    type:
      - 'null'
      - type: array
        items: string
    doc: Clade to process from input files. Processing all if not specified. 
      Names must correspond to the taxonomy of the respective database [e.g. 
      t__SGB10068 for MetaPhlAn or ref_mOTU_v3_00095 for mOTUs]
    default: None
    inputBinding:
      position: 101
      prefix: --clade
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: Path to input SNV profiles. Should have .npy, .npz or .npy.gz 
      extension.
    default: None
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to input SNV profiles. Should have .npy, .npz or .npy.gz 
      extension.
    default: []
    inputBinding:
      position: 101
      prefix: --input-files
  - id: marker_dir
    type: Directory
    doc: Path to MetaPhlAn or mOTUs clade marker database.
    default: None
    inputBinding:
      position: 101
      prefix: --marker-dir
  - id: nprocs
    type:
      - 'null'
      - int
    doc: The number of processing units to use.
    default: 1
    inputBinding:
      position: 101
      prefix: --nprocs
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to output directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samestr:1.2025.111--pyhdfd78af_0
