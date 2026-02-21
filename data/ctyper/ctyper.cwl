cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctyper
label: ctyper
doc: "A tool for genotyping and estimating NGS read depth using a matrix database.\n
  \nTool homepage: https://github.com/ChaissonLab/Ctyper"
inputs:
  - id: background
    type:
      - 'null'
      - File
    doc: Background k-mer file to estimate NGS coverage (incompatible with -d/-D).
    inputBinding:
      position: 101
      prefix: --background
  - id: bed_file
    type:
      - 'null'
      - File
    doc: BED file to restrict region analysis.
    inputBinding:
      position: 101
      prefix: -B
  - id: corr
    type:
      - 'null'
      - int
    doc: Enable NGS k-mer bias correction (0/1).
    default: 1
    inputBinding:
      position: 101
      prefix: --corr
  - id: depth
    type:
      - 'null'
      - float
    doc: Fixed 31-mer depth value (incompatible with -b/--background).
    inputBinding:
      position: 101
      prefix: --depth
  - id: depth_file
    type:
      - 'null'
      - File
    doc: File of depth values corresponding to each input (incompatible with -b/--background).
    inputBinding:
      position: 101
      prefix: --Depth
  - id: gene
    type:
      - 'null'
      - type: array
        items: string
    doc: Target gene name, prefix (ending with '*'), or matrix (starting with '#').
      Can be specified multiple times.
    inputBinding:
      position: 101
      prefix: --gene
  - id: genes_file
    type:
      - 'null'
      - File
    doc: File listing target genes or matrices.
    inputBinding:
      position: 101
      prefix: --Genes
  - id: input
    type:
      - 'null'
      - File
    doc: Input NGS file; supports CRAM, BAM, SAM, FASTA, FASTQ, or Jellyfish formats.
    inputBinding:
      position: 101
      prefix: --input
  - id: inputs_list
    type:
      - 'null'
      - File
    doc: Path to a file listing multiple input files.
    inputBinding:
      position: 101
      prefix: --Inputs
  - id: matrix
    type: File
    doc: Path to the matrix database (requires <file>.index). If not provided, the
      tool runs in dry-run mode to only estimate NGS read depth.
    inputBinding:
      position: 101
      prefix: --matrix
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Number of threads to run different samples in parallel.
    default: 1
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: profile
    type:
      - 'null'
      - File
    doc: Input aligned NGS file for profiling.
    inputBinding:
      position: 101
      prefix: --profile
  - id: profile_list
    type:
      - 'null'
      - File
    doc: File listing multiple aligned NGS files for profiling.
    inputBinding:
      position: 101
      prefix: --Profile
  - id: ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA for reading CRAM files.
    inputBinding:
      position: 101
      prefix: -T
  - id: region
    type:
      - 'null'
      - type: array
        items: string
    doc: Add a specific region for analysis (chr:start-end) or special keys ('gene',
      'Unmap', 'HLA').
    inputBinding:
      position: 101
      prefix: -r
  - id: subthreads
    type:
      - 'null'
      - int
    doc: Number of threads to run each sample.
    default: 1
    inputBinding:
      position: 101
      prefix: --subthreads
  - id: unmap
    type:
      - 'null'
      - int
    doc: Force include:1 or exclude:0 unmapped reads (only valid in target run).
    inputBinding:
      position: 101
      prefix: --unmap
  - id: window
    type:
      - 'null'
      - int
    doc: Window size for k-mer coverage report.
    default: 30
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'Output file (append if file exits, default: stdout)'
    outputBinding:
      glob: $(inputs.output)
  - id: outputs_list
    type:
      - 'null'
      - File
    doc: Path to a file listing output files corresponding to each input file.
    outputBinding:
      glob: $(inputs.outputs_list)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctyper:1.0.5--h5ca1c30_0
