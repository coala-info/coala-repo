cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PathogenTrack
  - count
label: pathogentrack_count
doc: "one command to count microbes at single-cell levels\n\nTool homepage: https://github.com/ncrna/PathogenTrack"
inputs:
  - id: barcode
    type: File
    doc: file name for raw barcodes from cellranger, decompress it before use
    inputBinding:
      position: 101
      prefix: --barcode
  - id: kraken_db
    type: Directory
    doc: kraken2 database name
    inputBinding:
      position: 101
      prefix: --kraken_db
  - id: read1
    type: File
    doc: file name for Read1
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type: File
    doc: file name for Read2
    inputBinding:
      position: 101
      prefix: --read2
  - id: star_index
    type: Directory
    doc: star indices of the reference genome
    inputBinding:
      position: 101
      prefix: --star_index
  - id: project_id
    type: string
    doc: project id to store output files
    inputBinding:
      position: 101
      prefix: --project_id
  - id: confidence
    type:
      - 'null'
      - float
    doc: confidence threshold to use [0-1], default is 0.11
    inputBinding:
      position: 101
      prefix: --confidence
  - id: complexity_threshold
    type:
      - 'null'
      - int
    doc: the threshold for low complexity filter [0-100], default is 30
    inputBinding:
      position: 101
      prefix: --complexity_threshold
  - id: filter_low_complexity
    type:
      - 'null'
      - boolean
    doc: enable filter out low complexity reads, default is False
    inputBinding:
      position: 101
      prefix: --filter_low_complexity
  - id: ignore_suffix
    type:
      - 'null'
      - boolean
    doc: ignore the read name suffixes, eg., /1 and /2 in the read are ignored,
      default is False
    inputBinding:
      position: 101
      prefix: --ignore_suffix
  - id: min_reads
    type:
      - 'null'
      - int
    doc: minimum number of reads that supports the taxonomy, default is 10
    inputBinding:
      position: 101
      prefix: --min_reads
  - id: pattern
    type:
      - 'null'
      - string
    doc: barcode pattern, default="CCCCCCCCCCCCCCCCNNNNNNNNNN", please refer to
      umi_tools help manual
    inputBinding:
      position: 101
      prefix: --pattern
  - id: thread
    type:
      - 'null'
      - int
    doc: number of threads to use, default is 8
    inputBinding:
      position: 101
      prefix: --thread
  - id: trim_poly_x
    type:
      - 'null'
      - boolean
    doc: enable polyA/T/C/G/N trimming in 3' ends
    inputBinding:
      position: 101
      prefix: --trim_poly_x
outputs:
  - id: project_dir
    type: Directory
    doc: Directory with all output files (barcodes.tsv, microbes.tsv, microbes.fa and the intermediate files)
    outputBinding:
      glob: $(inputs.project_id)
  - id: microbes_matrix
    type: File
    doc: microbe quantification matrix
    outputBinding:
      glob: $(inputs.project_id + '/microbes.tsv')
  - id: microbes_reads
    type: File
    doc: classified reads
    outputBinding:
      glob: $(inputs.project_id + '/microbes.fa')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathogentrack:0.2.3--pyh5e36f6f_0
