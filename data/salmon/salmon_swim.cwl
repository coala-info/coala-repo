cwlVersion: v1.2
class: CommandLineTool
baseCommand: salmon_swim
label: salmon_swim
doc: "A tool for single-cell RNA-seq analysis.\n\nTool homepage: https://github.com/COMBINE-lab/salmon"
inputs:
  - id: input_dir
    type: Directory
    doc: Directory containing the input FASTQ files.
    inputBinding:
      position: 1
  - id: genome
    type:
      - 'null'
      - File
    doc: Path to the genome FASTA file.
    inputBinding:
      position: 102
      prefix: --genome
  - id: index
    type:
      - 'null'
      - Directory
    doc: Path to a pre-built Salmon index.
    inputBinding:
      position: 102
      prefix: --index
  - id: mapping
    type:
      - 'null'
      - boolean
    doc: Perform mapping to transcriptome.
    inputBinding:
      position: 102
      prefix: --mapping
  - id: quant
    type:
      - 'null'
      - boolean
    doc: Perform quantification.
    inputBinding:
      position: 102
      prefix: --quant
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for computation.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: transcriptome
    type:
      - 'null'
      - File
    doc: Path to the transcriptome FASTA file.
    inputBinding:
      position: 102
      prefix: --transcriptome
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_dir
    type: Directory
    doc: Directory to save the output files.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/salmon:1.10.3--h45fbf2d_5
