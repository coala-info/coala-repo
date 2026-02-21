cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgGoldGapGl
label: ucsc-hggoldgapgl
doc: "A UCSC Genome Browser utility, likely used for processing 'gold', 'gap', and
  'gl' (scaffold) files. Note: The provided help text contains only container runtime
  error messages and no usage information.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hggoldgapgl:377--h199ee4e_0
stdout: ucsc-hggoldgapgl.out
