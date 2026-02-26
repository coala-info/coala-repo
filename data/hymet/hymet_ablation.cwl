cwlVersion: v1.2
class: CommandLineTool
baseCommand: hymet_ablation
label: hymet_ablation
doc: "Ablate samples using HYMET\n\nTool homepage: https://github.com/inesbmartins02/HYMET"
inputs:
  - id: extra
    type:
      - 'null'
      - type: array
        items: string
    doc: Extra args forwarded to run_ablation.sh
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
  - id: fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA to ablate
    inputBinding:
      position: 102
      prefix: --fasta
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
  - id: levels
    type:
      - 'null'
      - string
    doc: Comma-separated ablation fractions (e.g. 0,0.5,1.0)
    inputBinding:
      position: 102
      prefix: --levels
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample ID to ablate
    inputBinding:
      position: 102
      prefix: --sample
  - id: seqmap
    type:
      - 'null'
      - File
    doc: Sequence-to-taxid map
    inputBinding:
      position: 102
      prefix: --seqmap
  - id: taxa
    type:
      - 'null'
      - string
    doc: Comma-separated TaxIDs to remove at each level
    inputBinding:
      position: 102
      prefix: --taxa
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
    doc: Output directory for ablation results
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hymet:1.3.0--hdfd78af_0
