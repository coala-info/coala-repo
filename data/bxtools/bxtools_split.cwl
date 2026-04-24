cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bxtools
  - split
label: bxtools_split
doc: "Split / count a BAM into multiple BAMs, one BAM per unique BX tag\n\nTool homepage:
  https://github.com/walaj/bxtools"
inputs:
  - id: input_file
    type: File
    doc: Input BAM/SAM/CRAM file
    inputBinding:
      position: 1
  - id: analysis_id
    type: string
    doc: ID to prefix output files with
    inputBinding:
      position: 102
      prefix: --analysis-id
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minumum reads of given tag to see before writing
    inputBinding:
      position: 102
      prefix: --min-reads
  - id: no_output
    type:
      - 'null'
      - boolean
    doc: Don't output BAMs (count only)
    inputBinding:
      position: 102
      prefix: --no-output
  - id: tag
    type:
      - 'null'
      - string
    doc: Split by a tag other than BX (e.g. MI)
    inputBinding:
      position: 102
      prefix: --tag
  - id: verbose
    type:
      - 'null'
      - int
    doc: Select verbosity level (0-4)
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bxtools:0.1.0--h13024bc_6
stdout: bxtools_split.out
