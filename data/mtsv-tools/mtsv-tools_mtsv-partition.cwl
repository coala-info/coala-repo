cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv-partition
label: mtsv-tools_mtsv-partition
doc: "Split reads into matched/unmatched sets based on mtsv results.\n\nTool homepage: https://github.com/FofanovLab/mtsv_tools"
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
  - id: matched
    type: string
    doc: Output path for reads present in results.
    inputBinding:
      prefix: --matched
  - id: results
    type:
      type: array
      items: File
    doc: Path(s) to mtsv results files.
    inputBinding:
      prefix: --results
  - id: unmatched
    type: string
    doc: Output path for reads not present in results.
    inputBinding:
      prefix: --unmatched
  - id: verbose
    type: ['null', boolean]
    doc: Include this flag to trigger debug-level logging.
    inputBinding:
      prefix: -v
outputs:
  - id: matched_reads
    type: File
    doc: Reads present in the results
    outputBinding:
      glob: $(inputs.matched)
  - id: unmatched_reads
    type: File
    doc: Reads not present in the results
    outputBinding:
      glob: $(inputs.unmatched)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv-tools:2.1.0--h54198d6_0
