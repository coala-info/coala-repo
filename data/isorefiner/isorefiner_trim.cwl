cwlVersion: v1.2
class: CommandLineTool
baseCommand: isorefiner_trim
label: isorefiner_trim
doc: "Trim reads using Porechop_ABI\n\nTool homepage: https://github.com/rkajitani/IsoRefiner"
inputs:
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: "Prefix of final output files (extentions are those of\n                \
      \        input files)"
    inputBinding:
      position: 101
      prefix: --out_prefix
  - id: reads
    type:
      type: array
      items: File
    doc: Reads (FASTQ or FASTA, gzip allowed, mandatory)
    inputBinding:
      position: 101
      prefix: --reads
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: tool_option
    type:
      - 'null'
      - string
    doc: Option for Porechomp_ABI (quoted string)
    inputBinding:
      position: 101
      prefix: --tool_option
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: "Working directory containing intermediate and log\n                    \
      \    files"
    inputBinding:
      position: 101
      prefix: --work_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
stdout: isorefiner_trim.out
