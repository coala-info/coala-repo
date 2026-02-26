cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctseq_add_umis
label: ctseq_add_umis
doc: "Add UMIs to fastq files.\n\nTool homepage: https://github.com/ryanhmiller/ctseq"
inputs:
  - id: dir
    type:
      - 'null'
      - Directory
    doc: Path to directory containing fastq files; forward/reverse reads and umi
      files. If no '--dir' is specified, ctseq will look in your current 
      directory.
    inputBinding:
      position: 101
      prefix: --dir
  - id: forward_ext
    type: string
    doc: Unique extension of fastq files containing FORWARD reads. Make sure to 
      include '.gz' if your files are compressed (required)
    inputBinding:
      position: 101
      prefix: --forwardExt
  - id: reverse_ext
    type: string
    doc: Unique extension of fastq files containing REVERSE reads. Make sure to 
      include '.gz' if your files are compressed (required)
    inputBinding:
      position: 101
      prefix: --reverseExt
  - id: umi_ext
    type:
      - 'null'
      - string
    doc: Unique extension of fastq files containing the UMIs (This flag is 
      REQUIRED if UMIs are contained in separate fastq file). Make sure to 
      include '.gz' if your files are compressed.
    inputBinding:
      position: 101
      prefix: --umiExt
  - id: umi_length
    type: int
    doc: Length of UMI sequence, e.g. 12 (required)
    inputBinding:
      position: 101
      prefix: --umiLength
  - id: umi_type
    type: string
    doc: "Choose 'separate' if the UMIs for the reads are contained in a separate
      fastq file where the line after the read name is the UMI. Choose 'inline' if
      the UMIs are already included in the forward/reverse read fastq files in the
      following format: '@M01806:488:0000 00000-J36GT:1:1101:15963:1363:GTAGGTAAAGTG
      1:N:0:CGAGTAAT' where 'GTAGGTAAAGTG' is the UMI"
    inputBinding:
      position: 101
      prefix: --umiType
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctseq:0.0.2--py_0
stdout: ctseq_add_umis.out
