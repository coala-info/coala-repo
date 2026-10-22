cwlVersion: v1.2
class: CommandLineTool
baseCommand: scrub.sh
label: sra-human-scrubber_scrub.sh
doc: "The SRA Human Scrubber is used to remove human reads from SRA data. It uses
  a set of reference databases to identify and mask/remove human sequences.\n\nTool
  homepage: https://github.com/ncbi/sra-human-scrubber"
inputs:
  - id: input_file
    type: File
    doc: Input Fastq File.
    inputBinding:
      position: 101
      prefix: -i
  - id: output_file_path
    type: string
    doc: Save cleaned sequence reads to this file.
    inputBinding:
      position: 102
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: -p
  - id: database
    type:
      - 'null'
      - File
    doc: Specify a database file other than the default to use.
    inputBinding:
      position: 101
      prefix: -d
  - id: remove_spots
    type:
      - 'null'
      - boolean
    doc: Remove spots instead of the default 'N' replacement.
    inputBinding:
      position: 101
      prefix: -x
  - id: save_spots
    type:
      - 'null'
      - boolean
    doc: Save identified spots to <input_file>.removed_spots.
    inputBinding:
      position: 101
      prefix: -r
  - id: spots_file_path
    type:
      - 'null'
      - string
    doc: Save identified spots to this user named file.
    inputBinding:
      position: 101
      prefix: -u
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: Input is (collated) interleaved paired-end(read) file AND you wish both
      reads masked or removed.
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: output_file
    type: File
    doc: Output file name for the scrubbed FASTQ
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: spots_removed
    type:
      - 'null'
      - File
    doc: Identified spots written with -r or -u
    outputBinding:
      glob: "$(inputs.spots_file_path ? inputs.spots_file_path : '*.removed_spots')"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-human-scrubber:2.2.1--hdfd78af_0
