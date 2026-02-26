cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dysgu
  - merge
label: dysgu_merge
doc: "Merge vcf/csv variant files\n\nTool homepage: https://github.com/kcleal/dysgu"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input variant files
    inputBinding:
      position: 1
  - id: add_kind
    type:
      - 'null'
      - boolean
    doc: Add region-overlap 'kind' to vcf output
    default: false
    inputBinding:
      position: 102
      prefix: --add-kind
  - id: clean
    type:
      - 'null'
      - boolean
    doc: Remove working directory when finished
    inputBinding:
      position: 102
      prefix: --clean
  - id: cohort_update
    type:
      - 'null'
      - File
    doc: Updated this cohort file with new calls from input_files
    inputBinding:
      position: 102
      prefix: --cohort-update
  - id: collapse_nearby
    type:
      - 'null'
      - boolean
    doc: Merges more aggressively by collapsing nearby SV
    default: true
    inputBinding:
      position: 102
      prefix: --collapse-nearby
  - id: input_list
    type:
      - 'null'
      - File
    doc: Input list of file paths, one line per file
    inputBinding:
      position: 102
      prefix: --input-list
  - id: max_comparisons
    type:
      - 'null'
      - int
    doc: Compare each event with up to --max-comparisons local SVs
    default: 20
    inputBinding:
      position: 102
      prefix: --max-comparisons
  - id: merge_across
    type:
      - 'null'
      - boolean
    doc: Merge records across input samples
    default: true
    inputBinding:
      position: 102
      prefix: --merge-across
  - id: merge_dist
    type:
      - 'null'
      - int
    doc: Distance threshold for merging
    default: 500
    inputBinding:
      position: 102
      prefix: --merge-dist
  - id: merge_method
    type:
      - 'null'
      - string
    doc: Method of merging using --merge-across. Progressive is suitable for 
      large cohorts. Auto will switch to progressive for >4 samples
    default: auto
    inputBinding:
      position: 102
      prefix: --merge-method
  - id: merge_within
    type:
      - 'null'
      - boolean
    doc: Perform additional merge within input samples, prior to --merge-across
    default: false
    inputBinding:
      position: 102
      prefix: --merge-within
  - id: out_format
    type:
      - 'null'
      - string
    doc: Output format
    default: vcf
    inputBinding:
      position: 102
      prefix: --out-format
  - id: post_fix
    type:
      - 'null'
      - string
    doc: Adds --post-fix to file names, only if --separate is True
    default: dysgu
    inputBinding:
      position: 102
      prefix: --post-fix
  - id: procs
    type:
      - 'null'
      - int
    doc: Number of processors to use when merging, requires --wd option to be 
      supplied
    default: 1
    inputBinding:
      position: 102
      prefix: --procs
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Prints detailed progress information
    inputBinding:
      position: 102
      prefix: --progress
  - id: separate
    type:
      - 'null'
      - boolean
    doc: Keep merged tables separate, adds --post-fix to file names, csv format 
      only
    default: false
    inputBinding:
      position: 102
      prefix: --separate
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 0 = no contigs in output, 1 = output contigs for variants without ALT 
      sequence called, 2 = output all contigs
    default: 1
    inputBinding:
      position: 102
      prefix: --verbosity
  - id: wd
    type:
      - 'null'
      - Directory
    doc: Working directory to use/create when merging
    inputBinding:
      position: 102
      prefix: --wd
outputs:
  - id: svs_out
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.svs_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dysgu:1.8.7--py311h8ddd9a4_0
