cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-seg_genomic_slimcomplots.sh
label: ncbi-seg_genomic_slimcomplots.sh
doc: "A script for genomic slimcomplots using ncbi-seg. Note: The provided help text
  contains only system error messages regarding container image conversion and disk
  space, and does not list specific command-line arguments.\n\nTool homepage: https://github.com/abelardoacm/genomic_seg_plots"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ncbi-seg:v0.0.20000620-5-deb_cv1
stdout: ncbi-seg_genomic_slimcomplots.sh.out
