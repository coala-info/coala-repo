cwlVersion: v1.2
class: CommandLineTool
baseCommand: fuc ngs-bam2fq
label: fuc_ngs-bam2fq
doc: "Pipeline for converting BAM files to FASTQ files.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: manifest
    type: File
    doc: Sample manifest CSV file.
    inputBinding:
      position: 1
  - id: output
    type: Directory
    doc: Output directory.
    inputBinding:
      position: 2
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite the output directory if it already exists.
    inputBinding:
      position: 103
      prefix: --force
  - id: qsub
    type:
      - 'null'
      - string
    doc: SGE resoruce to request with qsub for BAM to FASTQ conversion. Since 
      this oppoeration supports multithreading, it is recommended to speicfy a 
      parallel environment (PE) to speed up the process (also see --thread).
    inputBinding:
      position: 103
      prefix: --qsub
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 103
      prefix: --thread
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_ngs-bam2fq.out
