cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vg
  - call
label: vg_call
doc: "Call variants or genotype known variants\n\nTool homepage: https://github.com/vgteam/vg"
inputs:
  - id: graph
    type: File
    doc: Input graph
    inputBinding:
      position: 1
  - id: all_snarls
    type:
      - 'null'
      - boolean
    doc: genotype all snarls, including nested child snarls (like deconstruct 
      -a)
    inputBinding:
      position: 102
      prefix: --all-snarls
  - id: baseline_error
    type:
      - 'null'
      - string
    doc: baseline error rates for Poisson model for small (X) and large (Y) 
      variants
    inputBinding:
      position: 102
      prefix: --baseline-error
  - id: bias_mode
    type:
      - 'null'
      - boolean
    doc: use old ratio-based genotyping algorithm as opposed to probablistic 
      model
    inputBinding:
      position: 102
      prefix: --bias-mode
  - id: call_chains
    type:
      - 'null'
      - boolean
    doc: call chains instead of snarls (experimental)
    inputBinding:
      position: 102
      prefix: --chains
  - id: gbwt_file
    type:
      - 'null'
      - File
    doc: only call genotypes present in given GBWT index
    inputBinding:
      position: 102
      prefix: --gbwt
  - id: gbz_translation
    type:
      - 'null'
      - boolean
    doc: use the ID translation from the input GBZ to apply snarl names to snarl
      names/AT fields in output
    inputBinding:
      position: 102
      prefix: --gbz-translation
  - id: genotype_snarls
    type:
      - 'null'
      - boolean
    doc: genotype every snarl, including reference calls (use to compare 
      multiple samples)
    inputBinding:
      position: 102
      prefix: --genotype-snarls
  - id: het_bias
    type:
      - 'null'
      - string
    doc: homozygous alt/ref allele must have >= M/N times more support than the 
      next best allele
    inputBinding:
      position: 102
      prefix: --het-bias
  - id: ins_fasta
    type:
      - 'null'
      - File
    doc: insertions (required if VCF has symbolic insertions)
    inputBinding:
      position: 102
      prefix: --ins-fasta
  - id: max_snarl_length
    type:
      - 'null'
      - int
    doc: genotype only snarls where all traversals have length <= N
    inputBinding:
      position: 102
      prefix: --max-length
  - id: min_snarl_length
    type:
      - 'null'
      - int
    doc: genotype only snarls with at least one traversal of length >= N
    inputBinding:
      position: 102
      prefix: --min-length
  - id: min_support
    type:
      - 'null'
      - string
    doc: min allele (M) and site (N) support to call
    inputBinding:
      position: 102
      prefix: --min-support
  - id: nested_calling
    type:
      - 'null'
      - boolean
    doc: activate nested calling mode (experimental)
    inputBinding:
      position: 102
      prefix: --nested
  - id: output_gaf
    type:
      - 'null'
      - boolean
    doc: output GAF genotypes instead of VCF
    inputBinding:
      position: 102
      prefix: --gaf
  - id: output_traversals
    type:
      - 'null'
      - boolean
    doc: output all candidate traversals in GAF without doing any genotyping
    inputBinding:
      position: 102
      prefix: --traversals
  - id: pack_file
    type:
      - 'null'
      - File
    doc: supports created from vg pack for given input graph
    inputBinding:
      position: 102
      prefix: --pack
  - id: ploidy
    type:
      - 'null'
      - int
    doc: ploidy of sample. {1, 2}
    inputBinding:
      position: 102
      prefix: --ploidy
  - id: ploidy_regex
    type:
      - 'null'
      - string
    doc: use this comma-separated list of colon-delimited REGEX:PLOIDY rules to 
      assign ploidies to contigs not visited by the selected samples, or to all 
      contigs simulated from if no samples are used. Unmatched contigs get 
      ploidy 2 (or that from -d).
    inputBinding:
      position: 102
      prefix: --ploidy-regex
  - id: progress
    type:
      - 'null'
      - boolean
    doc: show progress
    inputBinding:
      position: 102
      prefix: --progress
  - id: ref_fasta
    type:
      - 'null'
      - File
    doc: reference FASTA (required if VCF has symbolic deletions/inversions)
    inputBinding:
      position: 102
      prefix: --ref-fasta
  - id: ref_length
    type:
      - 'null'
      - int
    doc: override reference length for output VCF contig
    inputBinding:
      position: 102
      prefix: --ref-length
  - id: ref_offset
    type:
      - 'null'
      - type: array
        items: int
    doc: offset in reference path (may repeat; 1 per path)
    inputBinding:
      position: 102
      prefix: --ref-offset
  - id: ref_path
    type:
      - 'null'
      - type: array
        items: string
    doc: reference path to call on (may repeat; default all)
    inputBinding:
      position: 102
      prefix: --ref-path
  - id: ref_sample
    type:
      - 'null'
      - string
    doc: call on all paths with this sample (cannot use with -p)
    inputBinding:
      position: 102
      prefix: --ref-sample
  - id: sample_name
    type:
      - 'null'
      - string
    doc: sample name
    inputBinding:
      position: 102
      prefix: --sample
  - id: snarls_file
    type:
      - 'null'
      - File
    doc: snarls (from vg snarls) to avoid recomputing.
    inputBinding:
      position: 102
      prefix: --snarls
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: translation_file
    type:
      - 'null'
      - File
    doc: node ID translation (from vg gbwt --translation) to apply to snarl 
      names in output
    inputBinding:
      position: 102
      prefix: --translation
  - id: traversal_padding
    type:
      - 'null'
      - int
    doc: extend each flank of traversals (from -T) with reference path by N 
      bases if possible
    inputBinding:
      position: 102
      prefix: --trav-padding
  - id: use_gbz
    type:
      - 'null'
      - boolean
    doc: only call genotypes present in GBZ index (applies only if input graph 
      is GBZ)
    inputBinding:
      position: 102
      prefix: --gbz
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: VCF file to genotype (must have been used to construct input graph with
      -a)
    inputBinding:
      position: 102
      prefix: --vcf
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: Output VCF file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
