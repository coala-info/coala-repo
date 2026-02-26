cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pstools
  - hic_mapping_haplo
label: pstools_hic_mapping_haplo
doc: "Map Hi-C reads to predicted haplotypes\n\nTool homepage: https://github.com/shilpagarg/pstools"
inputs:
  - id: pred_haplotypes
    type: File
    doc: Predicted haplotypes fasta file
    inputBinding:
      position: 1
  - id: hic_r1_fastq
    type: File
    doc: Hi-C R1 fastq file (gzipped)
    inputBinding:
      position: 2
  - id: hic_r2_fastq
    type: File
    doc: Hi-C R2 fastq file (gzipped)
    inputBinding:
      position: 3
  - id: bloom_filter_size
    type:
      - 'null'
      - int
    doc: set Bloom filter size to 2**INT bits; 0 to disable
    default: 0
    inputBinding:
      position: 104
      prefix: -b
  - id: chunk_size
    type:
      - 'null'
      - string
    doc: chunk size
    default: 100m
    inputBinding:
      position: 104
      prefix: -K
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size
    default: 31
    inputBinding:
      position: 104
      prefix: -k
  - id: threads
    type:
      - 'null'
      - int
    doc: number of worker threads
    default: 32
    inputBinding:
      position: 104
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: save mapping relationship to FILE
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pstools:0.2a3--h077b44d_4
