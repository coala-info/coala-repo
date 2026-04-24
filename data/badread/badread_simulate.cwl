cwlVersion: v1.2
class: CommandLineTool
baseCommand: badread_simulate
label: badread_simulate
doc: "Generate fake long reads\n\nTool homepage: https://github.com/rrwick/Badread"
inputs:
  - id: chimeras
    type:
      - 'null'
      - string
    doc: 'Percentage at which separate fragments join together (default: 1)'
    inputBinding:
      position: 101
      prefix: --chimeras
  - id: end_adapter
    type:
      - 'null'
      - string
    doc: 'Adapter parameters for read ends (rate and amount, default: 50,20)'
    inputBinding:
      position: 101
      prefix: --end_adapter
  - id: end_adapter_seq
    type:
      - 'null'
      - string
    doc: 'Adapter sequence for read ends (default: GCAATACGTAACTGAACGAAGT)'
    inputBinding:
      position: 101
      prefix: --end_adapter_seq
  - id: error_model
    type:
      - 'null'
      - string
    doc: 'Can be "nanopore2018", "nanopore2020", "nanopore2023", "pacbio2016", "pacbio2021",
      "random" or a model filename (default: nanopore2023)'
    inputBinding:
      position: 101
      prefix: --error_model
  - id: glitches
    type:
      - 'null'
      - string
    doc: 'Read glitch parameters (rate, size and skip, default: 10000,25,25)'
    inputBinding:
      position: 101
      prefix: --glitches
  - id: identity
    type:
      - 'null'
      - string
    doc: 'Sequencing identity distribution (mean,max,stdev for beta distribution or
      mean,stdev for normal qscore distribution, default: 95,99,2.5)'
    inputBinding:
      position: 101
      prefix: --identity
  - id: junk_reads
    type:
      - 'null'
      - string
    doc: 'This percentage of reads will be low-complexity junk (default: 1)'
    inputBinding:
      position: 101
      prefix: --junk_reads
  - id: length
    type:
      - 'null'
      - string
    doc: 'Fragment length distribution (mean and stdev, default: 15000,13000)'
    inputBinding:
      position: 101
      prefix: --length
  - id: qscore_model
    type:
      - 'null'
      - string
    doc: 'Can be "nanopore2018", "nanopore2020", "nanopore2023", "pacbio2016", "pacbio2021",
      "random", "ideal" or a model filename (default: nanopore2023)'
    inputBinding:
      position: 101
      prefix: --qscore_model
  - id: quantity
    type: string
    doc: Either an absolute value (e.g. 250M) or a relative depth (e.g. 25x)
    inputBinding:
      position: 101
      prefix: --quantity
  - id: random_reads
    type:
      - 'null'
      - string
    doc: 'This percentage of reads will be random sequence (default: 1)'
    inputBinding:
      position: 101
      prefix: --random_reads
  - id: reference
    type: File
    doc: Reference FASTA file (can be gzipped)
    inputBinding:
      position: 101
      prefix: --reference
  - id: seed
    type:
      - 'null'
      - string
    doc: 'Random number generator seed for deterministic output (default: different
      output each time)'
    inputBinding:
      position: 101
      prefix: --seed
  - id: small_plasmid_bias
    type:
      - 'null'
      - boolean
    doc: 'If set, then small circular plasmids are lost when the fragment length is
      too high (default: small plasmids are included regardless of fragment length)'
    inputBinding:
      position: 101
      prefix: --small_plasmid_bias
  - id: start_adapter
    type:
      - 'null'
      - string
    doc: 'Adapter parameters for read starts (rate and amount, default: 90,60)'
    inputBinding:
      position: 101
      prefix: --start_adapter
  - id: start_adapter_seq
    type:
      - 'null'
      - string
    doc: 'Adapter sequence for read starts (default: AATGTACTTCGTTCAGTTACGTATTGCT)'
    inputBinding:
      position: 101
      prefix: --start_adapter_seq
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/badread:0.4.1--pyhdfd78af_0
stdout: badread_simulate.out
