cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- wgatools
- call
label: wgatools_call
doc: 'Call Variants from MAF/PAF file


  Tool homepage: https://github.com/wjwei-handsome/wgatools'
inputs:
- id: input_alignment
  type: File
  doc: Input MAF/PAF File
  inputBinding:
    position: 100
- id: sample
  type:
  - 'null'
  - string
  doc: 'Sample name [default: sample]'
  inputBinding:
    position: 1
    prefix: --sample
- id: snp
  type:
  - 'null'
  - boolean
  doc: If call SNP
  inputBinding:
    position: 1
    prefix: --snp
- id: inv
  type:
  - 'null'
  - boolean
  doc: If call Inversion
  inputBinding:
    position: 1
    prefix: --inv
- id: svlen
  type:
  - 'null'
  - long
  doc: 'SV length cutoff [default: 50]'
  inputBinding:
    position: 1
    prefix: --svlen
- id: format
  type:
  - 'null'
  - type: enum
    symbols:
    - maf
    - paf
    - chain
  doc: '[default: maf] [possible values: maf, paf, chain]'
  inputBinding:
    position: 1
    prefix: --format
- id: target
  type:
  - 'null'
  - File
  doc: Input target FASTA File, required if input is PAF
  inputBinding:
    position: 1
    prefix: --target
- id: query
  type:
  - 'null'
  - File
  doc: Input query FASTA File, required if input is PAF
  inputBinding:
    position: 1
    prefix: --query
- id: query_name
  type:
  - 'null'
  - string
  doc: query name when multiple query in MAF, None for first query
  inputBinding:
    position: 1
    prefix: --query-name
- id: query_regex
  type:
  - 'null'
  - string
  doc: 'Query name regex when multiple query in MAF, None for first query. If multiple
    query names in a block match, the first will be used. The --query-regex must match
    the entire query name in the MAF in order to be considered a match. example: --query-regex
    "^hg002#.*"'
  inputBinding:
    position: 1
    prefix: --query-regex
- id: chunk_size
  type:
  - 'null'
  - long
  doc: 'Chunk size for MAF Caller [default: 1000000]'
  inputBinding:
    position: 1
    prefix: --chunk-size
- id: outfile
  type: string
  default: out.vcf
  doc: Output file ("-" for stdout), file name ending in .gz/.bz2/.xz will be compressed
    automatically. Written to the working directory.
  inputBinding:
    position: 101
    prefix: --outfile
- id: rewrite
  type:
  - 'null'
  - boolean
  doc: Bool, if rewrite output file
  inputBinding:
    position: 102
    prefix: --rewrite
- id: threads
  type:
  - 'null'
  - int
  doc: Threads, default 1
  inputBinding:
    position: 103
    prefix: --threads
- id: verbose
  type:
  - 'null'
  - boolean
  doc: 'Logging level [-v: Info, -vv: Debug, -vvv: Trace, defalut: Warn]'
  inputBinding:
    position: 104
    prefix: --verbose
outputs:
- id: output_vcf
  type: File
  doc: VCF file with the called variants
  outputBinding:
    glob: $(inputs.outfile)
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entry: $(inputs.target)
    writable: true
  - entry: $(inputs.query)
    writable: true
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/wgatools:1.1.0--hf6a8760_0
