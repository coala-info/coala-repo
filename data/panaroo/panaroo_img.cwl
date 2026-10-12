cwlVersion: v1.2
class: CommandLineTool
baseCommand: panaroo-img
label: panaroo_img
doc: "Estimate parameters of the Infinitely Many Genes model from Panaroo gene frequencies or core/pangenome sizes.

Tool homepage: https://gtonkinhill.github.io/panaroo"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({"class": "Directory", "basename": inputs.out_dir, "listing": []})'
        writable: true
inputs:
  - id: tree
    type:
      - 'null'
      - File
    doc: "A dated phylogeny."
    inputBinding:
      prefix: --tree
  - id: pa
    type: File
    doc: "A presence/absence file produced by Panaroo."
    inputBinding:
      prefix: --pa
  - id: out_dir
    type: string
    doc: "Location of an output directory."
    inputBinding:
      prefix: --out_dir
  - id: rate_classes
    type: int
    doc: "Number of separate rate classes to use for the dispensable genome: 1 or 2."
    inputBinding:
      prefix: -D
  - id: no_essential
    type:
      - 'null'
      - boolean
    doc: "Remove the essential gene class from the model."
    inputBinding:
      prefix: --no_essential
  - id: no_constraint
    type:
      - 'null'
      - boolean
    doc: "Remove the constraint that u/v must equal the genome size."
    inputBinding:
      prefix: --no_constraint
  - id: model
    type:
      - 'null'
      - string
    doc: "Model to fit: 'coalescent' or 'fixed'."
    inputBinding:
      prefix: --model
  - id: fit
    type:
      - 'null'
      - string
    doc: "Whether to use the gene frequency spectrum 'gf' or the core/pangenome size 'cp' for fitting (default gf)."
    inputBinding:
      prefix: --fit
  - id: init_u1
    type:
      - 'null'
      - float
    doc: "Initial value for u1 (default 0.01)."
    inputBinding:
      prefix: --init_u1
  - id: init_u2
    type:
      - 'null'
      - float
    doc: "Initial value for u2 (default 0.01)."
    inputBinding:
      prefix: --init_u2
  - id: init_v1
    type:
      - 'null'
      - float
    doc: "Initial value for v1 (default 0.01)."
    inputBinding:
      prefix: --init_v1
  - id: init_v2
    type:
      - 'null'
      - float
    doc: "Initial value for v2 (default 0.01)."
    inputBinding:
      prefix: --init_v2
  - id: init_ess
    type:
      - 'null'
      - float
    doc: "Initial value for the number of essential genes (default 2000)."
    inputBinding:
      prefix: --init_ess
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print additional output."
    inputBinding:
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory with the model estimates."
    outputBinding:
      glob: $(inputs.out_dir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
stdout: panaroo_img.out
