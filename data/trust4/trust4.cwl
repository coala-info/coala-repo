cwlVersion: v1.2
class: CommandLineTool
baseCommand: trust4
label: trust4
doc: "TRUST4: a tool for TCR/BC repertoire reconstruction from high-throughput sequencing
  data.\n\nTool homepage: https://github.com/liulab-dfci/TRUST4"
inputs:
  - id: bam_file
    type:
      - 'null'
      - File
    doc: path to BAM alignment file
    inputBinding:
      position: 101
      prefix: -b
  - id: barcode_file
    type:
      - 'null'
      - File
    doc: the path to the barcode file
    inputBinding:
      position: 101
      prefix: --barcode
  - id: cgene_end
    type:
      - 'null'
      - int
    doc: skipping reads mapped to C gene coordinate greater than INT
    inputBinding:
      position: 101
      prefix: --cgeneEnd
  - id: contig_min_cov
    type:
      - 'null'
      - int
    doc: ignore contigs that have bases covered by fewer than INT reads
    inputBinding:
      position: 101
      prefix: --contigMinCov
  - id: fasta_file
    type: File
    doc: fasta file containing the receptor genome sequence
    inputBinding:
      position: 101
      prefix: -f
  - id: keep_no_barcode
    type:
      - 'null'
      - boolean
    doc: assemble the reads with missing barcodes.
    inputBinding:
      position: 101
      prefix: --keepNoBarcode
  - id: kmer_count_file
    type:
      - 'null'
      - File
    doc: the path to the kmer count file
    inputBinding:
      position: 101
      prefix: -c
  - id: min_hit_len
    type:
      - 'null'
      - int
    doc: the minimal hit length for a valid overlap
    inputBinding:
      position: 101
      prefix: --minHitLen
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix of the output file
    inputBinding:
      position: 101
      prefix: -o
  - id: paired_end_read_file1
    type:
      - 'null'
      - File
    doc: path to paried-end read files
    inputBinding:
      position: 101
      prefix: '-1'
  - id: paired_end_read_file2
    type:
      - 'null'
      - File
    doc: path to paried-end read files
    inputBinding:
      position: 101
      prefix: '-2'
  - id: single_end_read_file
    type:
      - 'null'
      - File
    doc: path to single-end read file
    inputBinding:
      position: 101
      prefix: -u
  - id: skip_mate_extension
    type:
      - 'null'
      - boolean
    doc: skip the step of extension assemblies with mate-pair information
    inputBinding:
      position: 101
      prefix: --skipMateExtension
  - id: starting_kmer_size
    type:
      - 'null'
      - int
    doc: the starting k-mer size for indexing contigs
    inputBinding:
      position: 101
      prefix: -k
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: trim_level
    type:
      - 'null'
      - int
    doc: '0: no trim; 1: trim low quality; 2: trim unmatched'
    inputBinding:
      position: 101
      prefix: --trimLevel
  - id: umi_file
    type:
      - 'null'
      - File
    doc: the path to the UMI file
    inputBinding:
      position: 101
      prefix: --UMI
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
stdout: trust4.out
