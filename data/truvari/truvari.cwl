cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - bench
label: truvari
doc: "Structural variant benchmarking tool. Given baseline and comparison sets of variants, calculate the recall/precision/f-measure.\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: base_vcf
    type: File
    secondaryFiles:
      - .tbi
    doc: "Baseline truth-set calls (bgzipped VCF with .tbi index)"
    inputBinding:
      position: 101
      prefix: -b
  - id: comp_vcf
    type: File
    secondaryFiles:
      - .tbi
    doc: "Comparison set of calls (bgzipped VCF with .tbi index)"
    inputBinding:
      position: 101
      prefix: -c
  - id: output_dir_path
    type: string
    doc: "Output directory (must not exist)"
    inputBinding:
      position: 101
      prefix: -o
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: "Fasta used to call variants. Only needed with symbolic variants."
    inputBinding:
      position: 101
      prefix: -f
  - id: write_resolved
    type:
      - 'null'
      - boolean
    doc: "Replace resolved symbolic variants with their sequence"
    inputBinding:
      position: 101
      prefix: -w
  - id: short
    type:
      - 'null'
      - boolean
    doc: "Short circuit comparisons. Faster, but fewer annotations"
    inputBinding:
      position: 101
      prefix: --short
  - id: refine
    type:
      - 'null'
      - boolean
    doc: "Run refinement with defaults on the result (requires --reference)"
    inputBinding:
      position: 101
      prefix: --refine
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Verbose logging"
    inputBinding:
      position: 101
      prefix: --debug
  - id: refdist
    type:
      - 'null'
      - int
    doc: "Max reference distance (500)"
    inputBinding:
      position: 101
      prefix: -r
  - id: pctseq
    type:
      - 'null'
      - float
    doc: "Min sequence similarity. Set to 0 to ignore (0.7)"
    inputBinding:
      position: 101
      prefix: -p
  - id: pctsize
    type:
      - 'null'
      - float
    doc: "Min variant size similarity (0.7)"
    inputBinding:
      position: 101
      prefix: -P
  - id: pctovl
    type:
      - 'null'
      - float
    doc: "Min reciprocal overlap (0.0)"
    inputBinding:
      position: 101
      prefix: -O
  - id: typeignore
    type:
      - 'null'
      - boolean
    doc: "Don't compare variant types (False)"
    inputBinding:
      position: 101
      prefix: -t
  - id: pick
    type:
      - 'null'
      - string
    doc: "Number of matches reported per-call: single, ac or multi (single)"
    inputBinding:
      position: 101
      prefix: --pick
  - id: dup_to_ins
    type:
      - 'null'
      - boolean
    doc: "Assume DUP svtypes are INS (False)"
    inputBinding:
      position: 101
      prefix: -d
  - id: bnddist
    type:
      - 'null'
      - int
    doc: "Maximum distance allowed between BNDs (100; -1=off)"
    inputBinding:
      position: 101
      prefix: -B
  - id: no_decompose
    type:
      - 'null'
      - boolean
    doc: "Disallow symbolic variant decomposition to BNDs"
    inputBinding:
      position: 101
      prefix: -N
  - id: max_resolve
    type:
      - 'null'
      - int
    doc: "Maximum size of variant to attempt to sequence resolve (25000)"
    inputBinding:
      position: 101
      prefix: -m
  - id: chunksize
    type:
      - 'null'
      - int
    doc: "Max reference distance to compare calls (1000)"
    inputBinding:
      position: 101
      prefix: -C
  - id: no_roll
    type:
      - 'null'
      - boolean
    doc: "Turn off rolling sequence similarity"
    inputBinding:
      position: 101
      prefix: -n
  - id: bsample
    type:
      - 'null'
      - string
    doc: "Baseline calls' sample to use (first)"
    inputBinding:
      position: 101
      prefix: --bSample
  - id: csample
    type:
      - 'null'
      - string
    doc: "Comparison calls' sample to use (first)"
    inputBinding:
      position: 101
      prefix: --cSample
  - id: passonly
    type:
      - 'null'
      - boolean
    doc: "Only consider calls with FILTER == PASS"
    inputBinding:
      position: 101
      prefix: --passonly
  - id: sizemin
    type:
      - 'null'
      - int
    doc: "Minimum variant size to consider from --base (50)"
    inputBinding:
      position: 101
      prefix: -s
  - id: sizefilt
    type:
      - 'null'
      - int
    doc: "Minimum variant size to consider from --comp (30)"
    inputBinding:
      position: 101
      prefix: -S
  - id: sizemax
    type:
      - 'null'
      - int
    doc: "Maximum variant size to consider (50000; -1 = off)"
    inputBinding:
      position: 101
      prefix: --sizemax
  - id: no_ref
    type:
      - 'null'
      - string
    doc: "Exclude 0/0 or ./. GT calls from all (a), base (b), or comp (c) vcfs (False)"
    inputBinding:
      position: 101
      prefix: --no-ref
  - id: includebed
    type:
      - 'null'
      - File
    doc: "Bed file of regions to analyze. Only calls within regions are counted"
    inputBinding:
      position: 101
      prefix: --includebed
  - id: extend
    type:
      - 'null'
      - int
    doc: "Distance to allow comp entries outside of includebed regions (0)"
    inputBinding:
      position: 101
      prefix: --extend
outputs:
  - id: output_dir
    type: Directory
    doc: Benchmark result directory (summary.json, params.json, log.txt, tp-base.vcf.gz, tp-comp.vcf.gz, fp.vcf.gz, fn.vcf.gz)
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
