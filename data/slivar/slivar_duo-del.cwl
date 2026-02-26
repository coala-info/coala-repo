cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slivar
  - duodel
label: slivar_duo-del
doc: "find denovo structural deletions in parent-child duos using non-transmission
  of SNPs\n\nTool homepage: https://github.com/brentp/slivar"
inputs:
  - id: vcf
    type:
      - 'null'
      - File
    doc: input SNP/indel VCF
    default: /dev/stdin
    inputBinding:
      position: 1
  - id: affected_only
    type:
      - 'null'
      - boolean
    doc: only output DEL calls for affected kids
    inputBinding:
      position: 102
      prefix: --affected-only
  - id: exclude
    type:
      - 'null'
      - File
    doc: path to BED file of exclude regions e.g. (LCRs or self-chains)
    inputBinding:
      position: 102
      prefix: --exclude
  - id: gnotate
    type:
      - 'null'
      - File
    doc: optional gnotate file to check for flagged variants to exclude
    inputBinding:
      position: 102
      prefix: --gnotate
  - id: min_sites
    type:
      - 'null'
      - int
    doc: minimum number of variants required to define a region (use 1 to output
      all putative deletions)
    default: 3
    inputBinding:
      position: 102
      prefix: --min-sites
  - id: min_size
    type:
      - 'null'
      - int
    doc: minimum size in base-pairs of a region
    default: 50
    inputBinding:
      position: 102
      prefix: --min-size
  - id: ped
    type: File
    doc: required ped file describing the duos in the VCF
    inputBinding:
      position: 102
      prefix: --ped
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slivar:0.3.3--h5f107b1_0
stdout: slivar_duo-del.out
