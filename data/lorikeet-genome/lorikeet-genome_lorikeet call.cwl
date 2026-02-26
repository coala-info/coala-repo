cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lorikeet
  - call
label: lorikeet-genome_lorikeet call
doc: "Perform read mapping and variant calling using local reassembly of active regions\n\
  \nTool homepage: https://github.com/rhysnewell/Lorikeet"
inputs:
  - id: bam_file_cache_directory
    type:
      - 'null'
      - Directory
    doc: Directory to cache BAM files
    inputBinding:
      position: 101
      prefix: --bam-file-cache-directory
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input BAM files
    inputBinding:
      position: 101
      prefix: --bam-files
  - id: coupled
    type:
      - 'null'
      - type: array
        items: File
    doc: Map paired reads
    inputBinding:
      position: 101
      prefix: --coupled
  - id: genome_fasta_directory
    type:
      - 'null'
      - Directory
    doc: Directory containing genome FASTA files
    inputBinding:
      position: 101
      prefix: --genome-fasta-directory
  - id: kmer_sizes
    type:
      - 'null'
      - type: array
        items: int
    doc: K-mer sizes for local reassembly
    default:
      - 17
      - 25
    inputBinding:
      position: 101
      prefix: --kmer-sizes
  - id: longread_bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input long-read BAM files
    inputBinding:
      position: 101
      prefix: --longread-bam-files
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference genome
    inputBinding:
      position: 101
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 10
    inputBinding:
      position: 101
      prefix: --threads
  - id: x
    type:
      - 'null'
      - string
    doc: File extension for genome FASTA files
    inputBinding:
      position: 101
      prefix: -x
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory for results
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorikeet-genome:0.8.2--h8e1a5b0_0
