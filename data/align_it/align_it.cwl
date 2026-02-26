cwlVersion: v1.2
class: CommandLineTool
baseCommand: align_it
label: align_it
doc: "Align reads to a reference genome.\n\nTool homepage: http://silicos-it.be.s3-website-eu-west-1.amazonaws.com/software/align-it/1.0.4/align-it.html"
inputs:
  - id: reads
    type: File
    doc: Input FASTQ file containing reads.
    inputBinding:
      position: 1
  - id: reference
    type: File
    doc: Reference genome FASTA file.
    inputBinding:
      position: 2
  - id: aligner_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional options to pass to the underlying aligner (e.g., BWA, 
      Bowtie2).
    inputBinding:
      position: 103
      prefix: --aligner-options
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for alignment.
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: output_bam
    type:
      - 'null'
      - File
    doc: Output BAM file path.
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alignlib-lite:0.3--py312h9c9b0c2_9
