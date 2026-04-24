cwlVersion: v1.2
class: CommandLineTool
baseCommand: interleafq
label: interleafq
doc: "Interleaves FASTQ files.\n\nTool homepage: https://github.com/quadram-institute-bioscience/interleafq/"
inputs:
  - id: fastq_files
    type:
      type: array
      items: File
    doc: Input FASTQ files to interleave.
    inputBinding:
      position: 1
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Number of reads per chunk for interleaving.
    inputBinding:
      position: 102
      prefix: --chunksize
  - id: interleave_mode
    type:
      - 'null'
      - string
    doc: "Interleaving mode. Options: 'interleave' (default), 'concat'."
    inputBinding:
      position: 102
      prefix: --mode
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
    doc: Number of threads to use.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output interleaved FASTQ file. If not specified, output to stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/interleafq:1.1.0--pl5321hdfd78af_2
