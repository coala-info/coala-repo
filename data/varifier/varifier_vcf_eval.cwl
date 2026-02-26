cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varifier
  - vcf_eval
label: varifier_vcf_eval
doc: "Evaluate VCF file\n\nTool homepage: https://github.com/iqbal-lab-org/varifier"
inputs:
  - id: truth_fasta
    type: File
    doc: FASTA file of truth genome
    inputBinding:
      position: 1
  - id: vcf_fasta
    type: File
    doc: FASTA file corresponding to vcf_file
    inputBinding:
      position: 2
  - id: vcf_file
    type: File
    doc: VCF file to evaluate
    inputBinding:
      position: 3
  - id: outdir
    type: Directory
    doc: Name of output directory
    inputBinding:
      position: 4
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use when running nucmer and minimap2 to get recall, 
      eveything else is single-core/thread. If you have a big genome, more 
      efficient to run make_truth_vcf with >1 CPU, then use its output with 
      --truth_vcf when running vcf_eval.
    default: 1
    inputBinding:
      position: 105
      prefix: --cpus
  - id: debug
    type:
      - 'null'
      - boolean
    doc: More verbose logging, and less file cleaning
    inputBinding:
      position: 105
      prefix: --debug
  - id: filter_pass
    type:
      - 'null'
      - type: array
        items: string
    doc: Defines how to handle FILTER column of input VCF file. Comma-separated 
      list of filter names. A VCF line is kept if any of its FILTER entries are 
      in the provided list. Put '.' in the list to keep records where the filter
      column is '.'. Default behaviour is to ignore the filter column and use 
      all records
    inputBinding:
      position: 105
      prefix: --filter_pass
  - id: flank_length
    type:
      - 'null'
      - int
    doc: Length of sequence to add either side of variant when making probe 
      sequences
    default: 100
    inputBinding:
      position: 105
      prefix: --flank_length
  - id: force
    type:
      - 'null'
      - boolean
    doc: Replace outdir if it already exists
    inputBinding:
      position: 105
      prefix: --force
  - id: global_align
    type:
      - 'null'
      - boolean
    doc: Only use this with small genomes (ie virus) that have one sequence 
      each, in the same orientation. Instead of using minimap2/nucmer to find 
      variants, do a global alignment for greater accuracy
    inputBinding:
      position: 105
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
      position: 105
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
      position: 105
      prefix: --global_align_min_coord
  - id: max_recall_ref_len
    type:
      - 'null'
      - int
    doc: Do not include variants where REF length is more than this number. 
      Default is no limit
    inputBinding:
      position: 105
      prefix: --max_recall_ref_len
  - id: no_maxmatch
    type:
      - 'null'
      - boolean
    doc: When using nucmer to get expected calls for recall, do not use the 
      --maxmatch option. May reduce sensitivity to finding all variants
    inputBinding:
      position: 105
      prefix: --no_maxmatch
  - id: ref_mask
    type:
      - 'null'
      - File
    doc: BED file of ref regions to mask. Any variants in the VCF overlapping 
      the mask are removed at the start of the pipeline
    inputBinding:
      position: 105
      prefix: --ref_mask
  - id: split_ref
    type:
      - 'null'
      - boolean
    doc: When using MUMmer, split the ref genome into one file per sequence, and
      run MUMmer on each split. Experimental - should improve run time for big 
      genomes
    inputBinding:
      position: 105
      prefix: --split_ref
  - id: truth_mask
    type:
      - 'null'
      - File
    doc: BED file of truth genome regions to mask. Any variants in the VCF 
      matching to the mask are flagged and do not count towards precision or 
      recall
    inputBinding:
      position: 105
      prefix: --truth_mask
  - id: truth_vcf
    type:
      - 'null'
      - File
    doc: VCF file of variant calls between vcf_fasta and truth_fasta, where 
      reference of this VCF file is truth_fasta. If provided, used to calculate 
      recall
    inputBinding:
      position: 105
      prefix: --truth_vcf
  - id: use_non_acgt
    type:
      - 'null'
      - boolean
    doc: Only used if also using --global_align. When writing initial VCF file 
      (before removing FPs using probe mapping), include records that have 
      non-ACGT characters in their alleles
    inputBinding:
      position: 105
      prefix: --use_non_acgt
  - id: use_ref_calls
    type:
      - 'null'
      - boolean
    doc: Include 0/0 genotype calls when calculating TPs and precision. By 
      default they are ignored
    inputBinding:
      position: 105
      prefix: --use_ref_calls
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varifier:0.4.0--pyhdfd78af_0
stdout: varifier_vcf_eval.out
