cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ntsmVCF
label: ntsm_ntsmVCF
doc: "Converts a multi vcf file to a set of counts files. Alternatively, you may also
  create a matrix to be used for PCA.\n\nTool homepage: https://github.com/JustinChu/ntsm"
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to run.
    inputBinding:
      position: 1
      prefix: --threads
  - id: allow_shared_kmers
    type:
      - 'null'
      - boolean
    doc: Allow shared k-mers between sites to be counted.
    inputBinding:
      position: 2
      prefix: --dupes
  - id: snp_fasta
    type: File
    doc: Interleaved fasta of SNP sites to k-merize.
    inputBinding:
      position: 3
      prefix: --snp
  - id: pca_prefix
    type:
      - 'null'
      - string
    doc: With a multi vcf, generate rotation and centering files with this
      prefix.
    inputBinding:
      position: 4
      prefix: --pca
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size used.
    inputBinding:
      position: 5
      prefix: --kmer
  - id: multiply
    type:
      - 'null'
      - int
    doc: Value to multiply base counts.
    inputBinding:
      position: 6
      prefix: --multi
  - id: window
    type:
      - 'null'
      - int
    doc: Window size used.
    inputBinding:
      position: 7
      prefix: --window
  - id: reference
    type: File
    doc: Reference fasta.
    inputBinding:
      position: 8
      prefix: --ref
  - id: vcf
    type: File
    doc: Multi-sample VCF file (optionally gzipped).
    inputBinding:
      position: 9
outputs:
  - id: counts_files
    type: File[]
    doc: Counts files written per sample (and PCA files with pca_prefix)
    outputBinding:
      glob:
        - '*.counts*'
        - '*counts.txt'
        - '*.tsv'
        - '*.txt'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntsm:1.2.1--h077b44d_1
stdout: ntsm_ntsmVCF.out
