cwlVersion: v1.2
class: CommandLineTool
baseCommand: delineate
label: ngs-smap_smap delineate
doc: "Create a bed file with clusters of Stacks using a set of bam files containing
  aligned GBS reads. The Stack Mapping Anchor Points \"SMAP\" within clustersof Stacks
  are listed 0-based. The position of the clusters of Stacks themselves are 0-based
  according to BED format.\n\nTool homepage: https://gitlab.com/truttink/smap"
inputs:
  - id: alignments_dir
    type: Directory
    doc: Path to the directory containing BAM and BAI alignment files. All BAM 
      files should be in the same directory [current directory].
    inputBinding:
      position: 1
  - id: completeness
    type:
      - 'null'
      - float
    doc: Completeness, minimal percentage of samples that contains an 
      overlapping StackCluster for a given MergedCluster. May be used to select 
      loci with enough read mapping data across the sample set for downstream 
      analysis [0].
    default: 0
    inputBinding:
      position: 102
      prefix: --completeness
  - id: mapping_orientation
    type: string
    doc: Specify strandedness of read mapping should be considered for 
      haplotyping. When specifying "ignore", reads are collected per locus 
      independent of the strand that the reads are mapped on (i.e. ignoring 
      their mapping orientation). "stranded" means that only those reads will be
      considered that map on the same strand as indicated per locus in the BED 
      file. For more information on which option to choose, please consult the 
      manual.
    inputBinding:
      position: 102
      prefix: --mapping_orientation
  - id: max_cluster_depth
    type:
      - 'null'
      - int
    doc: Maximal total number of reads per StackCluster per sample. The total 
      number of reads in a StackCluster is calculated after filtering out the 
      Stacks using --min_stack_depth_fraction [inf].
    default: inf
    inputBinding:
      position: 102
      prefix: --max_cluster_depth
  - id: max_cluster_length
    type:
      - 'null'
      - int
    doc: Maximum cluster length. Can be used to remove artifacts that arise from
      read merging [inf].
    default: inf
    inputBinding:
      position: 102
      prefix: --max_cluster_length
  - id: max_smap_number
    type:
      - 'null'
      - int
    doc: Maximum number of SMAPs per MergedCluster across the sample set. Can be
      used to remove loci with excessive MergedCluster complexity before 
      downstream analysis [inf].
    default: inf
    inputBinding:
      position: 102
      prefix: --max_smap_number
  - id: max_stack_depth
    type:
      - 'null'
      - int
    doc: Maximum total number of reads per Stack per sample [inf].
    default: inf
    inputBinding:
      position: 102
      prefix: --max_stack_depth
  - id: max_stack_number
    type:
      - 'null'
      - int
    doc: Maximum number of Stacks per StackCluster, may be 2 in diploid 
      individuals, 4 for tetraploid individuals, 20 for Pool-Seq [inf].
    default: inf
    inputBinding:
      position: 102
      prefix: --max_stack_number
  - id: min_cluster_depth
    type:
      - 'null'
      - int
    doc: Minimal total number of reads per StackCluster per sample. The total 
      number of reads in a StackCluster is calculated after filtering out the 
      Stacks using --min_stack_depth_fraction. A good reference value is 10 for 
      individual diploid samples, 20 for tetraploids, and 30 for Pool-Seq [0].
    default: 0
    inputBinding:
      position: 102
      prefix: --min_cluster_depth
  - id: min_cluster_length
    type:
      - 'null'
      - int
    doc: Minimum cluster length. Can be used to remove artifacts that arise from
      read merging [0].
    default: 0
    inputBinding:
      position: 102
      prefix: --min_cluster_length
  - id: min_stack_depth
    type:
      - 'null'
      - int
    doc: Minimum number of reads per Stack per sample. A good reference value 
      could be 3 [0].
    default: 0
    inputBinding:
      position: 102
      prefix: --min_stack_depth
  - id: min_stack_depth_fraction
    type:
      - 'null'
      - float
    doc: Threshold (%) for minimum relative Stack depth per StackCluster. 
      Removes spuriously mapped reads from StackClusters, and controls for noise
      in the number of SMAPs per locus. The StackCluster total read depth and 
      number of SMAPs is recalculated based on the retained Stacks per sample 
      [0].
    default: 0
    inputBinding:
      position: 102
      prefix: --min_stack_depth_fraction
  - id: minimum_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum bam mapping quality to retain reads for analysis [30].
    default: 30
    inputBinding:
      position: 102
      prefix: --minimum_mapping_quality
  - id: name
    type:
      - 'null'
      - string
    doc: Label to describe the sample set, will be added to the last column in 
      the final stack BED file and is used by SMAP-compare [Set1].
    default: Set1
    inputBinding:
      position: 102
      prefix: --name
  - id: plot
    type:
      - 'null'
      - string
    doc: Select which plots are to be generated. Choosing "nothing" disables 
      plot generation. Passing "summary" only generates graphs with information 
      for all samples while "all" will also enable generate per-sample plots 
      [default "summary"].
    default: summary
    inputBinding:
      position: 102
      prefix: --plot
  - id: plot_type
    type:
      - 'null'
      - string
    doc: Choose the file type for the plots [png].
    default: png
    inputBinding:
      position: 102
      prefix: --plot_type
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of parallel processes [1].
    default: 1
    inputBinding:
      position: 102
      prefix: --processes
  - id: read_type
    type:
      - 'null'
      - string
    doc: 'Deprecated option: please use --mapping_orientation. "--read_type merged"
      should be replaced by "--mapping_orientation ignore", and "--read_type merged"
      by "--mapping_orientation stranded".'
    inputBinding:
      position: 102
      prefix: -read_type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
stdout: ngs-smap_smap delineate.out
