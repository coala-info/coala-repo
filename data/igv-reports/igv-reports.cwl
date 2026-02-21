cwlVersion: v1.2
class: CommandLineTool
baseCommand: igv-reports
label: igv-reports
doc: "Generate self-contained HTML reports for viewing genomic data in IGV.\n\nTool
  homepage: https://github.com/igvteam/igv-reports"
inputs:
  - id: sites
    type: File
    doc: vcf, bed, or gff file of genomic sites
    inputBinding:
      position: 1
  - id: fasta
    type:
      - 'null'
      - File
    doc: Reference fasta file; genome or fasta is required
    inputBinding:
      position: 102
      prefix: --fasta
  - id: flanking
    type:
      - 'null'
      - int
    doc: Flanking region in base pairs
    default: 1000
    inputBinding:
      position: 102
      prefix: --flanking
  - id: genome
    type:
      - 'null'
      - string
    doc: IGV genome identifier (e.g. hg38)
    inputBinding:
      position: 102
      prefix: --genome
  - id: ideogram
    type:
      - 'null'
      - File
    doc: Ideogram file in cytoband format
    inputBinding:
      position: 102
      prefix: --ideogram
  - id: info_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: List of info columns to include in the report table
    inputBinding:
      position: 102
      prefix: --info-columns
  - id: standalone
    type:
      - 'null'
      - boolean
    doc: Embed all dependencies (IGV.js) in the output HTML file
    inputBinding:
      position: 102
      prefix: --standalone
  - id: template
    type:
      - 'null'
      - File
    doc: HTML template file
    inputBinding:
      position: 102
      prefix: --template
  - id: track_config
    type:
      - 'null'
      - type: array
        items: File
    doc: List of track configuration files
    inputBinding:
      position: 102
      prefix: --track-config
  - id: tracks
    type:
      - 'null'
      - type: array
        items: File
    doc: List of track files (bam, cram, vcf, bed, gff, bigwig, bedgraph)
    inputBinding:
      position: 102
      prefix: --tracks
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output HTML file name
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igv-reports:1.16.0--pyh7e72e81_0
