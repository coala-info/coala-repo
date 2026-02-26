cwlVersion: v1.2
class: CommandLineTool
baseCommand: impg_stats
label: impg_stats
doc: "Print alignment statistics\n\nTool homepage: https://github.com/pangenome/impg"
inputs:
  - id: force_reindex
    type:
      - 'null'
      - boolean
    doc: Force the regeneration of the index, even if it already exists
    inputBinding:
      position: 101
      prefix: --force-reindex
  - id: index
    type:
      - 'null'
      - File
    doc: Path to the IMPG index file
    inputBinding:
      position: 101
      prefix: --index
  - id: paf_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to the PAF files
    inputBinding:
      position: 101
      prefix: --paf-files
  - id: paf_list
    type:
      - 'null'
      - File
    doc: Path to a text file containing paths to PAF files (one per line)
    inputBinding:
      position: 101
      prefix: --paf-list
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel processing
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - int
    doc: Verbosity level (0 = error, 1 = info, 2 = debug)
    default: 0
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/impg:0.3.3--hdb3fbb7_0
stdout: impg_stats.out
