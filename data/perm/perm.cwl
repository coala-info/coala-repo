cwlVersion: v1.2
class: CommandLineTool
baseCommand: perm
label: perm
doc: "PerM (Periodic Seed Mapping) is a fast mapping program for short reads (e.g.,
  Illumina, SOLiD) to a reference genome, using periodic seeds to improve sensitivity.\n
  \nTool homepage: https://github.com/spatie/laravel-permission"
inputs:
  - id: read_file
    type: File
    doc: The file containing the reads to be mapped (e.g., .fastq, .fasta, .csfasta).
    inputBinding:
      position: 1
  - id: reference_file
    type: File
    doc: The reference genome file or the index file prefix.
    inputBinding:
      position: 2
  - id: load_index
    type:
      - 'null'
      - File
    doc: Load the reference index from the specified file.
    inputBinding:
      position: 103
      prefix: -l
  - id: mismatches
    type:
      - 'null'
      - int
    doc: Number of mismatches allowed in the alignment.
    inputBinding:
      position: 103
      prefix: -v
  - id: only_best
    type:
      - 'null'
      - boolean
    doc: Only output the best alignments for each read.
    inputBinding:
      position: 103
      prefix: -m
  - id: save_index
    type:
      - 'null'
      - File
    doc: Save the reference index to the specified file.
    inputBinding:
      position: 103
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel mapping.
    inputBinding:
      position: 103
      prefix: -T
  - id: unmapped_reads
    type:
      - 'null'
      - File
    doc: File to write unmapped reads to.
    inputBinding:
      position: 103
      prefix: -u
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify the output file name for alignments.
    outputBinding:
      glob: $(inputs.output_file)
  - id: bam_output
    type:
      - 'null'
      - File
    doc: Output alignments in BAM format.
    outputBinding:
      glob: $(inputs.bam_output)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/perm:v0.4.0-4-deb_cv1
