#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: BinSpreader

doc: BinSPreader is a tool to refine metagenome-assembled genomes (MAGs) obtained from existing tools. BinSPreader exploits the assembly graph topology and other connectivity information, such as paired-end and Hi-C reads, to refine the existing binning, correct binning errors, propagate binning from longer contigs to shorter contigs and infer contigs belonging to multiple bins.

requirements:
  InlineJavascriptRequirement: {}
  NetworkAccess:
    networkAccess: true

hints:
  SoftwareRequirement:
    packages:
      binspreader :
        version: ["3.16.0.dev"]
        specs: ["https://anaconda.org/bioconda/binspreader", "doi.org/10.1016/j.isci.2022.104770"]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/binspreader:3.16.0.dev--h95f258a_0

baseCommand: [ "bin-refine" ]


inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used

  assembly_graph:
    type: File
    doc: Input assembly graph from assembler outputs in GFA format
    label: assembly graph
    inputBinding:
      position: 0
      
  contig2bin:
    type: File
    doc: Contig-to-bin mapping tsv file
    label: Contig-to-bin mapping file
    inputBinding:
      position: 1

  paths:
    type: File?
    doc: provide contigs paths from file separately from GFA. We recommend using scaffolds for metagenome binning and further analysis. If there is a specific demand to use contigs.fasta, their paths though the assembly graph should be additionally specified.
    label: contigs paths 
    inputBinding:
      prefix: --paths
      position: 3

  dataset:
    type: File?
    doc: Dataset in YAML format describing Hi-C and paired-end reads
    label: Dataset in YAML format
    inputBinding:
      prefix: --dataset
      position: 4

  library_index:
    type: int?
    doc: Library index (0-based, default 0). Only the library specified by this index will be used.
    label: Library index
    inputBinding:
      prefix: -l
      position: 5

  threads:
    type: int?
    doc: number of threads to use (default 1/2 of available threads)
    label: Number of threads
    inputBinding:
      prefix: -t
      position: 6

  convergence:
    type: float?
    doc: convergence relative tolerance threshold (default 1e-5)
    label: Convergence relative tolerance threshold
    inputBinding:
      prefix: -e
      position: 7

  iterations:
    type: int?
    doc: maximum number of iterations (default 5000)
    label: Maximum number of iterations
    inputBinding:
      prefix: -n
      position: 8
    
  multiple_bin_assignment:
    type: boolean?
    doc: allow multiple bin assignment (default false)
    label: Allow multiple bin assignment
    inputBinding:
      prefix: -m
      position: 9
  
  binning_assignment_strategy:
    type: string?
    doc: simple maximum or maximum likelihood binning assignment strategy (default -Smax) or -Smle
    label: Binning assignment strategy
    inputBinding:
      position: 10

  propagation_correction_mode:
    type: string?
    doc: Select propagation or correction mode (default Rcorr) or Rprop
    label: Propagation or correction mode
    inputBinding:
      position: 11

  cami_binning_format:
    type: boolean?
    doc: use CAMI bioboxes binning format
    label: Use CAMI bioboxes binning format
    inputBinding:
      prefix: --cami
      position: 12

  emit_zero_bin:
    type: boolean?
    doc: emit zero bin for unbinned sequences
    label: Emit zero bin for unbinned sequences
    inputBinding:
      prefix: --zero-bin
      position: 13

  tall_table:
    type: boolean?
    doc: use tall table for multiple binning result
    label: Use tall table for multiple binning result
    inputBinding:
      prefix: --tall-multi
      position: 14

  estimate_pairwise_bin_distance:
    type: boolean?
    doc: estimate pairwise bin distance (could be slow on large graphs!)
    label: Estimate pairwise bin distance
    inputBinding:
      prefix: --bin-dist
      position: 15

  labels_correction_regularization_parameter:
    type: float?
    doc: labels correction regularization parameter for labeled data (default 0.6)
    label: Labels correction regularization parameter
    inputBinding:
      prefix: -la
      position: 16

  sparse_propagation:
    type: boolean?
    doc: Gradually reduce regularization parameter from binned to unbinned edges. Recommended for sparse binnings with low assembly fraction.
    label: Sparse propagation
    inputBinding:
      prefix: --sparse-propagation
      position: 17

  no_unbinned_bin:
    type: boolean?
    doc: Do not create a special bin for unbinned contigs. More agressive strategy.
    label: Do not create a special bin for unbinned contigs
    inputBinding:
      prefix: --no-unbinned-bin
      position: 18

  metaalpha:
    type: float?
    doc: Regularization parameter for sparse propagation procedure. Increase/decrease for more agressive/conservative refining (default 0.6)
    label: Regularization parameter for sparse propagation procedure
    inputBinding:
      prefix: -ma
      position: 19

  length_threshold:
    type: int?
    doc: Binning will not be propagated to edges longer than threshold
    label: Binning will not be propagated to edges longer than threshold
    inputBinding:
      prefix: -lt
      position: 20

  distance_bound:
    type: int?
    doc: Binning will not be propagated further than bound from initially binned edges
    label: Binning will not be propagated further than bound from initially binned edges
    inputBinding:
      prefix: -db
      position: 21

  split_reads:
    type: boolean?
    doc: Split reads according to binning. Can be used for reassembly.
    label: Split reads according to binning
    inputBinding:
      prefix: -r
      position: 22

  bin_weight:
    type: float?
    doc: Reads bin weight threshold (default 0.1)
    label: Reads bin weight threshold
    inputBinding:
      prefix: -b
      position: 23

  bin_load:
    type: boolean?
    doc: Load binary-converted reads from tmpdir
    label: Load binary-converted reads from tmpdir
    inputBinding:
      prefix: --bin-load
      position: 24

  debug:
    type: boolean?
    doc: produce lots of debug data, set to true by default here
    label: Produce lots of debug data
    inputBinding:
      prefix: --debug
      position: 25


  scratch_directory:
    type: string?
    doc: scratch directory to use
    label: Scratch directory
    inputBinding:
      prefix: --tmp-dir
      position: 26
    # make sure it does not exist


arguments:
  - valueFrom: BinSpreader
    position: 2


outputs:
  refined_contig2bin:
    type: File
    doc: Refined binning in .tsv format
    label: Refined binning
    outputBinding:
      glob: BinSpreader/binning.tsv

  bin_stats:
    type: File
    doc: Various per-bin statistics
    label: Various per-bin statistics
    outputBinding:
      glob: BinSpreader/bin_stats.tsv

  bin_weights:
    type: File
    doc: Soft bin weights per contig
    label: Soft bin weights per contig
    outputBinding:
      glob: BinSpreader/bin_weights.tsv

  edge_weights:
    type: File
    doc: Soft bin weights per edge
    label: Soft bin weights per edge
    outputBinding:
      glob: BinSpreader/edge_weights.tsv

  bin_dist:
    type: File?
    doc: Refined bin distance matrix (if --bin-dist was used)
    label: Refined bin distance matrix
    outputBinding:
      glob: BinSpreader/bin_dist.tsv

  bin_label_1:
    type: File?
    doc: Read set for bin labeled by bin_label (if --reads was used)
    label: Read set for bin labeled by bin_label
    outputBinding:
      glob: BinSpreader/bin_label_1.fastq

  bin_label_2:
    type: File?
    doc: Read set for bin labeled by bin_label (if --reads was used)
    label: Read set for bin labeled by bin_label
    outputBinding:
      glob: BinSpreader/bin_label_2.fastq

  pe_links:
    type: File?
    doc: List of paired-end links between assembly graph edges with weights (if --debug was used)
    label: List of paired-end links between assembly graph edges with weights
    outputBinding:
      glob: BinSpreader/pe_links.tsv

  graph_links:
    type: File?
    doc: List of graph links between assembly graph edges with weights (if --debug was used)
    label: List of graph links between assembly graph edges with weights
    outputBinding:
      glob: BinSpreader/graph_links.tsv


s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2024-07-04"
s:dateModified: "2024-07-04"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/