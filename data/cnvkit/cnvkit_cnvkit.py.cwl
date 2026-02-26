cwlVersion: v1.2
class: CommandLineTool
baseCommand: cnvkit.py
label: cnvkit_cnvkit.py
doc: "CNVkit, a command-line toolkit for copy number analysis.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: subcommand
    type: string
    doc: 'Sub-commands: batch, target, access, antitarget, autobin, coverage, reference,
      fix, segment, call, diagram, scatter, heatmap, breaks, genemetrics, gainloss,
      sex, gender, metrics, segmetrics, bintest, import-picard, import-seg, import-theta,
      import-rna, export, version'
    inputBinding:
      position: 1
  - id: subcommand_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specific subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
stdout: cnvkit_cnvkit.py.out
