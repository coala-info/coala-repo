cwlVersion: v1.2
class: CommandLineTool
baseCommand: minkemap
label: minkemap
doc: "MinkeMap: Circular Genome Visualization Tool\n\nTool homepage: https://github.com/erinyoung/MinkeMap"
inputs:
  - id: annotations
    type:
      - 'null'
      - File
    doc: 'CSV file for custom regions (cols: reference,start,stop,label,color)'
    inputBinding:
      position: 101
      prefix: --annotations
  - id: dpi
    type:
      - 'null'
      - int
    doc: Image resolution
    inputBinding:
      position: 101
      prefix: --dpi
  - id: exclude_genes
    type:
      - 'null'
      - string
    doc: Comma-separated list of terms to exclude from gene track (e.g. 
      'hypothetical,putative')
    inputBinding:
      position: 101
      prefix: --exclude-genes
  - id: gc_skew
    type:
      - 'null'
      - boolean
    doc: Add a GC Skew track to the center
    inputBinding:
      position: 101
      prefix: --gc-skew
  - id: highlights
    type:
      - 'null'
      - File
    doc: 'CSV file for background wedges (cols: start,end,color,label)'
    inputBinding:
      position: 101
      prefix: --highlights
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: Input sequencing files (FASTQ/FASTA)
    inputBinding:
      position: 101
      prefix: --input
  - id: input_file
    type:
      - 'null'
      - File
    doc: 'Manifest CSV file (cols: sample,read1,read2,type)'
    inputBinding:
      position: 101
      prefix: --input-file
  - id: label_size
    type:
      - 'null'
      - int
    doc: Font size for gene/annotation labels
    inputBinding:
      position: 101
      prefix: --label-size
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: Minimum query coverage % (0-100)
    inputBinding:
      position: 101
      prefix: --min-coverage
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum identity % (0-100)
    inputBinding:
      position: 101
      prefix: --min-identity
  - id: no_backbone
    type:
      - 'null'
      - boolean
    doc: Hide the black reference backbone
    inputBinding:
      position: 101
      prefix: --no-backbone
  - id: no_legend
    type:
      - 'null'
      - boolean
    doc: Hide the sample legend
    inputBinding:
      position: 101
      prefix: --no-legend
  - id: no_save_data
    type:
      - 'null'
      - boolean
    doc: Do not generate BED/CSV data files
    inputBinding:
      position: 101
      prefix: --no-save-data
  - id: palette
    type:
      - 'null'
      - string
    doc: Color palette
    inputBinding:
      position: 101
      prefix: --palette
  - id: reference
    type: File
    doc: Reference genome (FASTA or GenBank)
    inputBinding:
      position: 101
      prefix: --reference
  - id: title
    type:
      - 'null'
      - string
    doc: Plot title
    inputBinding:
      position: 101
      prefix: --title
  - id: track_gap
    type:
      - 'null'
      - int
    doc: Gap between tracks
    default: 4
    inputBinding:
      position: 101
      prefix: --track-gap
  - id: track_width
    type:
      - 'null'
      - int
    doc: Width of each track ring
    default: 6
    inputBinding:
      position: 101
      prefix: --track-width
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable debug logging
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output filename
    outputBinding:
      glob: $(inputs.output)
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to save all output files
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minkemap:0.1.0--pyhdfd78af_0
