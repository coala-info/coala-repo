cwlVersion: v1.2
class: CommandLineTool
baseCommand: MotifRaptor
label: motifraptor_MotifRaptor
doc: "Analyze motifs and SNPs in the dataset.\n\nTool homepage: https://github.com/pinellolab/MotifRaptor"
inputs:
  - id: subcommand
    type: string
    doc: 'Subcommand to run. Available subcommands: preprocess, preprocess_ukbb_v3,
      celltype, snpmotif, snpfeature, motiffilter, motifspecific, snpspecific, snpmotifradar,
      snpindex, snpscan, set, info'
    inputBinding:
      position: 1
  - id: celltype
    type:
      - 'null'
      - boolean
    doc: cell type or tissue type analysis help
    inputBinding:
      position: 102
      prefix: celltype
  - id: info
    type:
      - 'null'
      - boolean
    doc: Get Informationa and Print Global Values
    inputBinding:
      position: 102
      prefix: info
  - id: motiffilter
    type:
      - 'null'
      - boolean
    doc: motifs filtering help
    inputBinding:
      position: 102
      prefix: motiffilter
  - id: motifspecific
    type:
      - 'null'
      - boolean
    doc: motifs specific analysis help
    inputBinding:
      position: 102
      prefix: motifspecific
  - id: preprocess
    type:
      - 'null'
      - boolean
    doc: Pre-process the summary statistics
    inputBinding:
      position: 102
      prefix: preprocess
  - id: preprocess_ukbb_v3
    type:
      - 'null'
      - boolean
    doc: Pre-process the summary statistics from UKBB version 3 TSV files
    inputBinding:
      position: 102
      prefix: preprocess_ukbb_v3
  - id: set
    type:
      - 'null'
      - boolean
    doc: Set Path and Global Values
    inputBinding:
      position: 102
      prefix: set
  - id: snpfeature
    type:
      - 'null'
      - boolean
    doc: snp feature help
    inputBinding:
      position: 102
      prefix: snpfeature
  - id: snpindex
    type:
      - 'null'
      - boolean
    doc: index the SNPs (with flanking sequences) help
    inputBinding:
      position: 102
      prefix: snpindex
  - id: snpmotif
    type:
      - 'null'
      - boolean
    doc: snp motif test help
    inputBinding:
      position: 102
      prefix: snpmotif
  - id: snpmotifradar
    type:
      - 'null'
      - boolean
    doc: SNP motif radar plot help
    inputBinding:
      position: 102
      prefix: snpmotifradar
  - id: snpscan
    type:
      - 'null'
      - boolean
    doc: scan SNP database (already indexed) help
    inputBinding:
      position: 102
      prefix: snpscan
  - id: snpspecific
    type:
      - 'null'
      - boolean
    doc: SNP specific analysis help
    inputBinding:
      position: 102
      prefix: snpspecific
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
stdout: motifraptor_MotifRaptor.out
