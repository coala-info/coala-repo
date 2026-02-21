cwlVersion: v1.2
class: CommandLineTool
baseCommand: spaln_sort-gff
label: spaln_sort-gff
doc: "A utility for sorting GFF files (Note: The provided text contains container
  runtime errors and does not include the tool's help documentation).\n\nTool homepage:
  http://www.genome.ist.i.kyoto-u.ac.jp/~aln_user/spaln/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
stdout: spaln_sort-gff.out
