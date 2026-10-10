cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - walk
label: mykatlas_walk
doc: "Walk through a graph using an existing sequence probe set as seeds. default walking algorithm is a depth first search\n\nTool homepage: http://github.com/phelimb/atlas"
inputs:
  - id: sample
    type: string
    doc: "sample id"
    inputBinding:
      position: 1
  - id: probe_set
    type: File
    doc: "probe_set"
    inputBinding:
      position: 2
  - id: kmer
    type:
      - 'null'
      - int
    doc: "kmer length (default:21)"
    inputBinding:
      position: 10
      prefix: "-k"
  - id: tmp
    type:
      - 'null'
      - string
    doc: "tmp directory (default: /tmp/)"
    inputBinding:
      position: 10
      prefix: "--tmp"
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: "Dont remove tmp files"
    inputBinding:
      position: 10
      prefix: "--keep_tmp"
  - id: skeleton_dir
    type: string
    default: skeletons
    doc: "directory for skeleton binaries; it must be writable, so the CWL creates a folder with this name in the working directory"
    inputBinding:
      position: 10
      prefix: --skeleton_dir
  - id: mccortex31_path
    type:
      - 'null'
      - string
    doc: "Path to mccortex31. Default mccortex31"
    inputBinding:
      position: 10
      prefix: "--mccortex31_path"
  - id: threads
    type:
      - 'null'
      - int
    doc: "threads"
    inputBinding:
      position: 10
      prefix: "--threads"
  - id: memory
    type:
      - 'null'
      - string
    doc: "memory for graph constuction"
    inputBinding:
      position: 10
      prefix: "--memory"
  - id: expected_depth
    type:
      - 'null'
      - int
    doc: "expected depth"
    inputBinding:
      position: 10
      prefix: "--expected_depth"
  - id: seq
    type:
      - 'null'
      - type: array
        items: File
    doc: "sequence files (fasta,fastq,bam)"
    inputBinding:
      position: 10
      prefix: "-1"
  - id: ctx
    type:
      - 'null'
      - File
    doc: "cortex graph binary"
    inputBinding:
      position: 10
      prefix: "--ctx"
  - id: force
    type:
      - 'null'
      - boolean
    doc: "force"
    inputBinding:
      position: 10
      prefix: "--force"
  - id: ont
    type:
      - 'null'
      - boolean
    doc: "Set default for ONT data"
    inputBinding:
      position: 10
      prefix: "--ont"
  - id: ignore_filtered
    type:
      - 'null'
      - string
    doc: "don't include filtered genotypes"
    inputBinding:
      position: 10
      prefix: "--ignore_filtered"
  - id: model
    type:
      - 'null'
      - string
    doc: "species"
    inputBinding:
      position: 10
      prefix: "--model"
  - id: filters
    type:
      - 'null'
      - type: array
        items: string
    doc: "don't include filtered genotypes"
    inputBinding:
      position: 10
      prefix: "--filters"
  - id: report_all_calls
    type:
      - 'null'
      - boolean
    doc: "report all calls"
    inputBinding:
      position: 10
      prefix: "--report_all_calls"
  - id: expected_error_rate
    type:
      - 'null'
      - float
    doc: "Expected sequencing error rate. Set to 0.15 for ONT genotyping."
    inputBinding:
      position: 10
      prefix: "--expected_error_rate"
  - id: min_variant_conf
    type:
      - 'null'
      - int
    doc: "minimum genotype confidence for variant genotyping"
    inputBinding:
      position: 10
      prefix: "--min_variant_conf"
  - id: min_gene_conf
    type:
      - 'null'
      - int
    doc: "minimum genotype confidence for gene genotyping"
    inputBinding:
      position: 10
      prefix: "--min_gene_conf"
  - id: min_gene_percent_covg_threshold
    type:
      - 'null'
      - int
    doc: "all genes alleles found above this percent coverage will be reported (default 100 (only best alleles reported))"
    inputBinding:
      position: 10
      prefix: "--min_gene_percent_covg_threshold"
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "do not output warnings to stderr"
    inputBinding:
      position: 10
      prefix: "--quiet"
  - id: also_genotype
    type:
      - 'null'
      - boolean
    doc: "also genotype the sample"
    inputBinding:
      position: 10
      prefix: "--also-genotype"
  - id: show_all_paths
    type:
      - 'null'
      - boolean
    doc: "show all paths"
    inputBinding:
      position: 10
      prefix: "--show-all-paths"
outputs:
  - id: stdout
    type: stdout
    doc: "JSON result"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.skeleton_dir)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mykatlas:0.6.1--py39h6a678da_6
stdout: mykatlas_walk.out
