cwlVersion: v1.2
class: CommandLineTool
baseCommand: simphyni run
label: simphyni_run
doc: "Run the simphyni analysis pipeline.\n\nTool homepage: https://github.com/jpeyemi/SimPhyNI"
inputs:
  - id: snakemake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Extra arguments passed directly to snakemake
    inputBinding:
      position: 1
  - id: cores
    type:
      - 'null'
      - int
    doc: 'Maximum cores for execution (Default: All when not provided)'
    inputBinding:
      position: 102
      prefix: --cores
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Perform a dry run without executing
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: max_prev
    type:
      - 'null'
      - float
    doc: 'Maximum prevanece allowed for a trait to be analyzed (recommended: 0.95)'
    inputBinding:
      position: 102
      prefix: --max_prev
  - id: min_prev
    type:
      - 'null'
      - float
    doc: 'Minimum prevanece required by a trait to be analyzed (recommended: 0.05)'
    inputBinding:
      position: 102
      prefix: --min_prev
  - id: no_plot
    type:
      - 'null'
      - boolean
    doc: Disable plotting
    inputBinding:
      position: 102
      prefix: --no-plot
  - id: no_save_object
    type:
      - 'null'
      - boolean
    doc: Disables saving parsable python object
    inputBinding:
      position: 102
      prefix: --no-save-object
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: 'Main output directory (Default: simphyni_outs)'
    inputBinding:
      position: 102
      prefix: --outdir
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Enable plotting
    inputBinding:
      position: 102
      prefix: --plot
  - id: profile
    type:
      - 'null'
      - Directory
    doc: Path to cluster profile folder for HPC usage
    inputBinding:
      position: 102
      prefix: --profile
  - id: run_traits
    type:
      - 'null'
      - string
    doc: "Comma-separated list of column indices (0 is first trait) in traits CSV
      specifying traits for a traits against all comparison (Default: 'ALL' for all
      agianst all)"
    inputBinding:
      position: 102
      prefix: --run-traits
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Sample name (single-run mode)
    inputBinding:
      position: 102
      prefix: --sample-name
  - id: samples
    type:
      - 'null'
      - File
    doc: 'Path to CSV file with columns: Sample, Traits, Tree, RunType (batch mode)'
    inputBinding:
      position: 102
      prefix: --samples
  - id: save_object
    type:
      - 'null'
      - boolean
    doc: Saves parsable python object containing the complete analysis of each 
      sample
    inputBinding:
      position: 102
      prefix: --save-object
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: 'Temporary directory for intermediate files (Default: tmp)'
    inputBinding:
      position: 102
      prefix: --temp-dir
  - id: traits
    type:
      - 'null'
      - File
    doc: Path to a single traits CSV file (single-run mode)
    inputBinding:
      position: 102
      prefix: --traits
  - id: tree
    type:
      - 'null'
      - File
    doc: Path to a single tree file (single-run mode)
    inputBinding:
      position: 102
      prefix: --tree
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simphyni:1.0.2--pyhdfd78af_0
stdout: simphyni_run.out
