cwlVersion: v1.2
class: CommandLineTool
baseCommand: [upd]
label: upd_sites
doc: "Prints the sites that are informative for UPD\n\nTool homepage: https://github.com/bjhall/upd"
inputs:
  - id: vcf
    type: File
    doc: Trio VCF file (proband, mother and father in the same VCF)
    inputBinding:
      position: 1
      prefix: --vcf
  - id: proband
    type: string
    doc: ID of proband in VCF
    inputBinding:
      position: 2
      prefix: --proband
  - id: mother
    type: string
    doc: ID of mother in VCF
    inputBinding:
      position: 3
      prefix: --mother
  - id: father
    type: string
    doc: ID of father in VCF
    inputBinding:
      position: 4
      prefix: --father
  - id: af_tag
    type: ['null', string]
    doc: Which field to use for population frequency filtering (default MAX_AF)
    inputBinding:
      position: 5
      prefix: --af-tag
  - id: vep
    type: ['null', boolean]
    doc: If af-tag is in VEP annotation
    inputBinding:
      position: 6
      prefix: --vep
  - id: min_af
    type: ['null', float]
    doc: Minimum SNP frequency (default 0.05)
    inputBinding:
      position: 7
      prefix: --min-af
  - id: min_gq
    type: ['null', int]
    doc: Minimum GQ score (default 30)
    inputBinding:
      position: 8
      prefix: --min-gq
  - id: loglevel
    type: ['null', string]
    doc: "Set the level of log output: DEBUG, INFO, WARNING, ERROR or CRITICAL (default INFO)"
    inputBinding:
      position: 9
      prefix: --loglevel
  - id: out
    type: ['null', string]
    doc: Output bed file name; if not given, the result goes to standard output
    inputBinding:
      position: 70
      prefix: --out
outputs:
  - id: out_file
    type: ['null', File]
    doc: Result file written with --out
    outputBinding:
      glob: $(inputs.out)
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 50
    valueFrom: sites
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/upd:0.1.1--pyhdfd78af_0
stdout: upd_sites.out
