cwlVersion: v1.2
class: CommandLineTool
baseCommand: jasmine
label: jasminesv_jasmine
doc: "Merge variants from multiple VCF files.\n\nTool homepage: https://github.com/mkirsche/Jasmine"
inputs:
  - id: allow_intrasample
    type:
      - 'null'
      - boolean
    doc: allow variants in the same sample to be merged
    inputBinding:
      position: 101
  - id: bam_list
    type:
      - 'null'
      - File
    doc: a file listing paths to BAMs in the same order as the VCFs
    inputBinding:
      position: 101
  - id: centroid_merging
    type:
      - 'null'
      - boolean
    doc: require every group to have a centroid which is within the distance 
      threshold of each variant
    inputBinding:
      position: 101
  - id: chr_norm_file
    type:
      - 'null'
      - File
    doc: the path to a file containing chromosome name mappings, if they are 
      being normalized
    inputBinding:
      position: 101
  - id: clique_merging
    type:
      - 'null'
      - boolean
    doc: require every group to have each pair within in it be mergeable
    inputBinding:
      position: 101
  - id: comma_filelist
    type:
      - 'null'
      - boolean
    doc: input VCFs are given comma-separated instead of providing a txt file
    inputBinding:
      position: 101
  - id: default_zero_genotype
    type:
      - 'null'
      - boolean
    doc: marks genotype as 0|0 instead of ./. for any samples in which a merged 
      variant is absent
    inputBinding:
      position: 101
  - id: dup_to_ins
    type:
      - 'null'
      - boolean
    doc: convert duplications to insertions for SV merging and then convert them
      back
    inputBinding:
      position: 101
  - id: file_list
    type: File
    doc: a file listing paths to unzipped VCF files to merge (on separate lines)
    inputBinding:
      position: 101
  - id: genome_file
    type:
      - 'null'
      - File
    doc: the reference genome being used
    inputBinding:
      position: 101
  - id: ignore_merged_inputs
    type:
      - 'null'
      - boolean
    doc: ignore merging info such as support vectors which is already present in
      the inputs
    inputBinding:
      position: 101
  - id: ignore_strand
    type:
      - 'null'
      - boolean
    doc: allow variants with different strands to be merged
    inputBinding:
      position: 101
  - id: ignore_type
    type:
      - 'null'
      - boolean
    doc: allow variants with different types to be merged
    inputBinding:
      position: 101
  - id: iris_args
    type:
      - 'null'
      - string
    doc: a comma-separated list of optional arguments to pass to Iris
    inputBinding:
      position: 101
  - id: k_jaccard
    type:
      - 'null'
      - int
    doc: the kmer size to use when computing Jaccard similarity of insertions
    inputBinding:
      position: 101
  - id: kd_tree_norm
    type:
      - 'null'
      - int
    doc: the power to use in kd-tree distances (1 is Manhattan, 2 is Euclidean, 
      etc.)
    inputBinding:
      position: 101
  - id: keep_var_ids
    type:
      - 'null'
      - boolean
    doc: don't change variant IDs (should only be used if input IDs are unique 
      across samples)
    inputBinding:
      position: 101
  - id: leave_breakpoints
    type:
      - 'null'
      - boolean
    doc: leave breakpoints as they are even if they are inconsistent
    inputBinding:
      position: 101
  - id: mark_specific
    type:
      - 'null'
      - boolean
    doc: mark calls in the original VCF files that have enough support to called
      specific
    inputBinding:
      position: 101
  - id: max_dist
    type:
      - 'null'
      - int
    doc: the maximum distance variants can be apart when being merged
    inputBinding:
      position: 101
  - id: max_dist_linear
    type:
      - 'null'
      - float
    doc: the proportion of the length of each variant to set distance threshold 
      to
    inputBinding:
      position: 101
  - id: max_dup_length
    type:
      - 'null'
      - string
    doc: the maximum length of duplication that can be converted to an insertion
    inputBinding:
      position: 101
  - id: min_dist
    type:
      - 'null'
      - int
    doc: the minimum distance threshold a variant can have when using 
      max_dist_linear
    inputBinding:
      position: 101
  - id: min_overlap
    type:
      - 'null'
      - float
    doc: the minimum reciprocal overlap for DEL/INV/DUP SVs
    inputBinding:
      position: 101
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: the minimum sequence identity for two insertions to be merged
    inputBinding:
      position: 101
  - id: min_support
    type:
      - 'null'
      - int
    doc: the minimum number of callsets a variant must be in to be output
    inputBinding:
      position: 101
  - id: non_mutual_distance
    type:
      - 'null'
      - boolean
    doc: no longer require a pair of points to be within both of their distance 
      thresholds
    inputBinding:
      position: 101
  - id: nonlinear_dist
    type:
      - 'null'
      - boolean
    doc: disable distance threshold depending on variant length and use max_dist
      instead
    inputBinding:
      position: 101
  - id: normalize_chrs
    type:
      - 'null'
      - boolean
    doc: normalize chromosome names (to NCBI standards - without "chr" - by 
      default)
    inputBinding:
      position: 101
  - id: normalize_type
    type:
      - 'null'
      - boolean
    doc: convert all variants to INS/DEL/DUP/INV/TRA
    inputBinding:
      position: 101
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: the directory where intermediate files go
    inputBinding:
      position: 101
  - id: output_genotypes
    type:
      - 'null'
      - boolean
    doc: print the genotypes of the consensus variants in all of the samples 
      they came from
    inputBinding:
      position: 101
  - id: postprocess_only
    type:
      - 'null'
      - boolean
    doc: only run the postprocessing and not the actual merging or 
      pre-processing
    inputBinding:
      position: 101
  - id: pre_normalize
    type:
      - 'null'
      - boolean
    doc: run type normalization before merging
    inputBinding:
      position: 101
  - id: preprocess_only
    type:
      - 'null'
      - boolean
    doc: only run the preprocessing and not the actual merging or 
      post-processing
    inputBinding:
      position: 101
  - id: require_first_sample
    type:
      - 'null'
      - boolean
    doc: only output merged variants which include a variant from the first 
      sample
    inputBinding:
      position: 101
  - id: run_iris
    type:
      - 'null'
      - boolean
    doc: run Iris before merging for refining the sequences of insertions
    inputBinding:
      position: 101
  - id: sample_dists
    type:
      - 'null'
      - File
    doc: the path to a file containing distance thresholds for each sample, one 
      per line
    inputBinding:
      position: 101
  - id: samtools_path
    type:
      - 'null'
      - string
    doc: the path to the samtools executable used for coverting duplications
    inputBinding:
      position: 101
  - id: spec_len
    type:
      - 'null'
      - int
    doc: the minimum length a variant needs to be in the specific callset
    inputBinding:
      position: 101
  - id: spec_reads
    type:
      - 'null'
      - int
    doc: the minimum number of reads a variant needs to be in the specific 
      callset
    inputBinding:
      position: 101
  - id: threads
    type:
      - 'null'
      - int
    doc: the number of threads to use for merging the variants
    inputBinding:
      position: 101
  - id: use_edit_dist
    type:
      - 'null'
      - boolean
    doc: use edit distance for comparing insertion sequences instead of Jaccard
    inputBinding:
      position: 101
  - id: use_end
    type:
      - 'null'
      - boolean
    doc: use the end coordinate as the second coordinate instead of the variant 
      length
    inputBinding:
      position: 101
outputs:
  - id: out_file
    type: File
    doc: the name of the file to output the merged variants to
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jasminesv:1.1.5--hdfd78af_0
