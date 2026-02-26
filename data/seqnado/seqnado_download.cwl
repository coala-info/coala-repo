cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqnado download
label: seqnado_download
doc: "Download FASTQ files from GEO/SRA using a metadata TSV file and optionally generate
  a design file.\n\nTool homepage: https://alsmith151.github.io/SeqNado/"
inputs:
  - id: metadata_tsv
    type: File
    doc: 'TSV file from GEO/ENA with columns: run_accession, sample_title, library_name,
      and library_layout (PAIRED or SINGLE).'
    inputBinding:
      position: 1
  - id: assay
    type:
      - 'null'
      - string
    doc: Assay type for generating design file after download. If not provided, 
      only downloads FASTQs.
    inputBinding:
      position: 102
      prefix: --assay
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores/parallel jobs.
    default: 4
    inputBinding:
      position: 102
      prefix: --cores
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Show actions without executing them.
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: preset
    type:
      - 'null'
      - string
    doc: Snakemake job profile preset.
    default: le
    inputBinding:
      position: 102
      prefix: --preset
  - id: profile
    type:
      - 'null'
      - Directory
    doc: Path to a Snakemake profile directory (overrides --preset).
    inputBinding:
      position: 102
      prefix: --profiles
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase logging verbosity.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory for downloaded FASTQ files.
    outputBinding:
      glob: $(inputs.outdir)
  - id: design_output
    type:
      - 'null'
      - File
    doc: 'Output path for design CSV (default: metadata_{assay}.csv in outdir).'
    outputBinding:
      glob: $(inputs.design_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqnado:1.0.4--pyhdfd78af_0
