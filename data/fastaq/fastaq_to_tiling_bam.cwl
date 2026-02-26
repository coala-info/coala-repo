cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq_to_tiling_bam
label: fastaq_to_tiling_bam
doc: "Takes a sequence file. Makes a BAM file containing perfect (unpaired) reads
  tiling the whole genome\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input fasta/q file
    inputBinding:
      position: 1
  - id: read_length
    type: int
    doc: Length of reads
    inputBinding:
      position: 2
  - id: read_step
    type: int
    doc: Distance between start of each read
    inputBinding:
      position: 3
  - id: read_prefix
    type: string
    doc: Prefix of read names
    inputBinding:
      position: 4
  - id: qual_char
    type:
      - 'null'
      - string
    doc: Character to use for quality score
    default: I
    inputBinding:
      position: 105
      prefix: --qual_char
  - id: read_group
    type:
      - 'null'
      - string
    doc: Add the given read group ID to all reads
    default: '42'
    inputBinding:
      position: 105
      prefix: --read_group
outputs:
  - id: outfile
    type: File
    doc: Name of output BAM file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
