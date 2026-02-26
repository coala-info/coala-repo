cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - iobrpy
  - fastq_qc
label: iobrpy_fastq_qc
doc: "Perform quality control on FASTQ files using fastp.\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Number of concurrent samples (processes)
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: length_required
    type:
      - 'null'
      - int
    doc: Minimum read length to keep
    inputBinding:
      position: 101
      prefix: --length_required
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Threads per fastp process
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: path1_fastq
    type: Directory
    doc: Directory containing raw FASTQ files
    inputBinding:
      position: 101
      prefix: --path1_fastq
  - id: se
    type:
      - 'null'
      - boolean
    doc: Single-end sequencing; omit for paired-end
    inputBinding:
      position: 101
      prefix: --se
  - id: suffix1
    type:
      - 'null'
      - string
    doc: R1 suffix; R2 inferred by replacing '1' with '2'
    inputBinding:
      position: 101
      prefix: --suffix1
outputs:
  - id: path2_fastp
    type: Directory
    doc: Output directory for cleaned FASTQ files
    outputBinding:
      glob: $(inputs.path2_fastp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
