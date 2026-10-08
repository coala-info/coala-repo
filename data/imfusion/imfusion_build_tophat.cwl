cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - imfusion-build
  - tophat
label: imfusion_build_tophat
doc: "Build an augmented reference (reference genome plus transposon sequence) and its Tophat2 index for IM-Fusion.\n\nTool homepage: https://github.com/NKI-CCB/imfusion"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference_seq)
        writable: true
      - entry: $(inputs.transposon_seq)
        writable: true
inputs:
  - id: reference_seq
    type: File
    doc: Path to the reference sequence (in Fasta format).
    inputBinding:
      position: 1
      prefix: --reference_seq
  - id: reference_gtf
    type: File
    doc: Path to the reference gtf file.
    inputBinding:
      position: 1
      prefix: --reference_gtf
  - id: transposon_seq
    type: File
    doc: Path to the transposon sequence (in Fasta format).
    inputBinding:
      position: 1
      prefix: --transposon_seq
  - id: transposon_features
    type: File
    doc: Path to the transposon features (tsv).
    inputBinding:
      position: 1
      prefix: --transposon_features
  - id: output_dir
    type: string
    doc: Path to write the built reference. Must not exist yet.
    inputBinding:
      position: 1
      prefix: --output_dir
  - id: blacklist_regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Regions of the reference to blacklist. Should be specified as 
      'chromosome:start-end'.
    inputBinding:
      position: 1
      prefix: --blacklist_regions
  - id: blacklist_genes
    type:
      - 'null'
      - type: array
        items: string
    doc: Genes to blacklist. Should correspond with the gene ids used in the 
      reference gtf file.
    inputBinding:
      position: 1
      prefix: --blacklist_genes
  - id: skip_index
    type:
      - 'null'
      - boolean
    doc: Whether to skip the building of the genome indices. Mainly used for 
      debugging purposes.
    inputBinding:
      position: 1
      prefix: --skip_index
outputs:
  - id: reference_dir
    type: Directory
    doc: The built augmented reference with its Tophat2 index.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
