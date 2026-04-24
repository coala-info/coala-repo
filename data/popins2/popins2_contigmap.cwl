cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - popins2
  - contigmap
label: popins2_contigmap
doc: "Alignment of unmapped reads to assembled contigs.\n\nTool homepage: https://github.com/kehrlab/PopIns2"
inputs:
  - id: sample_id
    type: string
    doc: SAMPLE_ID
    inputBinding:
      position: 1
  - id: contigs
    type:
      - 'null'
      - File
    doc: 'Name of (super-)contigs file. Valid filetypes are: fa, fna, and fasta.'
    inputBinding:
      position: 102
      prefix: --contigs
  - id: memory
    type:
      - 'null'
      - string
    doc: Maximum memory per thread for samtools sort; suffix K/M/G recognized.
    inputBinding:
      position: 102
      prefix: --memory
  - id: prefix
    type:
      - 'null'
      - Directory
    doc: Path to the sample directories.
    inputBinding:
      position: 102
      prefix: --prefix
  - id: reference
    type:
      - 'null'
      - File
    doc: 'Name of reference genome file. Valid filetypes are: fa, fna, and fasta.'
    inputBinding:
      position: 102
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for BWA and samtools sort. In range [1..inf].
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
stdout: popins2_contigmap.out
