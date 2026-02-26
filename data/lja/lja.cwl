cwlVersion: v1.2
class: CommandLineTool
baseCommand: lja
label: lja
doc: "genome assembler for PacBio HiFi reads based on de Bruijn graph.\n\nTool homepage:
  https://github.com/AntonBankevich/LJA"
inputs:
  - id: diploid
    type:
      - 'null'
      - boolean
    doc: Use this option for diploid genomes. By default LJA assumes that the 
      genome is haploid or inbred.
    inputBinding:
      position: 101
      prefix: --diploid
  - id: k_final_error_correction
    type:
      - 'null'
      - int
    doc: Value of k used for final error correction and initialization of 
      multiDBG.
    inputBinding:
      position: 101
      prefix: -K
  - id: k_initial_error_correction
    type:
      - 'null'
      - int
    doc: Value of k used for initial error correction.
    inputBinding:
      position: 101
      prefix: -k
  - id: output_dir
    type: Directory
    doc: Name of output folder. Resulting graph will be stored there.
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: reads_file
    type:
      type: array
      items: File
    doc: Name of file that contains reads in fasta or fastq format. This option 
      can be used any number of times in the same command line. In this case 
      reads from all specified files will be used as an input.
    inputBinding:
      position: 101
      prefix: --reads
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    default: 16
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lja:0.2--h5b5514e_2
stdout: lja.out
