cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqyclean
label: seqyclean
doc: "A tool for preprocessing NGS data, including adapter trimming, quality filtering,
  and contaminant removal.\n\nTool homepage: https://github.com/ibest/seqyclean"
inputs:
  - id: fastq1
    type: File
    doc: Forward reads file (FASTQ)
    inputBinding:
      position: 101
      prefix: --fastq1
  - id: fastq2
    type:
      - 'null'
      - File
    doc: Reverse reads file (FASTQ)
    inputBinding:
      position: 101
      prefix: --fastq2
  - id: kmer_file
    type:
      - 'null'
      - File
    doc: K-mer file for contamination filtering
    inputBinding:
      position: 101
      prefix: --kmer-file
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum read length
    inputBinding:
      position: 101
      prefix: --min-len
  - id: n_content
    type:
      - 'null'
      - int
    doc: Maximum N content allowed
    inputBinding:
      position: 101
      prefix: --n-content
  - id: qual_calib
    type:
      - 'null'
      - File
    doc: Quality calibration file
    inputBinding:
      position: 101
      prefix: --qual-calib
  - id: qual_cut
    type:
      - 'null'
      - int
    doc: Quality score cutoff
    inputBinding:
      position: 101
      prefix: --qual-cut
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_prefix
    type: File
    doc: Prefix for output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqyclean:1.10.09--h5ca1c30_6
