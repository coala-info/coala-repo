cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam-readcount
label: bam-readcount
doc: "Generate metrics for each base at specific genomic positions from a BAM file.\n\
  \nTool homepage: https://github.com/genome/bam-readcount"
inputs:
  - id: bam_file
    type: File
    doc: The BAM file to be analyzed.
    inputBinding:
      position: 1
  - id: region
    type:
      - 'null'
      - string
    doc: Region in the format 'chr:start-end'. If omitted, a site list must be 
      provided via -l.
    inputBinding:
      position: 2
  - id: insertion_centered
    type:
      - 'null'
      - boolean
    doc: Include insertion-centered readcounts.
    inputBinding:
      position: 103
      prefix: -i
  - id: max_count
    type:
      - 'null'
      - int
    doc: Maximum depth of coverage to report.
    inputBinding:
      position: 103
      prefix: --max-count
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality at a position to be counted.
    default: 0
    inputBinding:
      position: 103
      prefix: --min-base-quality
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality of reads to be counted.
    default: 0
    inputBinding:
      position: 103
      prefix: --min-mapping-quality
  - id: per_library
    type:
      - 'null'
      - boolean
    doc: Report readcounts separately for each library.
    inputBinding:
      position: 103
      prefix: --per-library
  - id: reference_fasta
    type: File
    doc: Reference fasta file.
    inputBinding:
      position: 103
      prefix: --reference-fasta
  - id: site_list
    type:
      - 'null'
      - File
    doc: File containing a list of regions to process.
    inputBinding:
      position: 103
      prefix: --site-list
  - id: wait
    type:
      - 'null'
      - int
    doc: Wait for the BAM file to become available (seconds).
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bam-readcount:1.0.1--h9aeec6d_3
stdout: bam-readcount.out
