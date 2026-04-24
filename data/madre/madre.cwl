cwlVersion: v1.2
class: CommandLineTool
baseCommand: madre
label: madre
doc: "MADRe\n\nTool homepage: https://github.com/lbcb-sci/MADRe"
inputs:
  - id: collapsed_strains_overhead
    type:
      - 'null'
      - int
    doc: Overhead for collapsed strains during database reduction.
    inputBinding:
      position: 101
      prefix: --collapsed_strains_overhead
  - id: config
    type:
      - 'null'
      - File
    doc: Path to the configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force rerun all steps.
    inputBinding:
      position: 101
      prefix: --force
  - id: min_contig_len
    type:
      - 'null'
      - int
    doc: Minimum contig length for database reduction.
    inputBinding:
      position: 101
      prefix: --min_contig_len
  - id: out_folder
    type: Directory
    doc: Path to the output folder.
    inputBinding:
      position: 101
      prefix: --out-folder
  - id: reads
    type: File
    doc: Path to the reads file (fastq/fq can be gzipped).
    inputBinding:
      position: 101
      prefix: --reads
  - id: reads_flag
    type:
      - 'null'
      - string
    doc: Reads technology.
    inputBinding:
      position: 101
      prefix: --reads_flag
  - id: strictness
    type:
      - 'null'
      - string
    doc: Database reduction strictness level.
    inputBinding:
      position: 101
      prefix: --strictness
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_myloasm
    type:
      - 'null'
      - boolean
    doc: Use Myloasm assembler tool instead of metaFlye/metaMDBG.
    inputBinding:
      position: 101
      prefix: --use-myloasm
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/madre:0.0.5--pyhdfd78af_0
stdout: madre.out
