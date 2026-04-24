cwlVersion: v1.2
class: CommandLineTool
baseCommand: samestr compare
label: samestr_compare
doc: "Compare SNV profiles between samples.\n\nTool homepage: https://github.com/danielpodlesny/samestr/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Path to input SNV Profiles. Should have .npy, .npz or .npy.gz 
      extension.
    inputBinding:
      position: 1
  - id: input_names
    type:
      type: array
      items: File
    doc: Path to input name files.
    inputBinding:
      position: 2
  - id: dominant_variants
    type:
      - 'null'
      - boolean
    doc: Compare only dominant variants as obtained from consensus call.
    inputBinding:
      position: 103
      prefix: --dominant-variants
  - id: dominant_variants_added
    type:
      - 'null'
      - boolean
    doc: Add dominant variants as additional entries to data.
    inputBinding:
      position: 103
      prefix: --dominant-variants-added
  - id: dominant_variants_msa
    type:
      - 'null'
      - boolean
    doc: Output alignment of dominant variants as fasta.
    inputBinding:
      position: 103
      prefix: --dominant-variants-msa
  - id: marker_dir
    type:
      - 'null'
      - Directory
    doc: Path to MetaPhlAn or mOTUs clade marker database.
    inputBinding:
      position: 103
      prefix: --marker-dir
  - id: nprocs
    type:
      - 'null'
      - int
    doc: The number of processing units to use.
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
