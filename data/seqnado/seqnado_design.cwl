cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqnado_design
label: seqnado_design
doc: "Generate a SeqNado design CSV from FASTQ files for ASSAY. If no assay is provided,
  multiomics mode is used.\n\nTool homepage: https://alsmith151.github.io/SeqNado/"
inputs:
  - id: assay
    type:
      - 'null'
      - string
    doc: 'Assay type. Options: rna, atac, snp, chip, cat, meth, mcc, crispr, multiomics.
      If omitted, multiomics mode is used.'
    inputBinding:
      position: 1
  - id: fastqs
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTQ files
    inputBinding:
      position: 2
  - id: accept_all_defaults
    type:
      - 'null'
      - boolean
    doc: 'Non-interactive: auto-add only columns that have a schema default.'
    inputBinding:
      position: 103
      prefix: --accept-all-defaults
  - id: auto_discover
    type:
      - 'null'
      - boolean
    doc: Search common folders if none provided.
    inputBinding:
      position: 103
      prefix: --auto-discover
  - id: deseq2_pattern
    type:
      - 'null'
      - string
    doc: "Regex pattern to extract DESeq2 groups from sample names. First capture
      group will be used. Example: r'-(\\w+)-rep' for 'sample-GROUP-rep1'"
    inputBinding:
      position: 103
      prefix: --deseq2-pattern
  - id: group_by
    type:
      - 'null'
      - string
    doc: Group samples by a regular expression or a column name.
    inputBinding:
      position: 103
      prefix: --group-by
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: Interactively offer to add missing columns using schema defaults.
    inputBinding:
      position: 103
      prefix: --interactive
  - id: ip_to_control
    type:
      - 'null'
      - string
    doc: "List of antibody,control pairings for IP assays (e.g. ChIP). Format: 'antibody1:control1,antibody2:control2'.
      If provided will assign a control with a specified name to that ip in the metadata.
      If not provided, controls will be assigned based on a best-effort matching of
      sample names."
    inputBinding:
      position: 103
      prefix: --ip-to-control
  - id: no_auto_discover
    type:
      - 'null'
      - boolean
    doc: Search common folders if none provided.
    inputBinding:
      position: 103
      prefix: --no-auto-discover
  - id: no_interactive
    type:
      - 'null'
      - boolean
    doc: Interactively offer to add missing columns using schema defaults.
    inputBinding:
      position: 103
      prefix: --no-interactive
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase logging verbosity.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output CSV filename
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqnado:1.0.4--pyhdfd78af_0
