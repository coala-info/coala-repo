cwlVersion: v1.2
class: CommandLineTool
baseCommand: panaroo-fmg
label: panaroo_fmg
doc: "Estimate parameters of the Finitely Many Genes model from a dated phylogeny and a Panaroo presence/absence file.

Tool homepage: https://gtonkinhill.github.io/panaroo"
inputs:
  - id: tree
    type: File
    doc: "A dated phylogeny."
    inputBinding:
      prefix: --tree
  - id: pa
    type: File
    doc: "A presence/absence file produced by Panaroo."
    inputBinding:
      prefix: --pa
  - id: outfile
    type: string
    doc: "Name of the output file."
    inputBinding:
      prefix: --outfile
  - id: nboot
    type:
      - 'null'
      - int
    doc: "The number of sub-sampling bootstrap iterations to perform."
    inputBinding:
      prefix: --nboot
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use (default 1)."
    inputBinding:
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print additional output."
    inputBinding:
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Estimated model parameters."
    outputBinding:
      glob: $(inputs.outfile)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
stdout: panaroo_fmg.out
