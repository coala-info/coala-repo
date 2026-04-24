cwlVersion: v1.2
class: CommandLineTool
baseCommand: ryuto
label: ryuto
doc: "Reconstruct Your Transcripts: A tool for reconstructing transcripts from RNA-seq
  data.\n\nTool homepage: https://github.com/studla/RYUTO/"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file containing aligned RNA-seq reads
    inputBinding:
      position: 1
  - id: genome
    type:
      - 'null'
      - File
    doc: Reference genome sequence in FASTA format
    inputBinding:
      position: 102
      prefix: --genome
  - id: library_type
    type:
      - 'null'
      - string
    doc: Library type (fr-unstranded, fr-firststrand, or fr-secondstrand)
    inputBinding:
      position: 102
      prefix: --library-type
  - id: max_isize
    type:
      - 'null'
      - int
    doc: Maximum intron size
    inputBinding:
      position: 102
      prefix: --max-isize
  - id: min_junction_count
    type:
      - 'null'
      - int
    doc: Minimum number of reads supporting a junction
    inputBinding:
      position: 102
      prefix: --min-junction-count
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality for a read to be considered
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_prefix
    type: File
    doc: Prefix for output files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ryuto:1.6.3--hb03c83d_2
