cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cladeomatic
  - create
label: cladeomatic_create
doc: "Clade-O-Matic: Genotyping scheme development v. 0.1.1. Identify population structure and develop typing scheme.\n\nTool homepage: https://github.com/phac-nml/cladeomatic"
inputs:
  - id: in_var
    type: File
    doc: 'Either Variant Call SNP data (.vcf) or TSV SNP data (.txt)'
    inputBinding:
      position: 101
      prefix: --in_var
  - id: in_nwk
    type:
      - 'null'
      - File
    doc: 'Newick Tree of strains'
    inputBinding:
      position: 101
      prefix: --in_nwk
  - id: in_groups
    type:
      - 'null'
      - File
    doc: 'Tab delimited file of genotypes'
    inputBinding:
      position: 101
      prefix: --in_groups
  - id: in_meta
    type: File
    doc: 'Tab delimited file of metadata'
    inputBinding:
      position: 101
      prefix: --in_meta
  - id: reference
    type: File
    doc: 'Reference genbank or fasta sequence from VCF'
    inputBinding:
      position: 101
      prefix: --reference
  - id: outdir
    type: string
    doc: 'Output Directory to put results'
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Prefix for output files (default: cladeomatic)'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: root_name
    type:
      - 'null'
      - string
    doc: 'Name of sample to root tree'
    inputBinding:
      position: 101
      prefix: --root_name
  - id: root_method
    type:
      - 'null'
      - string
    doc: 'Method to root tree (midpoint,outgroup)'
    inputBinding:
      position: 101
      prefix: --root_method
  - id: klen
    type:
      - 'null'
      - int
    doc: 'kmer length (default: 18)'
    inputBinding:
      position: 101
      prefix: --klen
  - id: min_members
    type:
      - 'null'
      - int
    doc: 'Minimum number of members for a clade to be valid (default: 1)'
    inputBinding:
      position: 101
      prefix: --min_members
  - id: min_snp_count
    type:
      - 'null'
      - int
    doc: 'Minimum number of unique SNPs for a clade to be valid (default: 1)'
    inputBinding:
      position: 101
      prefix: --min_snp_count
  - id: max_snp_count
    type:
      - 'null'
      - int
    doc: 'Maximum number of SNPs to be selected for defining each genotype to prevent large numbers of redundant SNPs (default: -1)'
    inputBinding:
      position: 101
      prefix: --max_snp_count
  - id: min_perc
    type:
      - 'null'
      - float
    doc: 'Minimum percentage of clade members to be positive for a kmer to be valid (default: 0.1)'
    inputBinding:
      position: 101
      prefix: --min_perc
  - id: max_site_ambig
    type:
      - 'null'
      - float
    doc: 'Maximum percentage of input sequences which can be missing a site for it to still be valid (default: 0.25)'
    inputBinding:
      position: 101
      prefix: --max_site_ambig
  - id: max_states
    type:
      - 'null'
      - int
    doc: 'Maximum number of states for a position [A,T,C,G,N,-] (default: 6)'
    inputBinding:
      position: 101
      prefix: --max_states
  - id: max_ambig
    type:
      - 'null'
      - int
    doc: 'Maximum number of ambiguous bases allowed in a kmer (default: 0)'
    inputBinding:
      position: 101
      prefix: --max_ambig
  - id: rcor_thresh
    type:
      - 'null'
      - float
    doc: 'Correlation coefficient threshold (default: 0.4)'
    inputBinding:
      position: 101
      prefix: --rcor_thresh
  - id: delim
    type:
      - 'null'
      - string
    doc: 'Genotype delimiter in group file'
    inputBinding:
      position: 101
      prefix: --delim
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use (default: 1)'
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: no_plots
    type:
      - 'null'
      - boolean
    doc: 'Disable plotting'
    inputBinding:
      position: 101
      prefix: --no_plots
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: 'Keep interim files'
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Show debug information'
    inputBinding:
      position: 101
      prefix: --debug
  - id: resume
    type:
      - 'null'
      - boolean
    doc: 'Resume previous analysis'
    inputBinding:
      position: 101
      prefix: --resume
  - id: no_compression
    type:
      - 'null'
      - boolean
    doc: 'Skip compression of tree hierarchy'
    inputBinding:
      position: 101
      prefix: --no_compression
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Force overwrite of existing results directory'
    inputBinding:
      position: 101
      prefix: --force
outputs:
  - id: outdir_dir
    type: Directory
    doc: Output Directory with the scheme, clade, SNP and kmer reports
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cladeomatic:0.1.1--pyhdfd78af_0
