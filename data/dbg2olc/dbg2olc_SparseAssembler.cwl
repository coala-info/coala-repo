cwlVersion: v1.2
class: CommandLineTool
baseCommand: SparseAssembler
label: dbg2olc_SparseAssembler
doc: "SparseAssembler: sparse de Bruijn graph assembler for short reads (used to make the contigs for DBG2OLC).\n\nTool homepage: https://github.com/yechengxi/DBG2OLC"
inputs:
  - id: build_contigs
    type:
      - 'null'
      - int
    doc: "1: build contigs.0: don't build."
    inputBinding:
      position: 101
      prefix: BC
  - id: correct_kmer_threshold
    type:
      - 'null'
      - int
    doc: coverage threshold for a correct k-mer candidate. A k-mer with coverage
      >= this value will be considered a candidate for correction. Setting 0 
      will allow the program to choose a value based on the coverage histogram.
    inputBinding:
      position: 101
      prefix: CorrTh
  - id: denoise
    type:
      - 'null'
      - int
    doc: use 1 to call the error correction module. (default 0)
    inputBinding:
      position: 101
      prefix: Denoise
  - id: edge_coverage_threshold
    type:
      - 'null'
      - int
    doc: coverage threshold for spurious links, support 0-16.
    inputBinding:
      position: 101
      prefix: EdgeCovTh
  - id: error_coverage_threshold
    type:
      - 'null'
      - int
    doc: coverage threshold for an error. A k-mer with coverage < this value 
      will be checked. Setting 0 will allow the program to choose a value based 
      on the coverage histogram.
    inputBinding:
      position: 101
      prefix: CovTh
  - id: expected_coverage
    type:
      - 'null'
      - int
    doc: expected average k-mer coverage in a unique contig. Used for 
      scaffolding.
    inputBinding:
      position: 101
      prefix: ExpCov
  - id: gap_value
    type:
      - 'null'
      - int
    doc: number of skipped intermediate k-mers, support 1-25.
    inputBinding:
      position: 101
      prefix: g
  - id: genome_size
    type:
      - 'null'
      - int
    doc: genome size estimation in bp (used for memory pre-allocation), suggest 
      a large value if possible.(e.g. ~ 2x genome size)
    inputBinding:
      position: 101
      prefix: GS
  - id: hybrid_mode
    type:
      - 'null'
      - int
    doc: 'hybrid mode. 0 (Default): reads will be trimmed at the ends to ensure denoising
      accuracy (*MUST* set 0 for the last round). 1: reads will not be trimmed at
      the ends;'
    inputBinding:
      position: 101
      prefix: H
  - id: input_file1
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: f
    doc: single end reads. Multiple inputs shall be independently imported with 
      this parameter.
    inputBinding:
      position: 101
  - id: insert_size
    type:
      - 'null'
      - int
    doc: estimated insert size of the current pair.
    inputBinding:
      position: 101
      prefix: InsertSize
  - id: inward_mate_pair1
    type:
      - 'null'
      - File
    doc: inward mate paired reads (large insert sizes >10k, for shorter 
      libraries omit "_mp").
    inputBinding:
      position: 101
      prefix: i1_mp
  - id: inward_mate_pair2
    type:
      - 'null'
      - File
    doc: inward mate paired reads (large insert sizes >10k, for shorter 
      libraries omit "_mp").
    inputBinding:
      position: 101
      prefix: i2_mp
  - id: inward_pair_end1
    type:
      - 'null'
      - File
    doc: inward paired-end reads.
    inputBinding:
      position: 101
      prefix: i1
  - id: inward_pair_end2
    type:
      - 'null'
      - File
    doc: inward paired-end reads.
    inputBinding:
      position: 101
      prefix: i2
  - id: iterative_scaffolding
    type:
      - 'null'
      - int
    doc: '1: iterative scaffolding using the already built scaffolds (/super contigs).
      0: one round scaffolding.'
    inputBinding:
      position: 101
      prefix: Iter_Scaffold
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: kmer size, support 15~127.
    inputBinding:
      position: 101
      prefix: k
  - id: link_coverage_threshold
    type:
      - 'null'
      - int
    doc: coverage threshold for spurious paired-end links, support 0-100.
    inputBinding:
      position: 101
      prefix: LinkCovTh
  - id: load_skg
    type:
      - 'null'
      - int
    doc: load a saved k-mer graph (1) or build a new one (0).
    inputBinding:
      position: 101
      prefix: LD
  - id: node_coverage_threshold
    type:
      - 'null'
      - int
    doc: coverage threshold for spurious k-mers, support 0-16.
    inputBinding:
      position: 101
      prefix: NodeCovTh
  - id: output_kmer_table
    type:
      - 'null'
      - int
    doc: 1 if you want to output the kmer table.
    inputBinding:
      position: 101
      prefix: KmerTable
  - id: outward_mate_pair1
    type:
      - 'null'
      - File
    doc: outward paired-end reads (large insert sizes >10k, for shorter 
      libraries omit "_mp").
    inputBinding:
      position: 101
      prefix: o1_mp
  - id: outward_mate_pair2
    type:
      - 'null'
      - File
    doc: outward paired-end reads (large insert sizes >10k, for shorter 
      libraries omit "_mp").
    inputBinding:
      position: 101
      prefix: o2_mp
  - id: outward_pair_end1
    type:
      - 'null'
      - File
    doc: outward paired-end reads.
    inputBinding:
      position: 101
      prefix: o1
  - id: outward_pair_end2
    type:
      - 'null'
      - File
    doc: outward paired-end reads.
    inputBinding:
      position: 101
      prefix: o2
  - id: path_coverage_threshold
    type:
      - 'null'
      - int
    doc: coverage threshold for spurious paths in the breadth-first search, 
      support 0-100.
    inputBinding:
      position: 101
      prefix: PathCovTh
  - id: quality_base
    type:
      - 'null'
      - string
    doc: "lowest quality score value (in ASCII value) in the current fastq scoring
      system, default: '!'."
    inputBinding:
      position: 101
      prefix: QualBase
  - id: scaffold
    type:
      - 'null'
      - int
    doc: '1: scaffolding with paired reads. 0: single end assembly.'
    inputBinding:
      position: 101
      prefix: Scaffold
  - id: trim_length
    type:
      - 'null'
      - int
    doc: trim long sequences to this length.
    inputBinding:
      position: 101
      prefix: TrimLen
  - id: trim_quality
    type:
      - 'null'
      - int
    doc: trim off tails with quality scores lower than this.
    inputBinding:
      position: 101
      prefix: TrimQual
  - id: trim_reads_with_n
    type:
      - 'null'
      - int
    doc: throw away reads with more than this number of Ns.
    inputBinding:
      position: 101
      prefix: TrimN
outputs:
  - id: contigs
    type: File
    doc: Assembled contigs (Contigs.txt, FASTA)
    outputBinding:
      glob: Contigs.txt
  - id: scaffolds
    type:
      - 'null'
      - File
    doc: Scaffolds (SuperContigs.txt), written when scaffolding is on
    outputBinding:
      glob: SuperContigs.txt
  - id: assembly_log
    type:
      - 'null'
      - File
    doc: Assembly log
    outputBinding:
      glob: Assembly_Log.txt
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbg2olc:20200723--h077b44d_4
stdout: dbg2olc_SparseAssembler.out
