cwlVersion: v1.2
class: CommandLineTool
baseCommand: virmet covplot
label: virmet_covplot
doc: "Generate coverage plots for viral genomes.\n\nTool homepage: https://github.com/medvir/VirMet"
inputs:
  - id: genome_fasta
    type:
      - 'null'
      - File
    doc: Optional FASTA file of the reference genome.
    inputBinding:
      position: 101
      prefix: --genome-fasta
  - id: input_bam
    type: File
    doc: Input BAM file containing coverage data.
    inputBinding:
      position: 101
      prefix: --input-bam
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: Maximum coverage depth to consider for plotting.
    default: 1000
    inputBinding:
      position: 101
      prefix: --max-coverage
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage depth to consider for plotting.
    default: 1
    inputBinding:
      position: 101
      prefix: --min-coverage
  - id: organism
    type: string
    doc: Name of the organism to plot coverage for.
    inputBinding:
      position: 101
      prefix: --organism
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save the output plots.
    default: .
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: plot_format
    type:
      - 'null'
      - string
    doc: Format of the output plots (e.g., png, svg, pdf).
    default: png
    inputBinding:
      position: 101
      prefix: --plot-format
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for processing.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virmet:2.0.1--pyhdfd78af_0
stdout: virmet_covplot.out
