cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqnado pipeline
label: seqnado_pipeline
doc: "Run the data processing pipeline for ASSAY (Snakemake under the hood). Any additional
  arguments are passed to Snakemake (e.g., `seqnado pipeline rna -n` for dry-run,
  `--unlock`, etc.).\n\nTool homepage: https://alsmith151.github.io/SeqNado/"
inputs:
  - id: assay
    type:
      - 'null'
      - string
    doc: Assay type (required for single-assay, optional for Multiomic mode)
    inputBinding:
      position: 1
  - id: clean_symlinks
    type:
      - 'null'
      - boolean
    doc: Remove symlinks created by previous runs.
    inputBinding:
      position: 102
      prefix: --clean-symlinks
  - id: configfile
    type:
      - 'null'
      - File
    doc: Path to a SeqNado config YAML
    inputBinding:
      position: 102
      prefix: --configfile
  - id: no_clean_symlinks
    type:
      - 'null'
      - boolean
    doc: Do not remove symlinks created by previous runs.
    inputBinding:
      position: 102
      prefix: --no-clean-symlinks
  - id: preset
    type:
      - 'null'
      - string
    doc: Snakemake job profile preset.
    inputBinding:
      position: 102
      prefix: --preset
  - id: print_cmd
    type:
      - 'null'
      - boolean
    doc: Print the Snakemake command before running it.
    inputBinding:
      position: 102
      prefix: --print-cmd
  - id: profile
    type:
      - 'null'
      - File
    doc: Path to a Snakemake profile directory (overrides --preset).
    inputBinding:
      position: 102
      prefix: --profile
  - id: queue
    type:
      - 'null'
      - string
    doc: Slurm queue/partition for the `ss` preset.
    inputBinding:
      position: 102
      prefix: --queue
  - id: scale_resources
    type:
      - 'null'
      - float
    doc: 'Scale memory/time (env: SCALE_RESOURCES).'
    inputBinding:
      position: 102
      prefix: --scale-resources
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase logging verbosity.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqnado:1.0.4--pyhdfd78af_0
stdout: seqnado_pipeline.out
