cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yame
  - summary
label: yame_summary
doc: "Summarize a query feature set (or per-state composition) and optionally its
  overlap/enrichment against one or more masks.\n\nTool homepage: https://github.com/zhou-lab/YAME"
inputs:
  - id: query_files
    type:
      type: array
      items: File
    doc: 'Query feature file(s). Supported query formats: 0/1 (binary), 2 (state),
      3 (MU counts), 4 (float), 6 (set+universe), 7 (genomic coordinates).'
    inputBinding:
      position: 1
  - id: backup_query_name
    type:
      - 'null'
      - string
    doc: Backup query file name used only when <query.cx> is '-'.
    inputBinding:
      position: 102
      prefix: -q
  - id: include_section_state_names
    type:
      - 'null'
      - boolean
    doc: Always include section/state names in output labels when summarizing 
      format-2 (state) data.
    inputBinding:
      position: 102
      prefix: -T
  - id: load_masks_in_memory
    type:
      - 'null'
      - boolean
    doc: Load all masks into memory (faster when mask file is on slow IO). Also 
      auto-enabled when the mask stream is unseekable.
    inputBinding:
      position: 102
      prefix: -M
  - id: mask_file
    type:
      - 'null'
      - File
    doc: Optional mask feature file (can be multi-sample). If provided, every 
      query sample is summarized against every mask sample (cartesian product).
    inputBinding:
      position: 102
      prefix: -m
  - id: override_query_names
    type:
      - 'null'
      - File
    doc: Override query sample names using a plain-text list. Only applies to 
      the first query file.
    inputBinding:
      position: 102
      prefix: -s
  - id: suppress_header
    type:
      - 'null'
      - boolean
    doc: Suppress the header line.
    inputBinding:
      position: 102
      prefix: -H
  - id: treat_format_6_as_2bit
    type:
      - 'null'
      - boolean
    doc: Treat format-6 query as 2bit quaternary than set/universe.
    inputBinding:
      position: 102
      prefix: '-6'
  - id: use_full_paths
    type:
      - 'null'
      - boolean
    doc: 'Use full paths in QFile/MFile (default: basename only).'
    inputBinding:
      position: 102
      prefix: -F
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yame:1.8--ha83d96e_0
stdout: yame_summary.out
