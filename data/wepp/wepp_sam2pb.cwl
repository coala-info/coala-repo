cwlVersion: v1.2
class: CommandLineTool
baseCommand: wepp_sam2pb
label: wepp_sam2pb
doc: "Applies QC before running WEPP\n\nTool homepage: https://github.com/TurakhiaLab/WEPP"
inputs:
  - id: clade_idx
    type:
      - 'null'
      - int
    doc: Index used for inferring lineage proportions from haplotypes.
    inputBinding:
      position: 101
      prefix: --clade-idx
  - id: dataset
    type:
      - 'null'
      - Directory
    doc: Data folder containing reads.
    inputBinding:
      position: 101
      prefix: --dataset
  - id: file_prefix
    type:
      - 'null'
      - string
    doc: Prefix for intermediate files.
    inputBinding:
      position: 101
      prefix: --file-prefix
  - id: input_mat
    type:
      - 'null'
      - File
    doc: Input mutation-annotated tree.
    inputBinding:
      position: 101
      prefix: --input-mat
  - id: max_reads
    type:
      - 'null'
      - int
    doc: Maximum number of reads.
    inputBinding:
      position: 101
      prefix: --max-reads
  - id: min_af
    type:
      - 'null'
      - float
    doc: Allele Frequency threshold for masking erroneous alleles.
    inputBinding:
      position: 101
      prefix: --min-af
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Depth threshold for masking low coverage sites.
    inputBinding:
      position: 101
      prefix: --min-depth
  - id: min_phred
    type:
      - 'null'
      - int
    doc: Phred score threshold for masking low quality alleles.
    inputBinding:
      position: 101
      prefix: --min-phred
  - id: min_prop
    type:
      - 'null'
      - float
    doc: Minimum haplotype abundance.
    inputBinding:
      position: 101
      prefix: --min-prop
  - id: ref_fasta
    type:
      - 'null'
      - File
    doc: Reference sequence.
    inputBinding:
      position: 101
      prefix: --ref-fasta
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use when possible [DEFAULT uses all available 
      cores, 20 detected on this machine]
    inputBinding:
      position: 101
      prefix: --threads
  - id: working_directory
    type:
      - 'null'
      - Directory
    doc: WEPP's working directory.
    inputBinding:
      position: 101
      prefix: --working-directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wepp:0.1.5.2--h9f2696a_0
stdout: wepp_sam2pb.out
