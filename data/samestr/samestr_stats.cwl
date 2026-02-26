cwlVersion: v1.2
class: CommandLineTool
baseCommand: samestr_stats
label: samestr_stats
doc: "Report statistics on SNV profiles.\n\nTool homepage: https://github.com/danielpodlesny/samestr/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Path to input SNV profiles. Should have .npy, .npz or .npy.gz 
      extension.
    default: []
    inputBinding:
      position: 1
  - id: input_names
    type:
      type: array
      items: File
    doc: Path to input name files.
    default: []
    inputBinding:
      position: 2
  - id: dominant_variants
    type:
      - 'null'
      - boolean
    doc: Report statistics only for dominant variants as obtained from consensus
      call.
    default: false
    inputBinding:
      position: 103
      prefix: --dominant-variants
  - id: marker_dir
    type: Directory
    doc: Path to MetaPhlAn or mOTUs clade marker database.
    inputBinding:
      position: 103
      prefix: --marker-dir
  - id: nprocs
    type:
      - 'null'
      - int
    doc: The number of processing units to use.
    default: 1
    inputBinding:
      position: 103
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
