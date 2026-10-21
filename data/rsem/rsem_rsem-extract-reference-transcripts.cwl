cwlVersion: v1.2
class: CommandLineTool
baseCommand: [rsem-extract-reference-transcripts]
label: rsem_rsem-extract-reference-transcripts
doc: "Extract the transcript sequences and RSEM transcript information from genome FASTA files and a GTF file (the first step of rsem-prepare-reference).\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: ref_name
    type: string
    doc: Name (prefix) of the reference to write.
    inputBinding:
      position: 1
  - id: quiet
    type: int
    default: 0
    doc: 1 to stop outputting intermediate information, 0 otherwise.
    inputBinding:
      position: 2
  - id: gtf_file
    type: File
    doc: Input GTF file.
    inputBinding:
      position: 3
  - id: sources
    type: string
    default: None
    doc: Comma-separated list of trusted GTF sources (spaces escaped), or None to accept all sources.
    inputBinding:
      position: 4
  - id: has_mapping_file
    type: int
    default: 0
    doc: 1 if a transcript-to-gene mapping file is given, 0 otherwise.
    inputBinding:
      position: 5
  - id: mapping_file
    type: ['null', File]
    doc: Transcript-to-gene mapping file (only when has_mapping_file is 1).
    inputBinding:
      position: 6
  - id: chromosome_files
    type:
      type: array
      items: File
    doc: Genome sequence FASTA files (chromosome_file_1 [chromosome_file_2 ...]).
    inputBinding:
      position: 7
outputs:
  - id: transcripts_fasta
    type: File
    doc: Extracted transcript sequences (ref_name.transcripts.fa).
    outputBinding:
      glob: $(inputs.ref_name).transcripts.fa
  - id: reference_files
    type:
      type: array
      items: File
    doc: All files written for the reference (ref_name.*).
    outputBinding:
      glob: $(inputs.ref_name).*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
