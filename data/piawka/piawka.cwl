cwlVersion: v1.2
class: CommandLineTool
baseCommand: piawka
label: piawka
doc: "A tool for calculating population genetics statistics (pi, Dxy, Fst, etc.) from
  VCF files.\n\nTool homepage: https://github.com/novikovalab/piawka"
inputs:
  - id: bed
    type:
      - 'null'
      - File
    doc: BED file with regions to be analyzed
    inputBinding:
      position: 101
      prefix: --bed
  - id: fst
    type:
      - 'null'
      - boolean
    doc: output Hudson Fst
    inputBinding:
      position: 101
      prefix: --fst
  - id: fstwc
    type:
      - 'null'
      - boolean
    doc: output Weir and Cockerham Fst instead
    inputBinding:
      position: 101
      prefix: --fstwc
  - id: groups
    type: File
    doc: either 2-columns sample / group table or keywords "unite" (1 group) or "divide"
      (n_samples groups)
    inputBinding:
      position: 101
      prefix: --groups
  - id: het
    type:
      - 'null'
      - boolean
    doc: output only per-sample pi = heterozygosity
    inputBinding:
      position: 101
      prefix: --het
  - id: jobs
    type:
      - 'null'
      - int
    doc: number of parallel jobs to run
    inputBinding:
      position: 101
      prefix: --jobs
  - id: miss
    type:
      - 'null'
      - float
    doc: max share of missing GT per group at site, 0.0-1.0
    inputBinding:
      position: 101
      prefix: --miss
  - id: mult
    type:
      - 'null'
      - boolean
    doc: use multiallelic sites
    inputBinding:
      position: 101
      prefix: --mult
  - id: nodxy
    type:
      - 'null'
      - boolean
    doc: do not output Dxy
    inputBinding:
      position: 101
      prefix: --nodxy
  - id: nopi
    type:
      - 'null'
      - boolean
    doc: do not output pi
    inputBinding:
      position: 101
      prefix: --nopi
  - id: persite
    type:
      - 'null'
      - boolean
    doc: output values for each site
    inputBinding:
      position: 101
      prefix: --persite
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: do not output progress and warning messages
    inputBinding:
      position: 101
      prefix: --quiet
  - id: rho
    type:
      - 'null'
      - boolean
    doc: output Ronfort's rho
    inputBinding:
      position: 101
      prefix: --rho
  - id: tajima
    type:
      - 'null'
      - boolean
    doc: output classic TajimaD instead (affected by missing data)
    inputBinding:
      position: 101
      prefix: --tajima
  - id: tajimalike
    type:
      - 'null'
      - boolean
    doc: output TajimaD-like stat (manages missing data but untested)
    inputBinding:
      position: 101
      prefix: --tajimalike
  - id: targets
    type:
      - 'null'
      - File
    doc: BED file with targets (faster for numerous small regions)
    inputBinding:
      position: 101
      prefix: --targets
  - id: vcf
    type: File
    doc: gzipped and tabixed VCF file
    inputBinding:
      position: 101
      prefix: --vcf
  - id: watterson
    type:
      - 'null'
      - boolean
    doc: output Watterson's theta
    inputBinding:
      position: 101
      prefix: --watterson
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/piawka:0.8.11--hdfd78af_0
stdout: piawka.out
