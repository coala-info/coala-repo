cwlVersion: v1.2
class: CommandLineTool
baseCommand: hlso
label: haplotype-lso_hlso
doc: "Classify Lso Sanger reads.\n\nTool homepage: https://github.com/holtgrewe/haplotype-lso"
inputs:
  - id: subcommand
    type: string
    doc: 'Subcommand to run. Available options: convert, cli, web, paste, ref_download,
      ref_blast, ref_consensus'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplotype-lso:0.4.4--pyhdfd78af_4
stdout: haplotype-lso_hlso.out
