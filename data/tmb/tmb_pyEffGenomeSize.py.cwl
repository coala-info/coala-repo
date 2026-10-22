cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyEffGenomeSize.py
label: tmb_pyEffGenomeSize.py
doc: "Calculates the effective genome size (callable region size) of a capture design
  from a BED file and a GTF annotation, optionally filtered by coding or non-coding
  features and by mosdepth coverage.\n\nTool homepage: https://github.com/bioinfo-pf-curie/TMB"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: bed
    type: File
    doc: BED file (.bed)
    inputBinding:
      position: 1
      prefix: --bed
  - id: gtf
    type: File
    doc: GTF file for genome annotation (.gtf)
    inputBinding:
      position: 2
      prefix: --gtf
  - id: bam
    type:
      - 'null'
      - File
    doc: BAM file for mapping statistics (.bam)
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 3
      prefix: --bam
  - id: mosdepth
    type:
      - 'null'
      - boolean
    doc: Enable mosdepth processing, requires a .bam file
    inputBinding:
      position: 4
      prefix: --mosdepth
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage of the region
    inputBinding:
      position: 5
      prefix: --minCoverage
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 6
      prefix: --minMapq
  - id: filter_non_coding
    type:
      - 'null'
      - boolean
    doc: Filter regions associated with non coding annotations
    inputBinding:
      position: 7
      prefix: --filterNonCoding
  - id: filter_coding
    type:
      - 'null'
      - boolean
    doc: Filter regions associated with coding annotations
    inputBinding:
      position: 8
      prefix: --filterCoding
  - id: feature_types
    type:
      - 'null'
      - type: array
        items: string
    doc: List of features (exon, gene, transcript, UTR, CDS) to keep (3rd column from
      gtf/gff). Required with --filterCoding
    inputBinding:
      position: 9
      prefix: --featureTypes
  - id: save_intermediates
    type:
      - 'null'
      - boolean
    doc: Save mosdepth intermediate files
    inputBinding:
      position: 10
      prefix: --saveIntermediates
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads for mosdepth run
    inputBinding:
      position: 11
      prefix: --thread
  - id: oprefix
    type:
      - 'null'
      - string
    doc: Prefix for output files (default pyeffg)
    inputBinding:
      position: 12
      prefix: --oprefix
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Active verbose mode
    inputBinding:
      position: 13
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output with the effective genome size report
  - id: intersect_bed
    type:
      - 'null'
      - File
    doc: Intersection of the BED file with the filtered GTF
    outputBinding:
      glob: '*.intersect.bed'
  - id: mosdepth_files
    type:
      type: array
      items: File
    doc: Mosdepth intermediate files (with --saveIntermediates)
    outputBinding:
      glob: '*.mosdepth.*'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tmb:1.5.0--pyhdfd78af_1
stdout: tmb_pyEffGenomeSize.py.out
