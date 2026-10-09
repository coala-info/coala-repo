cwlVersion: v1.2
class: CommandLineTool
baseCommand: ismap
label: ismapper_ismap
doc: "ISMapper: identify the insertion sites of insertion sequences (IS) in bacterial
  genomes from paired-end reads, a query IS sequence and a reference genome in GenBank
  format.\n\nTool homepage: https://github.com/jhawkey/IS_mapper/"
inputs:
  - id: reads
    type:
      type: array
      items: File
    doc: Paired end reads for analysing (can be gzipped). Reads of one isolate are paired by name (_1, _2).
    inputBinding:
      position: 1
      prefix: --reads
  - id: queries
    type:
      type: array
      items: File
    doc: 'Multifasta file for query gene(s) (eg: insertion sequence) that will be
      mapped to.'
    inputBinding:
      position: 2
      prefix: --queries
  - id: reference
    type:
      type: array
      items: File
    doc: Reference genome for typing against in genbank format
    inputBinding:
      position: 3
      prefix: --reference
  - id: output_dir
    type: string
    doc: Location for all output files
    inputBinding:
      position: 4
      prefix: --output_dir
  - id: log
    type:
      - 'null'
      - string
    doc: Prefix for log file. If not supplied, prefix will be current date and time.
    inputBinding:
      position: 104
      prefix: --log
  - id: min_clip
    type:
      - 'null'
      - int
    doc: 'Minimum size for softclipped region to be extracted from initial mapping
      (default 10).'
    inputBinding:
      position: 104
      prefix: --min_clip
  - id: max_clip
    type:
      - 'null'
      - int
    doc: 'Maximum size for softclipped regions to be included (default 30).'
    inputBinding:
      position: 104
      prefix: --max_clip
  - id: cutoff
    type:
      - 'null'
      - int
    doc: 'Minimum depth for mapped region to be kept in bed file (default 6)'
    inputBinding:
      position: 104
      prefix: --cutoff
  - id: novel_gap_size
    type:
      - 'null'
      - int
    doc: 'Distance in base pairs between left and right flanks to be called a novel
      hit (default 15)'
    inputBinding:
      position: 104
      prefix: --novel_gap_size
  - id: min_range
    type:
      - 'null'
      - float
    doc: 'Minimum percent size of the gap to be called a known hit (default 0.9, or
      90 percent)'
    inputBinding:
      position: 104
      prefix: --min_range
  - id: max_range
    type:
      - 'null'
      - float
    doc: 'Maximum percent size of the gap to be called a known hit (default 1.1, or
      110 percent)'
    inputBinding:
      position: 104
      prefix: --max_range
  - id: merging
    type:
      - 'null'
      - int
    doc: 'Value for merging left and right hits in bed files together to simply calculation
      of closest and intersecting regions (default 100).'
    inputBinding:
      position: 104
      prefix: --merging
  - id: all_alignments
    type:
      - 'null'
      - boolean
    doc: Switch on all alignment reporting for bwa.
    inputBinding:
      position: 104
      prefix: --a
  - id: bwa_mapq
    type:
      - 'null'
      - int
    doc: 'Mapping quality score for bwa (default 30).'
    inputBinding:
      position: 104
      prefix: --T
  - id: bwa_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads for bwa (default 1).'
    inputBinding:
      position: 104
      prefix: --t
  - id: cds
    type:
      - 'null'
      - string
    doc: 'qualifier containing gene information (default product). Also note that
      all CDS features MUST have a locus_tag'
    inputBinding:
      position: 104
      prefix: --cds
  - id: trna
    type:
      - 'null'
      - string
    doc: 'qualifier containing gene information (default product). Also note that
      all tRNA features MUST have a locus_tag'
    inputBinding:
      position: 104
      prefix: --trna
  - id: rrna
    type:
      - 'null'
      - string
    doc: 'qualifier containing gene information (default product). Also note that
      all rRNA features MUST have a locus_tag'
    inputBinding:
      position: 104
      prefix: --rrna
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Switch on keeping the temp folder instead of deleting it at the end of the run
    inputBinding:
      position: 104
      prefix: --temp
  - id: keep_bam
    type:
      - 'null'
      - boolean
    doc: Switch on keeping the final bam files instead of deleting them at the end of the run
    inputBinding:
      position: 104
      prefix: --bam
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type: Directory
    doc: Output directory with the per-isolate result tables
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ismapper:2.0.2--pyhdfd78af_1
stdout: ismapper_ismap.out
