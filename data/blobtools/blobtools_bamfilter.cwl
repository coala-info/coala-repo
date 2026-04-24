cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blobtools
  - bamfilter
label: blobtools_bamfilter
doc: "Filter BAM files based on contig inclusion/exclusion lists and mapping status.\n\
  \nTool homepage: https://blobtools.readme.io/docs/what-is-blobtools"
inputs:
  - id: bam_file
    type: File
    doc: BAM file (sorted by name)
    inputBinding:
      position: 101
      prefix: --bam
  - id: exclude_file
    type:
      - 'null'
      - File
    doc: "List of contigs whose reads are excluded (outputs reads that do not map
      to sequences in list)\n                                    - writes FASTAs of
      pairs where at least\n                                        one read does
      not maps to sequences in list\n                                        (InUn.fq,
      InIn.fq, ExIn.fq)"
    inputBinding:
      position: 101
      prefix: --exclude
  - id: exclude_unmapped
    type:
      - 'null'
      - boolean
    doc: Include pairs where both reads are unmapped
    inputBinding:
      position: 101
      prefix: --exclude_unmapped
  - id: include_file
    type:
      - 'null'
      - File
    doc: "List of contigs whose reads are included\n                             \
      \       - writes FASTAs of pairs where at least\n                          \
      \              one read maps sequences in list\n                           \
      \             (InUn.fq, InIn.fq, ExIn.fq)"
    inputBinding:
      position: 101
      prefix: --include
  - id: noninterleaved
    type:
      - 'null'
      - boolean
    doc: Use if fw and rev reads should be in separate files
    inputBinding:
      position: 101
      prefix: --noninterleaved
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: --out
  - id: read_format
    type:
      - 'null'
      - string
    doc: FASTQ = fq, FASTA = fa
    inputBinding:
      position: 101
      prefix: --read_format
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtools:1.1.1--py_1
stdout: blobtools_bamfilter.out
