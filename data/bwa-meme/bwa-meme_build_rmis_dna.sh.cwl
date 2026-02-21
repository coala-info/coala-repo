cwlVersion: v1.2
class: CommandLineTool
baseCommand: build_rmis_dna.sh
label: bwa-meme_build_rmis_dna.sh
doc: "Learned-index training script for BWA-MEME. For human reference, training requires
  around 15 minutes and 64GB memory.\n\nTool homepage: https://github.com/kaist-ina/BWA-MEME"
inputs:
  - id: reference_file
    type: File
    doc: Reference fasta file
    inputBinding:
      position: 1
  - id: num_models_exponent
    type:
      - 'null'
      - int
    doc: Set number of models to use for second layer as a power of 2 (e.g., 26 for
      2^26)
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa-meme:1.0.6--hdcf5f25_2
stdout: bwa-meme_build_rmis_dna.sh.out
