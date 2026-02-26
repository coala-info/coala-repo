cwlVersion: v1.2
class: CommandLineTool
baseCommand: jasmine
label: jasminesv_split_jasmine
doc: "Merge variants from multiple VCF files.\n\nTool homepage: https://github.com/mkirsche/Jasmine"
inputs:
  - id: allow_intrasample
    type:
      - 'null'
      - boolean
    doc: allow variants in the same sample to be merged
    inputBinding:
      position: 101
      prefix: --allow_intrasample
  - id: bam_list
    type:
      - 'null'
      - File
    doc: a file listing paths to BAMs in the same order as the VCFs
    inputBinding:
      position: 101
      prefix: bam_list
  - id: centroid_merging
    type:
      - 'null'
      - boolean
    doc: require every group to have a centroid which is within the distance 
      threshold of each variant
    inputBinding:
      position: 101
      prefix: --centroid_merging
  - id: chr_norm_file
    type:
      - 'null'
      - File
    doc: the path to a file containing chromosome name mappings, if they are 
      being normalized
    inputBinding:
      position: 101
      prefix: chr_norm_file
  - id: clique_merging
    type:
      - 'null'
      - boolean
    doc: require every group to have each pair within in it be mergeable
    inputBinding:
      position: 101
      prefix: --clique_merging
  - id: comma_filelist
    type:
      - 'null'
      - boolean
    doc: input VCFs are given comma-separated instead of providing a txt file
    inputBinding:
      position: 101
      prefix: --comma_filelist
  - id: default_zero_genotype
    type:
      - 'null'
      - boolean
    doc: marks genotype as 0|0 instead of ./. for any samples in which a merged 
      variant is absent
    inputBinding:
      position: 101
      prefix: --default_zero_genotype
  - id: dup_to_ins
    type:
      - 'null'
      - boolean
    doc: convert duplications to insertions for SV merging and then convert them
      back
    inputBinding:
      position: 101
      prefix: --dup_to_ins
  - id: file_list
    type: File
    doc: a file listing paths to unzipped VCF files to merge (on separate lines)
    inputBinding:
      position: 101
      prefix: file_list
  - id: genome_file
    type:
      - 'null'
      - File
    doc: the reference genome being used
    inputBinding:
      position: 101
      prefix: genome_file
  - id: ignore_merged_inputs
    type:
      - 'null'
      - boolean
    doc: ignore merging info such as support vectors which is already present in
      the inputs
    inputBinding:
      position: 101
      prefix: --ignore_merged_inputs
  - id: ignore_strand
    type:
      - 'null'
      - boolean
    doc: allow variants with different strands to be merged
    inputBinding:
      position: 101
      prefix: --ignore_strand
  - id: ignore_type
    type:
      - 'null'
      - boolean
    doc: allow variants with different types to be merged
    inputBinding:
      position: 101
      prefix: --ignore_type
  - id: iris_args
    type:
      - 'null'
      - string
    doc: a comma-separated list of optional arguments to pass to Iris
    inputBinding:
      position: 101
      prefix: iris_args
  - id: k_jaccard
    type:
      - 'null'
      - int
    doc: the kmer size to use when computing Jaccard similarity of insertions
    default: 9
    inputBinding:
      position: 101
      prefix: k_jaccard
  - id: kd_tree_norm
    type:
      - 'null'
      - int
    doc: the power to use in kd-tree distances (1 is Manhattan, 2 is Euclidean, 
      etc.)
    default: 2
    inputBinding:
      position: 101
      prefix: kd_tree_norm
  - id: keep_var_ids
    type:
      - 'null'
      - boolean
    doc: don't change variant IDs (should only be used if input IDs are unique 
      across samples)
    inputBinding:
      position: 101
      prefix: --keep_var_ids
  - id: leave_breakpoints
    type:
      - 'null'
      - boolean
    doc: leave breakpoints as they are even if they are inconsistent
    inputBinding:
      position: 101
      prefix: --leave_breakpoints
  - id: mark_specific
    type:
      - 'null'
      - boolean
    doc: mark calls in the original VCF files that have enough support to called
      specific
    inputBinding:
      position: 101
      prefix: --mark_specific
  - id: max_dist
    type:
      - 'null'
      - int
    doc: the maximum distance variants can be apart when being merged
    default: inf
    inputBinding:
      position: 101
      prefix: max_dist
  - id: max_dist_linear
    type:
      - 'null'
      - float
    doc: the proportion of the length of each variant to set distance threshold 
      to
    default: 0.5
    inputBinding:
      position: 101
      prefix: max_dist_linear
  - id: max_dup_length
    type:
      - 'null'
      - int
    doc: the maximum length of duplication that can be converted to an insertion
    default: 10k
    inputBinding:
      position: 101
      prefix: max_dup_length
  - id: min_dist
    type:
      - 'null'
      - int
    doc: the minimum distance threshold a variant can have when using 
      max_dist_linear
    default: 100
    inputBinding:
      position: 101
      prefix: min_dist
  - id: min_overlap
    type:
      - 'null'
      - float
    doc: the minimum reciprocal overlap for DEL/INV/DUP SVs
    default: 0
    inputBinding:
      position: 101
      prefix: min_overlap
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: the minimum sequence identity for two insertions to be merged
    default: 0
    inputBinding:
      position: 101
      prefix: min_seq_id
  - id: min_support
    type:
      - 'null'
      - int
    doc: the minimum number of callsets a variant must be in to be output
    default: 1
    inputBinding:
      position: 101
      prefix: min_support
  - id: non_mutual_distance
    type:
      - 'null'
      - boolean
    doc: no longer require a pair of points to be within both of their distance 
      thresholds
    inputBinding:
      position: 101
      prefix: --non_mutual_distance
  - id: nonlinear_dist
    type:
      - 'null'
      - boolean
    doc: disable distance threshold depending on variant length and use max_dist
      instead
    inputBinding:
      position: 101
      prefix: --nonlinear_dist
  - id: normalize_chrs
    type:
      - 'null'
      - boolean
    doc: normalize chromosome names (to NCBI standards - without "chr" - by 
      default)
    inputBinding:
      position: 101
      prefix: --normalize_chrs
  - id: normalize_type
    type:
      - 'null'
      - boolean
    doc: convert all variants to INS/DEL/DUP/INV/TRA
    inputBinding:
      position: 101
      prefix: --normalize_type
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: the directory where intermediate files go
    default: output
    inputBinding:
      position: 101
      prefix: out_dir
  - id: output_genotypes
    type:
      - 'null'
      - boolean
    doc: print the genotypes of the consensus variants in all of the samples 
      they came from
    inputBinding:
      position: 101
      prefix: --output_genotypes
  - id: postprocess_only
    type:
      - 'null'
      - boolean
    doc: only run the postprocessing and not the actual merging or 
      pre-processing
    inputBinding:
      position: 101
      prefix: --postprocess_only
  - id: pre_normalize
    type:
      - 'null'
      - boolean
    doc: run type normalization before merging
    inputBinding:
      position: 101
      prefix: --pre_normalize
  - id: preprocess_only
    type:
      - 'null'
      - boolean
    doc: only run the preprocessing and not the actual merging or 
      post-processing
    inputBinding:
      position: 101
      prefix: --preprocess_only
  - id: require_first_sample
    type:
      - 'null'
      - boolean
    doc: only output merged variants which include a variant from the first 
      sample
    inputBinding:
      position: 101
      prefix: --require_first_sample
  - id: run_iris
    type:
      - 'null'
      - boolean
    doc: run Iris before merging for refining the sequences of insertions
    inputBinding:
      position: 101
      prefix: --run_iris
  - id: sample_dists
    type:
      - 'null'
      - File
    doc: the path to a file containing distance thresholds for each sample, one 
      per line
    inputBinding:
      position: 101
      prefix: sample_dists
  - id: samtools_path
    type:
      - 'null'
      - string
    doc: the path to the samtools executable used for coverting duplications
    default: samtools
    inputBinding:
      position: 101
      prefix: samtools_path
  - id: spec_len
    type:
      - 'null'
      - int
    doc: the minimum length a variant needs to be in the specific callset
    default: 30
    inputBinding:
      position: 101
      prefix: spec_len
  - id: spec_reads
    type:
      - 'null'
      - int
    doc: the minimum number of reads a variant needs to be in the specific 
      callset
    default: 10
    inputBinding:
      position: 101
      prefix: spec_reads
  - id: threads
    type:
      - 'null'
      - int
    doc: the number of threads to use for merging the variants
    default: 1
    inputBinding:
      position: 101
      prefix: threads
  - id: use_edit_dist
    type:
      - 'null'
      - boolean
    doc: use edit distance for comparing insertion sequences instead of Jaccard
    inputBinding:
      position: 101
      prefix: --use_edit_dist
  - id: use_end
    type:
      - 'null'
      - boolean
    doc: use the end coordinate as the second coordinate instead of the variant 
      length
    inputBinding:
      position: 101
      prefix: --use_end
outputs:
  - id: out_file
    type: File
    doc: the name of the file to output the merged variants to
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jasminesv:1.1.5--hdfd78af_0
