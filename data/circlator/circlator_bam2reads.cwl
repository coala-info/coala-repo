cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - circlator
  - bam2reads
label: circlator_bam2reads
doc: "Make reads from mapping to be reassembled\n\nTool homepage: https://github.com/sanger-pathogens/circlator"
inputs:
  - id: input_bam
    type: File
    doc: Name of input bam file
    inputBinding:
      position: 1
  - id: outprefix
    type: string
    doc: Prefix of output filenames
    inputBinding:
      position: 2
  - id: discard_unmapped
    type:
      - 'null'
      - boolean
    doc: Use this to not keep unmapped reads
    inputBinding:
      position: 103
      prefix: --discard_unmapped
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Write fastq output (if quality scores are present in input BAM file)
    inputBinding:
      position: 103
      prefix: --fastq
  - id: length_cutoff
    type:
      - 'null'
      - int
    doc: All reads mapped to contigs shorter than this will be kept
    inputBinding:
      position: 103
      prefix: --length_cutoff
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum length of read to output
    inputBinding:
      position: 103
      prefix: --min_read_length
  - id: only_contigs
    type:
      - 'null'
      - File
    doc: File of contig names (one per line). Only reads that map to these 
      contigs are kept (and unmapped reads, unless --discard_unmapped is used).
    inputBinding:
      position: 103
      prefix: --only_contigs
  - id: split_all_reads
    type:
      - 'null'
      - boolean
    doc: By default, reads mapped to shorter contigs are left unchanged. This 
      option splits them into two, broken at the middle of the contig to try to 
      force circularization. May help if the assembler does not detect circular 
      contigs (eg canu)
    inputBinding:
      position: 103
      prefix: --split_all_reads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/circlator:v1.5.5-3-deb_cv1
stdout: circlator_bam2reads.out
