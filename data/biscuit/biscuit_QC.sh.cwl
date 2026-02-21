cwlVersion: v1.2
class: CommandLineTool
baseCommand: QC.sh
label: biscuit_QC.sh
doc: "BISCUIT quality control script for aligned BAM files\n\nTool homepage: https://github.com/huishenlab/biscuit"
inputs:
  - id: assets_directory
    type: Directory
    doc: Path to assets directory
    inputBinding:
      position: 1
  - id: genome
    type: File
    doc: Path to reference FASTA file used in alignment
    inputBinding:
      position: 2
  - id: sample_name
    type: string
    doc: Prefix of output files
    inputBinding:
      position: 3
  - id: input_bam
    type: File
    doc: Aligned BAM from BISCUIT
    inputBinding:
      position: 4
  - id: keep_tmp_files
    type:
      - 'null'
      - boolean
    doc: 'Flag to keep temporary files for debugging [DEFAULT: Delete files]'
    inputBinding:
      position: 105
      prefix: --keep-tmp-files
  - id: n_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for coverage
    default: 1
    inputBinding:
      position: 105
      prefix: --n-threads
  - id: no_cov_qc
    type:
      - 'null'
      - boolean
    doc: 'Do not perform coverage or coverage uniformity QC [DEFAULT: Runs coverage
      QC]'
    inputBinding:
      position: 105
      prefix: --no-cov-qc
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: 'Input BAM is from single end data [DEFAULT: Assumes paired-end]'
    inputBinding:
      position: 105
      prefix: --single-end
  - id: vcf
    type:
      - 'null'
      - File
    doc: Path to VCF output from BISCUIT
    inputBinding:
      position: 105
      prefix: --vcf
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
