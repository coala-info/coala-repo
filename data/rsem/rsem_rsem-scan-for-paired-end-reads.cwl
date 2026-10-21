cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-scan-for-paired-end-reads
label: rsem_rsem-scan-for-paired-end-reads
doc: "Scan a SAM/BAM/CRAM file and write a BAM file that holds only the
  paired-end reads (used by rsem-calculate-expression before it sorts
  alignments by read name).\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: number_of_threads
    type: int
    doc: Number of threads to use.
    inputBinding:
      position: 1
  - id: input_alignments
    type: File
    doc: The input alignment file in SAM, BAM or CRAM format.
    inputBinding:
      position: 2
  - id: output_bam
    type: string
    doc: The name of the output BAM file.
    inputBinding:
      position: 3
outputs:
  - id: paired_end_bam
    type: File
    outputBinding:
      glob: $(inputs.output_bam)
    doc: The output BAM file.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
