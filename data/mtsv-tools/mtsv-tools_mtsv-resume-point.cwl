cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv-resume-point
label: mtsv-tools_mtsv-resume-point
doc: "Find the read offset of the last read present in mtsv results.\n\nTool homepage: https://github.com/FofanovLab/mtsv_tools"
stdout: resume_point.txt
inputs:
  - id: fasta
    type: ['null', File]
    doc: Path to FASTA reads.
    inputBinding:
      prefix: --fasta
  - id: fastq
    type: ['null', File]
    doc: Path to FASTQ reads.
    inputBinding:
      prefix: --fastq
  - id: results
    type: File
    doc: Path to mtsv results file.
    inputBinding:
      prefix: --results
  - id: verbose
    type: ['null', boolean]
    doc: Include this flag to trigger debug-level logging.
    inputBinding:
      prefix: -v
outputs:
  - id: resume_point
    type: stdout
    doc: Read offset of the last read present in the results
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv-tools:2.1.0--h54198d6_0
