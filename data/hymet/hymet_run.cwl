cwlVersion: v1.2
class: CommandLineTool
baseCommand: hymet_run
label: hymet_run
doc: "Run HYMET with specified inputs and options.\n\nTool homepage: https://github.com/inesbmartins02/HYMET"
inputs:
  - id: assembly_summary_dir
    type:
      - 'null'
      - Directory
    doc: Directory holding assembly_summary files
    inputBinding:
      position: 101
      prefix: --assembly-summary-dir
  - id: cache_root
    type:
      - 'null'
      - Directory
    doc: Override cache root (CACHE_ROOT)
    inputBinding:
      position: 101
      prefix: --cache-root
  - id: cand_max
    type:
      - 'null'
      - int
    doc: Maximum Mash candidates (CAND_MAX)
    inputBinding:
      position: 101
      prefix: --cand-max
  - id: contigs
    type:
      - 'null'
      - File
    doc: Input contigs FASTA
    inputBinding:
      position: 101
      prefix: --contigs
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Show commands without executing them
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: force_download
    type:
      - 'null'
      - boolean
    doc: Set FORCE_DOWNLOAD=1 for HYMET runs
    inputBinding:
      position: 101
      prefix: --force-download
  - id: keep_work
    type:
      - 'null'
      - boolean
    doc: Set KEEP_HYMET_WORK=1 to retain intermediates
    inputBinding:
      position: 101
      prefix: --keep-work
  - id: reads
    type:
      - 'null'
      - File
    doc: Input reads FASTQ/FASTA
    inputBinding:
      position: 101
      prefix: --reads
  - id: species_dedup
    type:
      - 'null'
      - boolean
    doc: Enable species-level candidate deduplication
    inputBinding:
      position: 101
      prefix: --species-dedup
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread count to pass to HYMET
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hymet:1.3.0--hdfd78af_0
