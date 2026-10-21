cwlVersion: v1.2
class: CommandLineTool
baseCommand: [rsem-tbam2gbam]
label: rsem_rsem-tbam2gbam
doc: "Convert a transcript-coordinate BAM file into a genome-coordinate BAM file.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: reference_name
    type: string
    doc: The name of the RSEM reference (made by rsem-prepare-reference).
    inputBinding:
      position: 1
  - id: reference_files
    type:
      type: array
      items: File
    doc: Reference files written by rsem-prepare-reference (all files starting with the reference name). They are staged in the working directory so that reference_name resolves.
  - id: unsorted_transcript_bam_input
    type: File
    doc: Unsorted transcript BAM file (sample_name.transcript.bam).
    inputBinding:
      position: 2
  - id: genome_bam_output
    type: string
    doc: Output genome BAM file name.
    inputBinding:
      position: 3
  - id: number_of_threads
    type: ['null', int]
    doc: Number of threads to use.
    inputBinding:
      position: 4
      prefix: -p
outputs:
  - id: genome_bam
    type: File
    doc: Genome-coordinate BAM file.
    outputBinding:
      glob: $(inputs.genome_bam_output)
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.reference_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
