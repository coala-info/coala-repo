cwlVersion: v1.2
class: CommandLineTool
baseCommand: Genomesetup
label: snakealtpromoter_Genomesetup
doc: "Execute the AltPromoterFlow genome setup pipeline to generate genome indices
  and annotations.\n\nTool homepage: https://github.com/YidanSunResearchLab/SnakeAltPromoter"
inputs:
  - id: genes_gtf
    type: File
    doc: Path to the GTF file for gene annotations (e.g., 
      /path/to/gencode.v38.annotation.gtf).
    inputBinding:
      position: 101
      prefix: --genes_gtf
  - id: organism
    type: string
    doc: Reference genome assembly (e.g., 'hg38', 'mm10', 'dm6').
    inputBinding:
      position: 101
      prefix: --organism
  - id: organism_fasta
    type: File
    doc: Path to the organism FASTA file with 'chr' prefix (e.g., 
      /path/to/hg38.fa).
    inputBinding:
      position: 101
      prefix: --organism_fasta
  - id: output_dir
    type: Directory
    doc: Absolute path to the output directory for storing generated genome 
      files.
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPU threads for parallel processing (default: 16).'
    default: 16
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakealtpromoter:1.0.5--pyhdfd78af_0
stdout: snakealtpromoter_Genomesetup.out
