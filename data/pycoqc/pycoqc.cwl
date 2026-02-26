cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycoqc
label: pycoqc
doc: "PycoQC is a Python package to generate quality control plots for Oxford Nanopore
  sequencing data.\n\nTool homepage: https://github.com/EnrightLab/pycoQC"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum read length to consider
    inputBinding:
      position: 102
      prefix: --max-length
  - id: max_quality
    type:
      - 'null'
      - int
    doc: Maximum read quality score to consider
    default: 40
    inputBinding:
      position: 102
      prefix: --max-quality
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum read length to consider
    default: 0
    inputBinding:
      position: 102
      prefix: --min-length
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Minimum read quality score to consider
    default: 0
    inputBinding:
      position: 102
      prefix: --min-quality
  - id: no_plots
    type:
      - 'null'
      - boolean
    doc: Do not generate plots
    inputBinding:
      position: 102
      prefix: --no-plots
  - id: no_report
    type:
      - 'null'
      - boolean
    doc: Do not generate report
    inputBinding:
      position: 102
      prefix: --no-report
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory for plots and reports
    default: .
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycoqc:2.5.2--py_0
stdout: pycoqc.out
