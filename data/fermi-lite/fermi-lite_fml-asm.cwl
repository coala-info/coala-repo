cwlVersion: v1.2
class: CommandLineTool
baseCommand: fml-asm
label: fermi-lite_fml-asm
doc: "Assembly of short reads using the Fermi-lite algorithm.\n\nTool homepage: https://github.com/lh3/fermi-lite"
inputs:
  - id: input_fq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: count_thresholds
    type:
      - 'null'
      - string
    doc: range of k-mer & read count thresholds for ec and graph cleaning
    inputBinding:
      position: 102
      prefix: -c
  - id: discard_heterozygotes
    type:
      - 'null'
      - boolean
    doc: discard heterozygotes (apply this to assemble bacterial genomes)
    inputBinding:
      position: 102
      prefix: -A
  - id: error_correction_kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length for error correction (0 for auto; -1 to disable)
    inputBinding:
      position: 102
      prefix: -e
  - id: min_overlap_length
    type:
      - 'null'
      - int
    doc: min overlap length during initial assembly
    inputBinding:
      position: 102
      prefix: -l
  - id: overlap_drop_threshold
    type:
      - 'null'
      - float
    doc: drop an overlap if its length is below maxOvlpLen*FLOAT
    inputBinding:
      position: 102
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads (don't use multi-threading for small data sets)
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi-lite:0.1--h577a1d6_8
stdout: fermi-lite_fml-asm.out
