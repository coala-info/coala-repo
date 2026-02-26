cwlVersion: v1.2
class: CommandLineTool
baseCommand: upd
label: upd_regions
doc: "Manage UPF regions\n\nTool homepage: https://github.com/bjhall/upd"
inputs:
  - id: vcf
    type: File
    doc: VCF file
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/upd:0.1.1--pyhdfd78af_0
stdout: upd_regions.out
