cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqnado
  - config
label: seqnado_config
doc: "Build a workflow configuration YAML for the selected ASSAY. If no assay is provided,
  multiomics mode is used.\n\nTool homepage: https://alsmith151.github.io/SeqNado/"
inputs:
  - id: assay
    type:
      - 'null'
      - string
    doc: 'rna, atac, snp, chip, cat, meth, mcc, crispr, multiomics. If omitted, multiomics
      mode is used.'
    inputBinding:
      position: 1
  - id: make_dirs
    type:
      - 'null'
      - boolean
    doc: Create the output project directory or fastq subdir
    inputBinding:
      position: 2
      prefix: --make-dirs
  - id: no_make_dirs
    type:
      - 'null'
      - boolean
    doc: Do not create the output project directory or fastq subdir
    inputBinding:
      position: 2
      prefix: --no-make-dirs
  - id: render_options
    type:
      - 'null'
      - boolean
    doc: Render all options (even if not used by the workflow)
    inputBinding:
      position: 2
      prefix: --render-options
  - id: no_render_options
    type:
      - 'null'
      - boolean
    doc: Do not render unused options
    inputBinding:
      position: 2
      prefix: --no-render-options
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: Interactively prompt for config values
    inputBinding:
      position: 2
      prefix: --interactive
  - id: no_interactive
    type:
      - 'null'
      - boolean
    doc: Do not prompt. Non-interactive mode only works for single assay configs
      (except MCC and multiomics).
    inputBinding:
      position: 2
      prefix: --no-interactive
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase logging verbosity
    inputBinding:
      position: 2
      prefix: --verbose
  - id: output_path
    type:
      - 'null'
      - string
    doc: Explicit path for the rendered config file
    inputBinding:
      position: 3
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Rendered config file
    outputBinding:
      glob: $(inputs.output_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqnado:1.0.4--pyhdfd78af_0
stdout: seqnado_config.out
