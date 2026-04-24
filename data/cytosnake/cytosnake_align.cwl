cwlVersion: v1.2
class: CommandLineTool
baseCommand: cytosnake_align
label: cytosnake_align
doc: "Aligns sequencing reads to a reference genome.\n\nTool homepage: https://github.com/WayScience/CytoSnake"
inputs:
  - id: input_reads
    type: File
    doc: Path to the input sequencing reads file (e.g., FASTQ).
    inputBinding:
      position: 1
  - id: reference_genome
    type: File
    doc: Path to the reference genome file (e.g., FASTA).
    inputBinding:
      position: 2
  - id: aligner
    type:
      - 'null'
      - string
    doc: The alignment tool to use (e.g., bwa, bowtie2).
    inputBinding:
      position: 103
      prefix: --aligner
  - id: keep_intermediate_files
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files generated during the alignment process.
    inputBinding:
      position: 103
      prefix: --keep-intermediate-files
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the logging level (e.g., DEBUG, INFO, WARNING, ERROR).
    inputBinding:
      position: 103
      prefix: --log-level
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads to use for alignment.
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: output_alignment
    type:
      - 'null'
      - File
    doc: Path to save the alignment results (e.g., BAM, SAM).
    outputBinding:
      glob: $(inputs.output_alignment)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cytosnake:0.0.2--pyhdfd78af_0
