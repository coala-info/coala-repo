cwlVersion: v1.2
class: CommandLineTool
baseCommand: cloci
label: cloci
doc: "The Co-occurrence Locus and Orthologous Cluster Identifier (CLOCI) identifies groups of homologous loci and enriches gene cluster families from them.\n\nTool homepage: https://github.com/xonq/cloci"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: "Tab delimitted file with columns: genus, species, strain, assembly path, gff path"
    inputBinding:
      position: 101
      prefix: --input
  - id: genome_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Assembly (FNA) and GFF3 files named in the --input table; staged in the working directory so relative names resolve"
  - id: database
    type:
      - 'null'
      - File
    doc: "MycotoolsDB. DEFAULT: primaryDB"
    inputBinding:
      position: 101
      prefix: --database
  - id: pfam
    type:
      - 'null'
      - File
    doc: "Pfam-A.hmm for Pfam annotations"
    inputBinding:
      position: 101
      prefix: --pfam
  - id: interpro
    type:
      - 'null'
      - string
    doc: "interproscan.sh for IPR annotations"
    inputBinding:
      position: 101
      prefix: --interpro
  - id: focal_genes
    type:
      - 'null'
      - File
    doc: "File of genes for neighborhood extraction of microsynteny tree"
    inputBinding:
      position: 101
      prefix: --focal_genes
  - id: constraint
    type:
      - 'null'
      - File
    doc: "Constrain microsynteny topology to species tree w/ome code tips"
    inputBinding:
      position: 101
      prefix: --constraint
  - id: root
    type:
      - 'null'
      - string
    doc: "Ome(s) to root upon - MRCA of multiple; DEFAULT: midpoint"
    inputBinding:
      position: 101
      prefix: --root
  - id: tree
    type:
      - 'null'
      - File
    doc: "Precomputed microsynteny tree path"
    inputBinding:
      position: 101
      prefix: --tree
  - id: orthofinder
    type:
      - 'null'
      - Directory
    doc: "Precomputed OrthoFinder output directory"
    inputBinding:
      position: 101
      prefix: --orthofinder
  - id: homology_groups
    type:
      - 'null'
      - File
    doc: "Precomputed homology group results file"
    inputBinding:
      position: 101
      prefix: --homology_groups
  - id: linclust
    type:
      - 'null'
      - boolean
    doc: "Less sensitive Homology inference via linclust; DEFAULT: mmseqs cluster"
    inputBinding:
      position: 101
      prefix: --linclust
  - id: window
    type:
      - 'null'
      - int
    doc: "Max genes +/- for each locus window. DEFAULT: 2 (5 gene window)"
    inputBinding:
      position: 101
      prefix: --window
  - id: maximum_dist
    type:
      - 'null'
      - boolean
    doc: "Calculated maximum microsynteny distance; DEFAULT: total microsynteny distance"
    inputBinding:
      position: 101
      prefix: --maximum_dist
  - id: unique_sp
    type:
      - 'null'
      - boolean
    doc: "Only consider one genome for replicate species in microsynteny distance calculations"
    inputBinding:
      position: 101
      prefix: --unique_sp
  - id: null_rank
    type:
      - 'null'
      - string
    doc: "Taxonomic rank for local null models ['kingdom', 'phylum', 'subphylum', 'class', 'order', 'family', 'genus', 'species']; DEFAULT: species"
    inputBinding:
      position: 101
      prefix: --null_rank
  - id: null_partitions
    type:
      - 'null'
      - File
    doc: "Tab-delimited file with omes for each null sample group on separate lines"
    inputBinding:
      position: 101
      prefix: --null_partitions
  - id: null_sample
    type:
      - 'null'
      - int
    doc: "Samples for null distributions; DEFAULT: 10,000"
    inputBinding:
      position: 101
      prefix: --null_sample
  - id: aligner
    type:
      - 'null'
      - string
    doc: "Alignment algorithm: ['mmseqs', 'diamond', 'blastp']; DEFAULT: diamond"
    inputBinding:
      position: 101
      prefix: --aligner
  - id: sensitive_align
    type:
      - 'null'
      - string
    doc: "[diamond ultra-sensitive] or [mmseqs -s 7.5 --num_iterations 3]"
    inputBinding:
      position: 101
      prefix: --sensitive_align
  - id: similarity
    type:
      - 'null'
      - string
    doc: "HLG similarity coefficient: [J]accard, [O]verlap, [S]orensen; DEFAULT: Sorensen"
    inputBinding:
      position: 101
      prefix: --similarity
  - id: minimum_gene_id
    type:
      - 'null'
      - float
    doc: "Percent [30 < value < 100] ID minimum between gene for loci; DEFAULT: 45"
    inputBinding:
      position: 101
      prefix: --minimum_gene_id
  - id: minimum_loc_id
    type:
      - 'null'
      - float
    doc: "Percent [0 < value < 100] ID minimum between loci for HLG DEFAULT: 30"
    inputBinding:
      position: 101
      prefix: --minimum_loc_id
  - id: min_topology_sim
    type:
      - 'null'
      - float
    doc: "Percent [0 < value < 100] topology similarity (Jaccard) minimum for singleton merging AND merging loci prior to HLG aggregation; DEFAULT: 25"
    inputBinding:
      position: 101
      prefix: --min_topology_sim
  - id: inflation_rnd1
    type:
      - 'null'
      - float
    doc: "MCL inflation 1: affects domain/merging granularity; DEFAULT: 1.1"
    inputBinding:
      position: 101
      prefix: --inflation_rnd1
  - id: inflation_rnd2
    type:
      - 'null'
      - float
    doc: "MCL inflation 2: affects HLG/GCF granularity; DEFAULT: 1.3"
    inputBinding:
      position: 101
      prefix: --inflation_rnd2
  - id: tune
    type:
      - 'null'
      - File
    doc: "Tune inflation to subset data of clusters represented in a tab-delimited file"
    inputBinding:
      position: 101
      prefix: --tune
  - id: hgp_percentile
    type:
      - 'null'
      - float
    doc: "Null percentile [0 < value < 100] of HG pair distances; DEFAULT: 20"
    inputBinding:
      position: 101
      prefix: --hgp_percentile
  - id: hgx_percentile
    type:
      - 'null'
      - float
    doc: "Null percentile [0 < value < 100] of HGx microsynteny distances. DEFAULT: 61"
    inputBinding:
      position: 101
      prefix: --hgx_percentile
  - id: id_percent
    type:
      - 'null'
      - float
    doc: "Percent [0 < value < 100] identity minimum for gene cluster family"
    inputBinding:
      position: 101
      prefix: --id_percent
  - id: pos_percent
    type:
      - 'null'
      - float
    doc: "Percent [0 < value < 100] positive minimum for gene cluster family"
    inputBinding:
      position: 101
      prefix: --pos_percent
  - id: csb_threshold
    type:
      - 'null'
      - float
    doc: "Threshold [0 < value < 1] conservative substitution bias minimum for gene cluster family"
    inputBinding:
      position: 101
      prefix: --csb_threshold
  - id: pds_threshold
    type:
      - 'null'
      - float
    doc: "Threshold [0 < value < 1] of gene cluster family phylogenetic distribution sparsity"
    inputBinding:
      position: 101
      prefix: --pds_threshold
  - id: gcl_threshold
    type:
      - 'null'
      - float
    doc: "Threshold [0 < value < 1] of gene cluster committment"
    inputBinding:
      position: 101
      prefix: --gcl_threshold
  - id: md_threshold
    type:
      - 'null'
      - float
    doc: "Threshold [0 < value < 1] of log-normalized GCF MDs"
    inputBinding:
      position: 101
      prefix: --md_threshold
  - id: n50
    type:
      - 'null'
      - int
    doc: "Minimum assembly N50"
    inputBinding:
      position: 101
      prefix: --n50
  - id: stop
    type:
      - 'null'
      - boolean
    doc: "Export HG alignment commands for parallelization and stop"
    inputBinding:
      position: 101
      prefix: --stop
  - id: skip
    type:
      - 'null'
      - boolean
    doc: "Ignore missing HG alignments as assumed failures"
    inputBinding:
      position: 101
      prefix: --skip
  - id: fallback
    type:
      - 'null'
      - boolean
    doc: "Fallback to diamond from failed alignments"
    inputBinding:
      position: 101
      prefix: --fallback
  - id: apds
    type:
      - 'null'
      - boolean
    doc: "Calculate aPDS, a reconciliation-free approximation of horizontal gene flow"
    inputBinding:
      position: 101
      prefix: --apds
  - id: new
    type:
      - 'null'
      - boolean
    doc: "Rerun with new parameters and overwrite incompatible data"
    inputBinding:
      position: 101
      prefix: --new
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Force rerun over bypassing"
    inputBinding:
      position: 101
      prefix: --force
  - id: compress
    type:
      - 'null'
      - boolean
    doc: "Compress run; SEMI-FUNCTIONAL"
    inputBinding:
      position: 101
      prefix: --compress
  - id: cpus
    type:
      - 'null'
      - int
    doc: "DEFAULT: all"
    inputBinding:
      position: 101
      prefix: --cpus
  - id: hg_dir
    type:
      - 'null'
      - Directory
    doc: "HG faa dir, format <HG>.faa"
    inputBinding:
      position: 101
      prefix: --hg_dir
  - id: hgx_dir
    type:
      - 'null'
      - Directory
    doc: "HGx alignment DB and results dir, format <HG>.out and <HG>.dmnd/<HG>.mmseqs"
    inputBinding:
      position: 101
      prefix: --hgx_dir
  - id: output_dir
    type: string
    doc: "Output/resume directory; DEFAULT: cloci_YYYYmmdd"
    default: cloci_output
    inputBinding:
      position: 102
      prefix: --output_dir
outputs:
  - id: output_directory
    type: Directory
    doc: CLOCI output/resume directory
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.genome_files ? inputs.genome_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cloci:0.4.0--pyhdfd78af_0
