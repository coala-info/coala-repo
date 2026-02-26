cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lorikeet
  - genotype
label: lorikeet-genome_lorikeet genotype
doc: "Report strain-level genotypes and abundances based on variant read mappings\n\
  \nTool homepage: https://github.com/rhysnewell/Lorikeet"
inputs:
  - id: bam_file_cache_directory
    type:
      - 'null'
      - Directory
    doc: Directory to cache BAM files for faster access
    inputBinding:
      position: 101
      prefix: --bam-file-cache-directory
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Sorted BAM files containing read mappings
    inputBinding:
      position: 101
      prefix: --bam-files
  - id: coupled
    type:
      - 'null'
      - type: array
        items: File
    doc: Paired-end FASTQ files
    inputBinding:
      position: 101
      prefix: --coupled
  - id: genome_fasta_directory
    type:
      - 'null'
      - Directory
    doc: Directory containing reference genome FASTA files
    inputBinding:
      position: 101
      prefix: --genome-fasta-directory
  - id: kmer_sizes
    type:
      - 'null'
      - type: array
        items: int
    doc: K-mer sizes to use for genotype calling
    inputBinding:
      position: 101
      prefix: --kmer-sizes
  - id: longread_bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Sorted long-read BAM files containing read mappings
    inputBinding:
      position: 101
      prefix: --longread-bam-files
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference genome FASTA file
    inputBinding:
      position: 101
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 10
    inputBinding:
      position: 101
      prefix: --threads
  - id: x
    type:
      - 'null'
      - string
    doc: File extension for genome FASTA files in the directory
    inputBinding:
      position: 101
      prefix: -x
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to save output files
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorikeet-genome:0.8.2--h8e1a5b0_0
