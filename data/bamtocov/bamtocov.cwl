cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamtocov
label: bamtocov
doc: "Calculate coverage from BAM files.\n\nTool homepage: https://github.com/telatin/bamtocov"
inputs:
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: the alignment file for which to calculate depth
    default: STDIN
    inputBinding:
      position: 1
  - id: bam_threads
    type:
      - 'null'
      - int
    doc: BAM decompression threads
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable diagnostics
    inputBinding:
      position: 102
      prefix: --debug
  - id: exclude_flag
    type:
      - 'null'
      - int
    doc: Exclude reads with any of the bits in FLAG set
    default: 1796
    inputBinding:
      position: 102
      prefix: --flag
  - id: extend_reads
    type:
      - 'null'
      - int
    doc: '[Experimental] artificially extend reads by INT bases'
    default: 0
    inputBinding:
      position: 102
      prefix: --extendReads
  - id: force_gff_input
    type:
      - 'null'
      - boolean
    doc: Force GFF input (otherwise assumed by extension .gff)
    inputBinding:
      position: 102
      prefix: --gff
  - id: force_gtf_input
    type:
      - 'null'
      - boolean
    doc: Force GTF input (otherwise assumed by extension .gtf)
    inputBinding:
      position: 102
      prefix: --gtf
  - id: gff_feature_type
    type:
      - 'null'
      - string
    doc: GFF feature type to parse
    default: CDS
    inputBinding:
      position: 102
      prefix: --gff-type
  - id: gff_id
    type:
      - 'null'
      - string
    doc: GFF identifier
    default: ID
    inputBinding:
      position: 102
      prefix: --gff-id
  - id: gff_separator
    type:
      - 'null'
      - string
    doc: GFF attributes separator
    default: ;
    inputBinding:
      position: 102
      prefix: --gff-separator
  - id: mapping_quality_threshold
    type:
      - 'null'
      - int
    doc: Mapping quality threshold
    default: 0
    inputBinding:
      position: 102
      prefix: --mapq
  - id: physical_coverage
    type:
      - 'null'
      - boolean
    doc: Calculate physical coverage
    inputBinding:
      position: 102
      prefix: --physical
  - id: quantize_breaks
    type:
      - 'null'
      - string
    doc: Comma separated list of breaks for quantized output
    inputBinding:
      position: 102
      prefix: --quantize
  - id: regions_file
    type:
      - 'null'
      - File
    doc: Target file in BED or GFF3/GTF format (detected with the extension)
    inputBinding:
      position: 102
      prefix: --regions
  - id: report_low_coverage
    type:
      - 'null'
      - int
    doc: Report coverage for bases with coverage < min
    default: 0
    inputBinding:
      position: 102
      prefix: --report-low
  - id: skip_output
    type:
      - 'null'
      - boolean
    doc: Do not output per-base coverage
    inputBinding:
      position: 102
      prefix: --skip-output
  - id: stranded
    type:
      - 'null'
      - boolean
    doc: Report coverage separate by strand
    inputBinding:
      position: 102
      prefix: --stranded
  - id: wig_span
    type:
      - 'null'
      - int
    doc: Output in WIG format (using fixed <SPAN>), 0 will print in BED format
    default: 0
    inputBinding:
      position: 102
      prefix: --wig
  - id: wig_summarize_func
    type:
      - 'null'
      - string
    doc: How to summarize coverage for each WIG span (mean/min/max)
    default: max
    inputBinding:
      position: 102
      prefix: --op
outputs:
  - id: report_file
    type:
      - 'null'
      - File
    doc: Output coverage report
    outputBinding:
      glob: $(inputs.report_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamtocov:2.8.0--h1104d80_0
