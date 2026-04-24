cwlVersion: v1.2
class: CommandLineTool
baseCommand: hymet_bench
label: hymet_bench
doc: "Run the HYMET benchmark pipeline.\n\nTool homepage: https://github.com/inesbmartins02/HYMET"
inputs:
  - id: extra
    type:
      - 'null'
      - type: array
        items: string
    doc: Extra args forwarded to run_all_cami.sh
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
    inputBinding:
      position: 102
      prefix: --manifest
  - id: max_samples
    type:
      - 'null'
      - int
    doc: Limit number of samples processed
    inputBinding:
      position: 102
      prefix: --max-samples
  - id: no_build
    type:
      - 'null'
      - boolean
    doc: Skip database build step
    inputBinding:
      position: 102
      prefix: --no-build
  - id: no_publish
    type:
      - 'null'
      - boolean
    doc: Skip publishing under results/
    inputBinding:
      position: 102
      prefix: --no-publish
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Resume without clearing runtime log
    inputBinding:
      position: 102
      prefix: --resume
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread count to pass to HYMET
    inputBinding:
      position: 102
      prefix: --threads
  - id: tools
    type:
      - 'null'
      - string
    doc: Comma-separated tool list
    inputBinding:
      position: 102
      prefix: --tools
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hymet:1.3.0--hdfd78af_0
stdout: hymet_bench.out
