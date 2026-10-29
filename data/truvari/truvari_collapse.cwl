cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - collapse
label: truvari_collapse
doc: "Structural variant collapser. Will collapse all variants within sizemin/max that match over thresholds\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: input
    type: File
    secondaryFiles:
      - .tbi
    doc: Input variants
    inputBinding:
      position: 1
      prefix: "-i"
  - id: output
    type:
      - 'null'
      - string
    default: collapsed.vcf
    doc: Output vcf (stdout)
    inputBinding:
      position: 1
      prefix: "-o"
  - id: removed_output
    type:
      - 'null'
      - string
    default: removed.vcf
    doc: Variants that collapsed into kept variants (removed.vcf)
    inputBinding:
      position: 1
      prefix: "-c"
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: Indexed fasta used to call variants. Only needed with symbolic variants.
    inputBinding:
      position: 1
      prefix: "-f"
  - id: write_resolved
    type:
      - 'null'
      - boolean
    doc: Replace resolved symbolic variants with their sequence
    inputBinding:
      position: 1
      prefix: "-w"
  - id: keep
    type:
      - 'null'
      - type: enum
        symbols:
          - first
          - maxqual
          - common
    doc: When collapsing calls, which one to keep (first)
    inputBinding:
      position: 1
      prefix: "-k"
  - id: bed
    type:
      - 'null'
      - File
    doc: Bed file of regions to analyze
    inputBinding:
      position: 1
      prefix: "--bed"
  - id: gt
    type:
      - 'null'
      - type: enum
        symbols:
          - 'off'
          - all
          - het
    doc: Disallow intra-sample events to collapse for genotypes (off)
    inputBinding:
      position: 1
      prefix: "--gt"
  - id: intra
    type:
      - 'null'
      - boolean
    doc: Intrasample merge to first sample in output (False)
    inputBinding:
      position: 1
      prefix: "--intra"
  - id: median_info
    type:
      - 'null'
      - boolean
    doc: Store median start/end/size of collapsed entries in kept's INFO
    inputBinding:
      position: 1
      prefix: "--median-info"
  - id: fast_cluster
    type:
      - 'null'
      - boolean
    doc: Perform pre-clustering faster, but potentially lose matches (False)
    inputBinding:
      position: 1
      prefix: "-F"
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose logging
    inputBinding:
      position: 1
      prefix: "--debug"
  - id: refdist
    type:
      - 'null'
      - int
    doc: Max reference location distance (500)
    inputBinding:
      position: 1
      prefix: "-r"
  - id: pctseq
    type:
      - 'null'
      - float
    doc: Min percent sequence similarity. Set to 0 to ignore. (0.95)
    inputBinding:
      position: 1
      prefix: "-p"
  - id: pctsize
    type:
      - 'null'
      - float
    doc: Min pct allele size similarity (minvarsize/maxvarsize) (0.95)
    inputBinding:
      position: 1
      prefix: "-P"
  - id: pctovl
    type:
      - 'null'
      - float
    doc: Min pct reciprocal overlap (0.0) for DEL events
    inputBinding:
      position: 1
      prefix: "-O"
  - id: typeignore
    type:
      - 'null'
      - boolean
    doc: Variant types don't need to match to compare (False)
    inputBinding:
      position: 1
      prefix: "-t"
  - id: no_roll
    type:
      - 'null'
      - boolean
    doc: Turn off rolling sequence similarity
    inputBinding:
      position: 1
      prefix: "-n"
  - id: max_resolve
    type:
      - 'null'
      - int
    doc: Maximum size of variant to attempt to sequence resolve
    inputBinding:
      position: 1
      prefix: "-m"
  - id: decompose
    type:
      - 'null'
      - boolean
    doc: Allow decomposition for SV to BND comparison (False)
    inputBinding:
      position: 1
      prefix: "-D"
  - id: dup_to_ins
    type:
      - 'null'
      - boolean
    doc: Assume DUP svtypes are INS (False)
    inputBinding:
      position: 1
      prefix: "-d"
  - id: bnddist
    type:
      - 'null'
      - int
    doc: Maximum distance allowed between BNDs (100; -1=off)
    inputBinding:
      position: 1
      prefix: "-B"
  - id: hap
    type:
      - 'null'
      - boolean
    doc: Collapsing a single individual's haplotype resolved calls (False)
    inputBinding:
      position: 1
      prefix: "--hap"
  - id: chain
    type:
      - 'null'
      - boolean
    doc: Chain comparisons to extend possible collapsing (False)
    inputBinding:
      position: 1
      prefix: "--chain"
  - id: no_consolidate
    type:
      - 'null'
      - boolean
    doc: Skip consolidation of sample genotype fields (False)
    inputBinding:
      position: 1
      prefix: "--no-consolidate"
  - id: sizemin
    type:
      - 'null'
      - int
    doc: Minimum variant size to consider for comparison (50)
    inputBinding:
      position: 1
      prefix: "-s"
  - id: sizemax
    type:
      - 'null'
      - int
    doc: Maximum variant size to consider for comparison (-1 = off; 50000)
    inputBinding:
      position: 1
      prefix: "-S"
  - id: passonly
    type:
      - 'null'
      - boolean
    doc: Only consider calls with FILTER == PASS
    inputBinding:
      position: 1
      prefix: "--passonly"
outputs:
  - id: output_vcf
    type: File
    doc: Collapsed (kept) variants
    outputBinding:
      glob: "$(inputs.output)"
  - id: removed_vcf
    type: File
    doc: Variants that collapsed into kept variants
    outputBinding:
      glob: "$(inputs.removed_output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
