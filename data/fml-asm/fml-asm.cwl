cwlVersion: v1.2
class: CommandLineTool
baseCommand: fml-asm
label: fml-asm
doc: "fml-asm is a de novo assembler for long reads.\n\nTool homepage: https://github.com/HurriKane/skyfactory-2.4-faults"
inputs:
  - id: input_fq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
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
  - id: kmer_read_count_thresholds
    type:
      - 'null'
      - string
    doc: range of k-mer & read count thresholds for ec and graph cleaning
    inputBinding:
      position: 102
      prefix: -c
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
    dockerPull: biocontainers/fml-asm:v0.1-5-deb_cv1
stdout: fml-asm.out
