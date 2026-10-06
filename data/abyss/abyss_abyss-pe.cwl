cwlVersion: v1.2
class: CommandLineTool
label: abyss_abyss-pe
doc: "ABySS de novo assembler driver: assemble short reads into unitigs, contigs and scaffolds. abyss-pe takes PARAMETER=VALUE settings (see the abyss-pe man page and README).\n\nTool homepage: https://github.com/bcgsc/abyss"
baseCommand: [abyss-pe]
hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/abyss:2.3.10--hf316886_2
inputs:
  name:
    type: string
    default: abyss
    doc: "Prefix of all output files."
    inputBinding: {prefix: "name=", separate: false, position: 1}
  k:
    type: int
    doc: "Size of k-mer (or span of a k-mer pair when K is set)."
    inputBinding: {prefix: "k=", separate: false, position: 1}
  paired_reads:
    type: File[]?
    doc: "Reads of one paired-end library (in=): forward and reverse files, or one interleaved file."
    inputBinding: {prefix: "in=", separate: false, itemSeparator: " ", position: 1}
  single_end_reads:
    type: File[]?
    doc: "Single-end reads (se=)."
    inputBinding: {prefix: "se=", separate: false, itemSeparator: " ", position: 1}
  max_bubble_branches:
    type: int?
    doc: "Maximum number of branches of a bubble [2]."
    inputBinding: {prefix: "a=", separate: false, position: 1}
  max_bubble_length:
    type: int?
    doc: "Maximum length of a bubble (bp)."
    inputBinding: {prefix: "b=", separate: false, position: 1}
  bloom_size:
    type: string
    default: 500M
    doc: "Bloom filter size (e.g. 100M). abyss-pe 2.3 requires B (Bloom filter mode) or np (MPI mode)."
    inputBinding: {prefix: "B=", separate: false, position: 1}
  min_unitig_coverage:
    type: float?
    doc: "Minimum mean k-mer coverage of a unitig [sqrt(median)]."
    inputBinding: {prefix: "c=", separate: false, position: 1}
  distance_error:
    type: int?
    doc: "Allowable error of a distance estimate (bp) [6]."
    inputBinding: {prefix: "d=", separate: false, position: 1}
  erosion_coverage:
    type: int?
    doc: "Minimum erosion k-mer coverage [round(sqrt(median))]."
    inputBinding: {prefix: "e=", separate: false, position: 1}
  erosion_strand_coverage:
    type: int?
    doc: "Minimum erosion k-mer coverage per strand."
    inputBinding: {prefix: "E=", separate: false, position: 1}
  genome_size:
    type: long?
    doc: "Genome size, used to calculate NG50."
    inputBinding: {prefix: "G=", separate: false, position: 1}
  bloom_hashes:
    type: int?
    doc: "Number of Bloom filter hash functions [4]."
    inputBinding: {prefix: "H=", separate: false, position: 1}
  threads:
    type: int?
    doc: "Number of threads [2]."
    inputBinding: {prefix: "j=", separate: false, position: 1}
  bloom_min_kmer_count:
    type: int?
    doc: "Minimum k-mer count threshold for Bloom filter assembly [2]."
    inputBinding: {prefix: "kc=", separate: false, position: 1}
  kmer_pair_k:
    type: int?
    doc: "Length of a single k-mer in a k-mer pair (bp)."
    inputBinding: {prefix: "K=", separate: false, position: 1}
  min_alignment_length:
    type: int?
    doc: "Minimum alignment length of a read (bp) [40]."
    inputBinding: {prefix: "l=", separate: false, position: 1}
  min_unitig_overlap:
    type: int?
    doc: "Minimum overlap of two unitigs (bp)."
    inputBinding: {prefix: "m=", separate: false, position: 1}
  min_contig_pairs:
    type: int?
    doc: "Minimum number of pairs required for building contigs [10]."
    inputBinding: {prefix: "n=", separate: false, position: 1}
  min_scaffold_pairs:
    type: int?
    doc: "Minimum number of pairs required for building scaffolds [15-20]."
    inputBinding: {prefix: "N=", separate: false, position: 1}
  min_bubble_identity:
    type: float?
    doc: "Minimum sequence identity of a bubble [0.9]."
    inputBinding: {prefix: "p=", separate: false, position: 1}
  min_base_quality:
    type: int?
    doc: "Minimum base quality [3]."
    inputBinding: {prefix: "q=", separate: false, position: 1}
  min_unitig_size:
    type: int?
    doc: "Minimum unitig size required for building contigs (bp) [1000]."
    inputBinding: {prefix: "s=", separate: false, position: 1}
  min_contig_size:
    type: int?
    doc: "Minimum contig size required for building scaffolds (bp)."
    inputBinding: {prefix: "S=", separate: false, position: 1}
  max_blunt_trim:
    type: int?
    doc: "Maximum length of blunt contigs to trim [k]."
    inputBinding: {prefix: "t=", separate: false, position: 1}
  verbosity:
    type: string?
    doc: "Verbosity: -v or -vv."
    inputBinding: {prefix: "v=", separate: false, position: 1}
  spaced_seed:
    type: string?
    doc: "Spaced seed (Bloom filter assembly only)."
    inputBinding: {prefix: "x=", separate: false, position: 1}
outputs:
  unitigs:
    type: File
    doc: "Unitigs (<name>-unitigs.fa)."
    outputBinding: {glob: $(inputs.name)-unitigs.fa}
  contigs:
    type: File?
    doc: "Contigs from paired reads (<name>-contigs.fa)."
    outputBinding: {glob: $(inputs.name)-contigs.fa}
  scaffolds:
    type: File?
    doc: "Scaffolds (<name>-scaffolds.fa)."
    outputBinding: {glob: $(inputs.name)-scaffolds.fa}
  stats:
    type: File?
    doc: "Assembly statistics (<name>-stats.tab)."
    outputBinding: {glob: $(inputs.name)-stats.tab}
  all_files:
    type: File[]
    doc: "Every file abyss-pe wrote with the name prefix."
    outputBinding: {glob: $(inputs.name)*}
