cwlVersion: v1.2
class: CommandLineTool
baseCommand: isONclust3
label: isonclust3_isONclust3
doc: "Rust implementation of a novel de novo clustering algorithm. isONclust3 is a
  tool for clustering either PacBio Iso-Seq reads, or Oxford Nanopore reads into clusters,
  where each cluster represents all reads that came from a gene family. Output is
  a tsv file with each read assigned to a cluster-ID and a folder 'fastq' containing
  one fastq file per cluster generated. Detailed information is available in the isONclust3
  paper.\n\nTool homepage: https://github.com/aljpetri/isONclust3"
inputs:
  - id: fastq
    type: File
    doc: Path to consensus fastq file(s)
    inputBinding:
      position: 101
      prefix: --fastq
  - id: gff
    type:
      - 'null'
      - File
    doc: Path to gff3 file (optional parameter), requires a reference added by 
      calling --init-cl <REFERENCE.fasta>
    inputBinding:
      position: 101
      prefix: --gff
  - id: init_cl
    type:
      - 'null'
      - File
    doc: Path to initial clusters (stored in fasta format), which is required 
      when --gff is set
    inputBinding:
      position: 101
      prefix: --init-cl
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Kmer length
    inputBinding:
      position: 101
      prefix: -k
  - id: min_reads_for_cluster
    type:
      - 'null'
      - int
    doc: Minimum number of reads for cluster
    default: 1
    inputBinding:
      position: 101
      prefix: --n
  - id: min_shared_minis
    type:
      - 'null'
      - float
    doc: Minimum overlap threshold for reads to be clustered together 
      (Experimental parameter)
    inputBinding:
      position: 101
      prefix: --min-shared-minis
  - id: min_syncmer_position
    type:
      - 'null'
      - int
    doc: minimum syncmer position
    inputBinding:
      position: 101
      prefix: -t
  - id: mode
    type: string
    doc: Run mode of isONclust (pacbio or ont
    inputBinding:
      position: 101
      prefix: --mode
  - id: no_fastq
    type:
      - 'null'
      - boolean
    doc: Do not write the fastq_files (no write_fastq in isONclust1)
    inputBinding:
      position: 101
      prefix: --no-fastq
  - id: noncanonical
    type:
      - 'null'
      - boolean
    doc: we do not want to use canonical seeds
    inputBinding:
      position: 101
      prefix: --noncanonical
  - id: post_cluster
    type:
      - 'null'
      - boolean
    doc: Run the post clustering step during the analysis (small improvement for
      results but much higher runtime)
    inputBinding:
      position: 101
      prefix: --post-cluster
  - id: quality_threshold
    type:
      - 'null'
      - float
    doc: 'quality threshold used for the data (standard: 0.9)'
    default: 0.9
    inputBinding:
      position: 101
      prefix: --quality-threshold
  - id: seeding
    type:
      - 'null'
      - string
    doc: seeding approach we choose
    inputBinding:
      position: 101
      prefix: --seeding
  - id: syncmer_length
    type:
      - 'null'
      - int
    doc: syncmer length
    inputBinding:
      position: 101
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print additional information
    inputBinding:
      position: 101
      prefix: --verbose
  - id: window_size
    type:
      - 'null'
      - int
    doc: window size
    inputBinding:
      position: 101
      prefix: -w
outputs:
  - id: outfolder
    type: Directory
    doc: Path to outfolder
    outputBinding:
      glob: $(inputs.outfolder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isonclust3:0.3.0--h4349ce8_0
