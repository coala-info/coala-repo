cwlVersion: v1.2
class: CommandLineTool
baseCommand: runBESST
label: besst_runBESST
doc: "BESST (Scaffolding Tool) - Scaffolding of genomic assemblies using different
  types of libraries (e.g., paired-end, mate-pairs).\n\nTool homepage: https://github.com/ksahlin/BESST"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: fasta_file
    type: File
    doc: Fasta file containing contigs.
    inputBinding:
      position: 101
      prefix: -c
  - id: bam_files
    type:
      type: array
      items: File
    secondaryFiles:
      - pattern: .bai
        required: false
    doc: Path(s) to bamfile(s) (indexed BAM files of reads mapped to the contigs).
    inputBinding:
      position: 101
      prefix: -f
  - id: orientation
    type:
      type: array
      items: string
    doc: Mapped orientation for each library given with -f option. Valid input is
      either fr (forward reverse orientation) or rf (reverse forward orientation).
    inputBinding:
      position: 101
      prefix: -orientation
  - id: read_length
    type:
      - 'null'
      - type: array
        items: int
    doc: Mean read length of libraries.
    inputBinding:
      position: 101
      prefix: -r
  - id: mean_insert_size
    type:
      - 'null'
      - type: array
        items: int
    doc: Mean insert size of libraries.
    inputBinding:
      position: 101
      prefix: -m
  - id: std_dev
    type:
      - 'null'
      - type: array
        items: int
    doc: Estimated standard deviation of libraries.
    inputBinding:
      position: 101
      prefix: -s
  - id: cov_cutoff
    type:
      - 'null'
      - float
    doc: User specified coverage cutoff. (Manually filter out contigs with coverage
      over this value)
    inputBinding:
      position: 101
      prefix: -z
  - id: lower_cov_cutoff
    type:
      - 'null'
      - float
    doc: User specified coverage cutoff. (Manually filter out contigs with coverage
      under this value)
    inputBinding:
      position: 101
      prefix: -z_min
  - id: hapl_ratio
    type:
      - 'null'
      - float
    doc: Maximum length ratio for merging of haplotypic regions.
    inputBinding:
      position: 101
      prefix: -a
  - id: hapl_threshold
    type:
      - 'null'
      - float
    doc: Number of standard deviations over mean/2 of coverage to allow for clasification
      of haplotype.
    inputBinding:
      position: 101
      prefix: -b
  - id: haplotype_detection
    type:
      - 'null'
      - boolean
    doc: Haplotype detection function, default = off
    inputBinding:
      position: 101
      prefix: -g
  - id: threshold
    type:
      - 'null'
      - type: array
        items: int
    doc: Threshold value filter out reads that are mapped too far apart given insert
      size.
    inputBinding:
      position: 101
      prefix: -T
  - id: edge_support
    type:
      - 'null'
      - type: array
        items: int
    doc: Threshold value for the least nr of links that is needed to create an edge.
    inputBinding:
      position: 101
      prefix: -e
  - id: min_size
    type:
      - 'null'
      - type: array
        items: int
    doc: Contig size threshold for the library (contigs below this size are discarded
      from the 'large contigs' scaffolding, but included in pathfinding).
    inputBinding:
      position: 101
      prefix: -k
  - id: filter_contigs
    type:
      - 'null'
      - int
    doc: Contigs under this size are discarded from all scaffolding (including pathfinding).
    inputBinding:
      position: 101
      prefix: -filter_contigs
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Lowest mapping quality allowed in order to use the read pair.
    inputBinding:
      position: 101
      prefix: --min_mapq
  - id: iter
    type:
      - 'null'
      - int
    doc: The number of iterations performed in breadth first search for placing smaller
      contigs.
    inputBinding:
      position: 101
      prefix: --iter
  - id: score_cutoff
    type:
      - 'null'
      - float
    doc: Only store paths with score larger than score_cutoff.
    inputBinding:
      position: 101
      prefix: --score_cutoff
  - id: max_extensions
    type:
      - 'null'
      - int
    doc: Maximum number of (large) scaffolds to search for paths extensions with.
    inputBinding:
      position: 101
      prefix: --max_extensions
  - id: kmer
    type:
      - 'null'
      - int
    doc: k-mer size used in de brujin graph for obtaining contigs in assembly, default
      50
    inputBinding:
      position: 101
      prefix: -K
  - id: mmer
    type:
      - 'null'
      - int
    doc: m-mer usted for creating connection graph. Should be set lower than k-mer
      size
    inputBinding:
      position: 101
      prefix: -M
  - id: no_duplicate_detection
    type:
      - 'null'
      - boolean
    doc: Deactivate sequencing duplicates detection
    inputBinding:
      position: 101
      prefix: -d
  - id: no_pathfinder
    type:
      - 'null'
      - boolean
    doc: Deactivate pathfinder module for including smaller contigs.
    inputBinding:
      position: 101
      prefix: -y
  - id: parallel_pathfinder
    type:
      - 'null'
      - boolean
    doc: Parallellize work load of path finder module in case of multiple processors
      available.
    inputBinding:
      position: 101
      prefix: -q
  - id: no_score
    type:
      - 'null'
      - boolean
    doc: Statistical scoring is not performed. BESST instead searches for paths between
      contigs.
    inputBinding:
      position: 101
      prefix: --no_score
  - id: plots
    type:
      - 'null'
      - boolean
    doc: Plot coverage, histograms of scores e.t.c.
    inputBinding:
      position: 101
      prefix: -plots
  - id: separate_repeats
    type:
      - 'null'
      - boolean
    doc: Separates contigs classified as repeats by BESST into a file 'repeats.fa'.
    inputBinding:
      position: 101
      prefix: --separate_repeats
  - id: no_ilp
    type:
      - 'null'
      - boolean
    doc: Use the old BESST algorithm (benchmarking only, gives poor results).
    inputBinding:
      position: 101
      prefix: --NO_ILP
  - id: faster_ilp
    type:
      - 'null'
      - boolean
    doc: Faster but worse performing heuristic solution to solving ILPs.
    inputBinding:
      position: 101
      prefix: --FASTER_ILP
  - id: print_scores
    type:
      - 'null'
      - boolean
    doc: Print BESST scores on edges in the Scaffolding graph.
    inputBinding:
      position: 101
      prefix: --print_scores
  - id: dfs_traversal
    type:
      - 'null'
      - boolean
    doc: Depth first search with DP in the contig graph (default).
    inputBinding:
      position: 101
      prefix: --dfs_traversal
  - id: bfs_traversal
    type:
      - 'null'
      - boolean
    doc: Choose a breadth first search in the contig graph.
    inputBinding:
      position: 101
      prefix: --bfs_traversal
  - id: max_contig_overlap
    type:
      - 'null'
      - int
    doc: Maximum identical overlap to search for between adjacent contigs, default
      is 200.
    inputBinding:
      position: 101
      prefix: -max_contig_overlap
  - id: output_directory_path
    type: string
    default: besst_out
    doc: Path to output directory. BESST will create a folder named 'BESST_output'
      in the directory given by the path.
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_directory
    type: Directory
    doc: The BESST_output folder (scaffolds, statistics, AGP files).
    outputBinding:
      glob: $(inputs.output_directory_path)/BESST_output
  - id: scaffolds
    type:
      type: array
      items: File
    doc: Scaffold FASTA files of each pass (pass*/Scaffolds_pass*.fa)
    outputBinding:
      glob: $(inputs.output_directory_path)/BESST_output/pass*/Scaffolds_pass*.fa
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/besst:2.2.8--py27_0
