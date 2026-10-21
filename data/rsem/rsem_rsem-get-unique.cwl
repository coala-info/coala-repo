cwlVersion: v1.2
class: CommandLineTool
baseCommand: [rsem-get-unique]
label: rsem_rsem-get-unique
doc: "Extract the uniquely aligned reads from an unsorted transcript BAM file.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: number_of_threads
    type: int
    doc: Number of threads to use.
    inputBinding:
      position: 1
  - id: unsorted_transcript_bam_input
    type: File
    doc: Unsorted transcript BAM file (sample_name.transcript.bam).
    inputBinding:
      position: 2
  - id: bam_output
    type: string
    doc: Output BAM file name.
    inputBinding:
      position: 3
outputs:
  - id: unique_bam
    type: File
    doc: BAM file with the uniquely aligned reads.
    outputBinding:
      glob: $(inputs.bam_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
