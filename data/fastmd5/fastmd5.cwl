cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastmd5
label: fastmd5
doc: "Calculate MD5 checksums for FASTQ files.\n\nTool homepage: https://github.com/moold/fastMD5"
inputs:
  - id: fastq_files
    type:
      type: array
      items: File
    doc: One or more FASTQ files to process.
    inputBinding:
      position: 1
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress progress messages.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use (default: 1).'
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to a file instead of stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastmd5:1.0.0--h3ab6199_0
