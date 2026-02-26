cwlVersion: v1.2
class: CommandLineTool
baseCommand: mvip MVP_06_do_functional_annotation
label: mvip_MVP_06_do_functional_annotation
doc: "Functional annotation of protein sequences against multiple databases.\n\nTool
  homepage: https://gitlab.com/ccoclet/mvp"
inputs:
  - id: ads
    type:
      - 'null'
      - boolean
    doc: Include this flag to search ADS profiles.
    inputBinding:
      position: 101
      prefix: --ADS
  - id: ads_evalue
    type:
      - 'null'
      - float
    doc: Significance e-value of match between target sequences and query
    default: 0.01
    inputBinding:
      position: 101
      prefix: --ADS_evalue
  - id: ads_score
    type:
      - 'null'
      - int
    doc: Significant score of match between target sequences and query
    default: 60
    inputBinding:
      position: 101
      prefix: --ADS_score
  - id: delete_files
    type:
      - 'null'
      - boolean
    doc: flag to delete unwanted files
    inputBinding:
      position: 101
  - id: dram
    type:
      - 'null'
      - boolean
    doc: Include this flag to create a file to be process through DRAM-v.
    inputBinding:
      position: 101
      prefix: --DRAM
  - id: fasta_files
    type:
      - 'null'
      - string
    doc: Sequence and protein FASTA files (representative or all sequences) to 
      use for functional annotation.
    default: representative
    inputBinding:
      position: 101
  - id: force_ads
    type:
      - 'null'
      - boolean
    doc: Force ADS annotation.
    inputBinding:
      position: 101
      prefix: --force_ADS
  - id: force_outputs
    type:
      - 'null'
      - boolean
    doc: Force creation of final annotation table even though it exists.
    inputBinding:
      position: 101
      prefix: --force_outputs
  - id: force_pfam
    type:
      - 'null'
      - boolean
    doc: Force PFAM annotation.
    inputBinding:
      position: 101
      prefix: --force_PFAM
  - id: force_phrogs
    type:
      - 'null'
      - boolean
    doc: Force PHROGS annotation.
    inputBinding:
      position: 101
      prefix: --force_PHROGS
  - id: force_prodigal
    type:
      - 'null'
      - boolean
    doc: Force execution of protein prediction by Prodigal.
    inputBinding:
      position: 101
      prefix: --force_prodigal
  - id: force_rdrp
    type:
      - 'null'
      - boolean
    doc: Force RdRP annotation.
    inputBinding:
      position: 101
      prefix: --force_RdRP
  - id: metadata_path
    type: File
    doc: Path to your metadata that you want to use to run MVP.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: pfam_evalue
    type:
      - 'null'
      - float
    doc: Significance e-value of match between target sequences and query
    default: 0.01
    inputBinding:
      position: 101
      prefix: --PFAM_evalue
  - id: pfam_score
    type:
      - 'null'
      - int
    doc: Significant score of match between target sequences and query
    default: 50
    inputBinding:
      position: 101
      prefix: --PFAM_score
  - id: phrogs_evalue
    type:
      - 'null'
      - float
    doc: Significance e-value of match between target sequences and query
    default: 0.01
    inputBinding:
      position: 101
      prefix: --PHROGS_evalue
  - id: phrogs_score
    type:
      - 'null'
      - int
    doc: Significant score of match between target sequences and query
    default: 50
    inputBinding:
      position: 101
      prefix: --PHROGS_score
  - id: rdrp
    type:
      - 'null'
      - boolean
    doc: Include this flag to create the 07_RDRP_PHYLOGENY folder and search 
      RdRP profiles.
    inputBinding:
      position: 101
      prefix: --RdRP
  - id: rdrp_evalue
    type:
      - 'null'
      - float
    doc: Significance e-value of match between target sequences and query
    default: 0.01
    inputBinding:
      position: 101
      prefix: --RdRP_evalue
  - id: rdrp_score
    type:
      - 'null'
      - int
    doc: Significant score of match between target sequences and query
    default: 50
    inputBinding:
      position: 101
      prefix: --RdRP_score
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: working_directory_path
    type: Directory
    doc: Path to your working directory where you want to run MVP.
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
stdout: mvip_MVP_06_do_functional_annotation.out
