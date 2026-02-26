cwlVersion: v1.2
class: CommandLineTool
baseCommand: hymet_case
label: hymet_case
doc: "Run a case study with HYMET.\n\nTool homepage: https://github.com/inesbmartins02/HYMET"
inputs:
  - id: extra
    type:
      - 'null'
      - type: array
        items: string
    doc: Extra args forwarded to run_case.sh
    inputBinding:
      position: 1
  - id: cache_root
    type:
      - 'null'
      - Directory
    doc: Override cache root (CACHE_ROOT)
    inputBinding:
      position: 102
      prefix: --cache-root
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Show commands without executing them
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: force_download
    type:
      - 'null'
      - boolean
    doc: Set FORCE_DOWNLOAD=1 for HYMET runs
    inputBinding:
      position: 102
      prefix: --force-download
  - id: keep_work
    type:
      - 'null'
      - boolean
    doc: Set KEEP_HYMET_WORK=1 to retain intermediates
    inputBinding:
      position: 102
      prefix: --keep-work
  - id: manifest
    type:
      - 'null'
      - File
    doc: Manifest TSV
    default: case/manifest.tsv
    inputBinding:
      position: 102
      prefix: --manifest
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread count to pass to HYMET
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: Output root directory
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hymet:1.3.0--hdfd78af_0
