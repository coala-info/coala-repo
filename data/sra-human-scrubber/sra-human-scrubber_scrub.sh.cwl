cwlVersion: v1.2
class: CommandLineTool
baseCommand: scrub.sh
label: sra-human-scrubber_scrub.sh
doc: "The SRA Human Scrubber is used to remove human reads from SRA data. It uses
  a set of reference databases to identify and mask/remove human sequences.\n\nTool
  homepage: https://github.com/ncbi/sra-human-scrubber"
inputs:
  - id: clean_up
    type:
      - 'null'
      - boolean
    doc: Remove temporary files after processing
    inputBinding:
      position: 101
      prefix: -x
  - id: db_directory
    type:
      - 'null'
      - Directory
    doc: Path to the directory containing the scrubber databases
    inputBinding:
      position: 101
      prefix: -d
  - id: input_file
    type: File
    doc: Input FASTQ file (can be gzipped)
    inputBinding:
      position: 101
      prefix: -i
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: output_file
    type: File
    doc: Output file name for the scrubbed FASTQ
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-human-scrubber:2.2.1--hdfd78af_0
