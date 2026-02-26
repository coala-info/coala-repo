cwlVersion: v1.2
class: CommandLineTool
baseCommand: komb
label: komb
doc: "Taxonomy-oblivious characterization of metagenome dynamics\n\nTool homepage:
  https://gitlab.com/treangenlab/komb"
inputs:
  - id: alignment
    type:
      - 'null'
      - boolean
    doc: Keep alignment files
    inputBinding:
      position: 101
      prefix: --alignment
  - id: bifrost
    type:
      - 'null'
      - boolean
    doc: Run bifrost instead of abyss
    inputBinding:
      position: 101
      prefix: --bifrost
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Reads provided are fasta files
    inputBinding:
      position: 101
      prefix: --fasta
  - id: ignore_rest
    type:
      - 'null'
      - boolean
    doc: Ignores the rest of the labeled arguments following this flag.
    inputBinding:
      position: 101
      prefix: --ignore_rest
  - id: kmer
    type:
      - 'null'
      - int
    doc: Kmer size for Abyss, Bifrost uses 31
    default: 31
    inputBinding:
      position: 101
      prefix: --kmer
  - id: numhits
    type:
      - 'null'
      - int
    doc: Bowtie2 maximum number of hits
    default: 1000
    inputBinding:
      position: 101
      prefix: --numhits
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Output directory
    default: output_yyyymmdd_hhmmss
    inputBinding:
      position: 101
      prefix: --output
  - id: readlen
    type:
      - 'null'
      - int
    doc: Read Length (can be average)
    default: 100
    inputBinding:
      position: 101
      prefix: --readlen
  - id: reads
    type: string
    doc: Paired-read file separated by ','
    default: read1.fq,read2.fq
    inputBinding:
      position: 101
      prefix: --reads
  - id: spades
    type:
      - 'null'
      - boolean
    doc: Runs spades and uses GFA graph instead of bifrost + bowtie2
    inputBinding:
      position: 101
      prefix: --spades
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of Threads
    default: Max
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/komb:1.0--py310h590eda1_5
stdout: komb.out
