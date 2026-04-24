cwlVersion: v1.2
class: CommandLineTool
baseCommand: isonclust2
label: isonclust2
doc: "isONclust2 is a tool for clustering long reads (ONT/PacBio) into groups representing
  the same transcript/gene.\n\nTool homepage: https://github.com/nanoporetech/isonclust2"
inputs:
  - id: ccs
    type:
      - 'null'
      - boolean
    doc: Use preset parameters for PacBio CCS (HiFi) reads
    inputBinding:
      position: 101
      prefix: --ccs
  - id: fastq
    type: File
    doc: Input FASTQ file containing long reads
    inputBinding:
      position: 101
      prefix: --fastq
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size for clustering
    inputBinding:
      position: 101
      prefix: --k
  - id: mode
    type:
      - 'null'
      - string
    doc: Clustering mode (e.g., 'default' or 'fast')
    inputBinding:
      position: 101
      prefix: --mode
  - id: ont
    type:
      - 'null'
      - boolean
    doc: Use preset parameters for Oxford Nanopore reads
    inputBinding:
      position: 101
      prefix: --ont
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --t
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size for minimizers
    inputBinding:
      position: 101
      prefix: --w
outputs:
  - id: outfolder
    type: Directory
    doc: Output directory for clustering results
    outputBinding:
      glob: $(inputs.outfolder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isonclust2:2.3--hc9558a2_0
