cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metamaps
  - mapDirectly
label: metamaps_mapdirectly
doc: "Map long reads directly against a MetaMaps reference database FASTA (first step of simultaneous metagenomic classification and mapping).\n\nTool homepage: https://github.com/DiltheyLab/MetaMaps"
inputs:
  - id: reference
    type: File
    doc: an input reference file (fasta/fastq)[.gz], usually DB.fa of a MetaMaps database
    inputBinding:
      position: 1
      prefix: --reference
  - id: query
    type: File
    doc: an input query file (fasta/fastq)[.gz]
    inputBinding:
      position: 2
      prefix: --query
  - id: kmer
    type: ['null', int]
    doc: kmer size <= 16 [default 16 (DNA)]
    inputBinding:
      position: 3
      prefix: --kmer
  - id: pval
    type: ['null', string]
    doc: p-value cutoff, used to determine window/sketch sizes [default e-03]
    inputBinding:
      position: 4
      prefix: --pval
  - id: maxmemory
    type: ['null', int]
    doc: 'maximum memory, in GB [default : not active]'
    inputBinding:
      position: 5
      prefix: --maxmemory
  - id: window
    type: ['null', int]
    doc: 'window size [default : computed using pvalue cutoff]. P-value is not considered if a window value is provided. Lower window size implies denser sketch'
    inputBinding:
      position: 6
      prefix: --window
  - id: min_read_len
    type: ['null', int]
    doc: 'minimum read length to map [default : 1000]'
    inputBinding:
      position: 7
      prefix: --minReadLen
  - id: perc_identity
    type: ['null', int]
    doc: 'threshold for identity [default : 80]'
    inputBinding:
      position: 8
      prefix: --perc_identity
  - id: threads
    type: ['null', int]
    doc: 'count of threads for parallel execution [default : 1]'
    inputBinding:
      position: 9
      prefix: --threads
  - id: all
    type: ['null', boolean]
    doc: report all the mapping locations for a read, default is to consider few best ones
    inputBinding:
      position: 10
      prefix: --all
  - id: output
    type: string
    doc: output file
    inputBinding:
      position: 11
      prefix: --output
outputs:
  - id: mappings
    type: File
    doc: Mapping file, with its .meta, .meta.unmappedReadsLengths and .parameters files (input for metamaps classify)
    outputBinding:
      glob: $(inputs.output)
    secondaryFiles:
      - .meta
      - .meta.unmappedReadsLengths
      - .parameters
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamaps:0.1.98102e9--h21ec9f0_2
