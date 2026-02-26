cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varifier
  - make_truth_vcf
label: varifier_make_truth_vcf
doc: "Make truth VCF file\n\nTool homepage: https://github.com/iqbal-lab-org/varifier"
inputs:
  - id: truth_fasta
    type: File
    doc: FASTA file of truth genome
    inputBinding:
      position: 1
  - id: ref_fasta
    type: File
    doc: FASTA file of reference genome
    inputBinding:
      position: 2
  - id: outdir
    type: Directory
    doc: Name of output directory
    inputBinding:
      position: 3
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use when running nucmer and minimap2
    default: 1
    inputBinding:
      position: 104
      prefix: --cpus
  - id: debug
    type:
      - 'null'
      - boolean
    doc: More verbose logging, and less file cleaning
    inputBinding:
      position: 104
      prefix: --debug
  - id: flank_length
    type:
      - 'null'
      - int
    doc: Length of sequence to add either side of variant when making probe 
      sequences
    default: 100
    inputBinding:
      position: 104
      prefix: --flank_length
  - id: global_align
    type:
      - 'null'
      - boolean
    doc: Only use this with small genomes (ie virus) that have one sequence 
      each, in the same orientation. Instead of using minimap2/nucmer to find 
      variants, do a global alignment for greater accuracy
    inputBinding:
      position: 104
      prefix: --global_align
  - id: global_align_max_coord
    type:
      - 'null'
      - int
    doc: Only used if also using --global_align. Do not output variants where 
      the REF allele ends after the given (1-based) coordinate. When running 
      vcf_eval, only applies to recall, not precision
    default: infinity
    inputBinding:
      position: 104
      prefix: --global_align_max_coord
  - id: global_align_min_coord
    type:
      - 'null'
      - int
    doc: Only used if also using --global_align. Do not output variants where 
      the REF allele starts before the given (1-based) coordinate. When running 
      vcf_eval, only applies to recall, not precision
    default: 1
    inputBinding:
      position: 104
      prefix: --global_align_min_coord
  - id: max_recall_ref_len
    type:
      - 'null'
      - int
    doc: Do not include variants where REF length is more than this number. 
      Default is no limit
    inputBinding:
      position: 104
      prefix: --max_recall_ref_len
  - id: no_maxmatch
    type:
      - 'null'
      - boolean
    doc: When using nucmer to get expected calls for recall, do not use the 
      --maxmatch option. May reduce sensitivity to finding all variants
    inputBinding:
      position: 104
      prefix: --no_maxmatch
  - id: sanitise_truth_gaps
    type:
      - 'null'
      - boolean
    doc: Only used if also using --global_align. Use the global alignment to 
      change gap lengths in the truth fasta so that gaps are same length as 
      missing sequence from the reference
    inputBinding:
      position: 104
      prefix: --sanitise_truth_gaps
  - id: split_ref
    type:
      - 'null'
      - boolean
    doc: When using MUMmer, split the ref genome into one file per sequence, and
      run MUMmer on each split. Experimental - should improve run time for big 
      genomes
    inputBinding:
      position: 104
      prefix: --split_ref
  - id: truth_mask
    type:
      - 'null'
      - File
    doc: BED file of truth genome regions to mask. Any variants in the VCF 
      matching to the mask are flagged and will not count towards precision or 
      recall if the output VCF is used with vcf_eval
    inputBinding:
      position: 104
      prefix: --truth_mask
  - id: use_non_acgt
    type:
      - 'null'
      - boolean
    doc: Only used if also using --global_align. When writing initial VCF file 
      (before removing FPs using probe mapping), include records that have 
      non-ACGT characters in their alleles
    inputBinding:
      position: 104
      prefix: --use_non_acgt
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varifier:0.4.0--pyhdfd78af_0
stdout: varifier_make_truth_vcf.out
