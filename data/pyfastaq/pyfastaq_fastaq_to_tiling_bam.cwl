cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - to_tiling_bam
label: pyfastaq_fastaq_to_tiling_bam
doc: "Takes a sequence file. Makes a BAM file containing perfect (unpaired) reads tiling the whole genome\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: qual_char
    type:
      - 'null'
      - string
    doc: "Character to use for quality score [I]"
    inputBinding:
      position: 1
      prefix: --qual_char
  - id: read_group
    type:
      - 'null'
      - string
    doc: "Add the given read group ID to all reads [42]"
    inputBinding:
      position: 2
      prefix: --read_group
  - id: infile
    type: File
    doc: "Name of input fasta/q file"
    inputBinding:
      position: 20
  - id: read_length
    type: int
    doc: "Length of reads"
    inputBinding:
      position: 21
  - id: read_step
    type: int
    doc: "Distance between start of each read"
    inputBinding:
      position: 22
  - id: read_prefix
    type: string
    doc: "Prefix of read names"
    inputBinding:
      position: 23
  - id: outfile
    type: string
    doc: "Name of output BAM file"
    inputBinding:
      position: 24
outputs:
  - id: output
    type: File
    doc: "Name of output BAM file"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
