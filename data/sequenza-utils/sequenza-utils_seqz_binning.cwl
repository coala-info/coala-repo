cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sequenza-utils
  - seqz_binning
label: sequenza-utils_seqz_binning
doc: "Binning of the genome based on allele frequencies.\n\nTool homepage: http://sequenza-utils.readthedocs.org"
inputs:
  - id: input_file
    type: File
    doc: Input file (e.g. seqz.txt)
    inputBinding:
      position: 1
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum depth for a bin to be considered
    default: 1000
    inputBinding:
      position: 102
      prefix: --max-depth
  - id: max_freq
    type:
      - 'null'
      - float
    doc: Maximum allele frequency for a bin to be considered
    default: 0.9
    inputBinding:
      position: 102
      prefix: --max-freq
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum length of a bin to be considered
    default: 1000000
    inputBinding:
      position: 102
      prefix: --max-len
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth for a bin to be considered
    default: 20
    inputBinding:
      position: 102
      prefix: --min-depth
  - id: min_freq
    type:
      - 'null'
      - float
    doc: Minimum allele frequency for a bin to be considered
    default: 0.1
    inputBinding:
      position: 102
      prefix: --min-freq
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum length of a bin to be considered
    default: 10000
    inputBinding:
      position: 102
      prefix: --min-len
  - id: output_dir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: step
    type:
      - 'null'
      - int
    doc: Step size for binning (bp)
    default: 50000
    inputBinding:
      position: 102
      prefix: --step
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: window
    type:
      - 'null'
      - int
    doc: Window size for binning (bp)
    default: 100000
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
stdout: sequenza-utils_seqz_binning.out
