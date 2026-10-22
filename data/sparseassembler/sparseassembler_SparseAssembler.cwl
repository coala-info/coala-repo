cwlVersion: v1.2
class: CommandLineTool
baseCommand: SparseAssembler
label: sparseassembler_SparseAssembler
doc: "SparseAssembler: a de Bruijn graph genome assembler that keeps a sparse set of k-mers. Options are given as 'name value' pairs without dashes.\n\nTool homepage: https://github.com/yechengxi/SparseAssembler"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: f
    doc: "single end reads. Multiple inputs are imported with one f option each."
    inputBinding:
      position: 101
  - id: inward_pair_end1
    type:
      - 'null'
      - File
    doc: "inward paired-end reads (first file; also accepted as p1)"
    inputBinding:
      position: 101
      prefix: i1
  - id: inward_pair_end2
    type:
      - 'null'
      - File
    doc: "inward paired-end reads (second file; also accepted as p2)"
    inputBinding:
      position: 101
      prefix: i2
  - id: outward_pair_end1
    type:
      - 'null'
      - File
    doc: "outward paired-end reads (first file; also accepted as l1)"
    inputBinding:
      position: 101
      prefix: o1
  - id: outward_pair_end2
    type:
      - 'null'
      - File
    doc: "outward paired-end reads (second file; also accepted as l2)"
    inputBinding:
      position: 101
      prefix: o2
  - id: inward_mate_pair_end1
    type:
      - 'null'
      - File
    doc: "inward mate paired reads (large insert sizes >10k, for shorter libraries omit _mp), first file"
    inputBinding:
      position: 101
      prefix: i1_mp
  - id: inward_mate_pair_end2
    type:
      - 'null'
      - File
    doc: "inward mate paired reads (large insert sizes >10k), second file"
    inputBinding:
      position: 101
      prefix: i2_mp
  - id: outward_mate_pair_end1
    type:
      - 'null'
      - File
    doc: "outward paired-end reads (large insert sizes >10k), first file"
    inputBinding:
      position: 101
      prefix: o1_mp
  - id: outward_mate_pair_end2
    type:
      - 'null'
      - File
    doc: "outward paired-end reads (large insert sizes >10k), second file"
    inputBinding:
      position: 101
      prefix: o2_mp
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: "kmer size, support 15~127."
    inputBinding:
      position: 101
      prefix: k
  - id: gap_value
    type:
      - 'null'
      - int
    doc: "number of skipped intermediate k-mers, support 1-25."
    inputBinding:
      position: 101
      prefix: g
  - id: genome_size
    type:
      - 'null'
      - int
    doc: "genome size estimation in bp (used for memory pre-allocation), suggest a large value if possible.(e.g. ~ 2x genome size)"
    inputBinding:
      position: 101
      prefix: GS
  - id: load_skg
    type:
      - 'null'
      - int
    doc: "load a saved k-mer graph."
    inputBinding:
      position: 101
      prefix: LD
  - id: build_contigs
    type:
      - 'null'
      - int
    doc: "1: build contigs. 0: don't build."
    inputBinding:
      position: 101
      prefix: BC
  - id: output_kmer_table
    type:
      - 'null'
      - int
    doc: "1 if you want to output the kmer table."
    inputBinding:
      position: 101
      prefix: KmerTable
  - id: node_cov_threshold
    type:
      - 'null'
      - int
    doc: "coverage threshold for spurious k-mers, support 0-16. (default 1)"
    inputBinding:
      position: 101
      prefix: NodeCovTh
  - id: edge_cov_threshold
    type:
      - 'null'
      - int
    doc: "coverage threshold for spurious links, support 0-16. (default 0)"
    inputBinding:
      position: 101
      prefix: EdgeCovTh
  - id: path_cov_threshold
    type:
      - 'null'
      - int
    doc: "coverage threshold for spurious paths in the breadth-first search, support 0-100."
    inputBinding:
      position: 101
      prefix: PathCovTh
  - id: trim_length
    type:
      - 'null'
      - int
    doc: "trim long sequences to this length."
    inputBinding:
      position: 101
      prefix: TrimLen
  - id: trim_reads_with_n
    type:
      - 'null'
      - int
    doc: "throw away reads with more than this number of Ns."
    inputBinding:
      position: 101
      prefix: TrimN
  - id: trim_quality
    type:
      - 'null'
      - int
    doc: "trim off tails with quality scores lower than this."
    inputBinding:
      position: 101
      prefix: TrimQual
  - id: quality_base
    type:
      - 'null'
      - string
    doc: "lowest quality score value (in ASCII value) in the current fastq scoring system, default: '!'."
    inputBinding:
      position: 101
      prefix: QualBase
  - id: denoise
    type:
      - 'null'
      - int
    doc: "use 1 to call the error correction module. (default 0)"
    inputBinding:
      position: 101
      prefix: Denoise
  - id: hybrid_mode
    type:
      - 'null'
      - int
    doc: "hybrid mode. 0 (Default): reads will be trimmed at the ends to ensure denoising accuracy (MUST set 0 for the last round). 1: reads will not be trimmed at the ends."
    inputBinding:
      position: 101
      prefix: H
  - id: error_coverage_threshold
    type:
      - 'null'
      - int
    doc: "coverage threshold for an error. A k-mer with coverage < this value will be checked. Setting 0 will allow the program to choose a value based on the coverage histogram."
    inputBinding:
      position: 101
      prefix: CovTh
  - id: correct_kmer_coverage_threshold
    type:
      - 'null'
      - int
    doc: "coverage threshold for a correct k-mer candidate. A k-mer with coverage >= this value will be considered a candidate for correction. Setting 0 will allow the program to choose a value based on the coverage histogram."
    inputBinding:
      position: 101
      prefix: CorrTh
  - id: expected_coverage
    type:
      - 'null'
      - int
    doc: "expected average k-mer coverage in a unique contig. Used for scaffolding."
    inputBinding:
      position: 101
      prefix: ExpCov
  - id: scaffold
    type:
      - 'null'
      - int
    doc: "1: scaffolding with paired reads. 0: single end assembly."
    inputBinding:
      position: 101
      prefix: Scaffold
  - id: link_coverage_threshold
    type:
      - 'null'
      - int
    doc: "coverage threshold for spurious paired-end links, support 0-100. (default 5)"
    inputBinding:
      position: 101
      prefix: LinkCovTh
  - id: iterative_scaffolding
    type:
      - 'null'
      - int
    doc: "1: iterative scaffolding using the already built scaffolds (/super contigs). 0: one round scaffolding."
    inputBinding:
      position: 101
      prefix: Iter_Scaffold
  - id: insert_size
    type:
      - 'null'
      - int
    doc: "estimated insert size of the current pair."
    inputBinding:
      position: 101
      prefix: InsertSize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written to the working directory (contigs, scaffolds, k-mer graph and log)
    outputBinding:
      glob: '*'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sparseassembler:20160205--h9948957_11
stdout: sparseassembler_SparseAssembler.out
