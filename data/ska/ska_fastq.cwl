cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - fastq
label: ska_fastq
doc: "Create a split kmer file from fastq file(s)\n\nTool homepage: https://github.com/simonrharris/SKA"
inputs:
  - id: fastq_files
    type:
      type: array
      items: File
    doc: 'Input fastq file(s) of one sample'
    inputBinding:
      position: 1
  - id: allele_frequencies
    type:
      - 'null'
      - boolean
    doc: 'Print allele frequencies of split kmers to file [Default = false]'
    inputBinding:
      position: 101
      prefix: -a
  - id: coverage_cutoff
    type:
      - 'null'
      - int
    doc: 'Coverage cutoff. Kmers with coverage below this value will be discarded. [Default = 4]'
    inputBinding:
      position: 101
      prefix: -c
  - id: file_coverage_cutoff
    type:
      - 'null'
      - int
    doc: 'File coverage cutoff. Kmers with coverage below this value in any of the fastq files will be discarded. [Default = 2]'
    inputBinding:
      position: 101
      prefix: -C
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'Split kmer size. The kmer used for searches will be twice this length, with the variable base in the middle. Must be divisible by 3. [Default = 15]'
    inputBinding:
      position: 101
      prefix: -k
  - id: min_allele_frequency
    type:
      - 'null'
      - float
    doc: 'Minimum allowable minor allele frequency. Kmer alleles below this frequency will be discarded. [Default = 0.2]'
    inputBinding:
      position: 101
      prefix: -m
  - id: quality_cutoff
    type:
      - 'null'
      - int
    doc: 'Quality filter for fastq files. No kmers will be created from sequence including quality scores below this cutoff. [Default = 20]'
    inputBinding:
      position: 101
      prefix: -q
  - id: output_prefix
    type:
      - 'null'
      - string
    default: fastq
    doc: 'Output file prefix. [Default = fastq]'
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: skf_files
    type:
      type: array
      items: File
    doc: 'Split kmer file (and allele frequency file with -a)'
    outputBinding:
      glob: '$(inputs.output_prefix)*'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska:1.0--h077b44d_7
