cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spacerextractor
  - build_database
label: spacerextractor_build_database
doc: "add new repeats identified by CRISPR-Cas typer to the repeat database\n\nTool homepage: https://code.jgi.doe.gov/SRoux/spacerextractor"
inputs:
  - id: input_from_contigs
    type: File
    doc: "A table file listing additional CRISPR array obtained from contigs of this dataset, in the format of CRISPR Cas Typer output crisprs_all.tab, or the output of run_cctyper (all_refined_repeats.tab)"
    inputBinding:
      position: 101
      prefix: --input_from_contigs
  - id: new_db_dir
    type: string
    doc: "Path to the repeat database folder, will be created or overwritten (with option force_rerun)"
    inputBinding:
      position: 101
      prefix: --new_db_dir
  - id: ref_db_dir
    type:
      - 'null'
      - Directory
    doc: "(Optional) Path to the original repeat database folder, to which the new repeats will be added"
    inputBinding:
      position: 101
      prefix: --ref_db_dir
  - id: input_repeat_table
    type:
      - 'null'
      - File
    doc: "Optional. Only needed if building an entire database from scratch the first time"
    inputBinding:
      position: 101
      prefix: --input_repeat_table
  - id: n_threads
    type:
      - 'null'
      - int
    doc: "number of threads to use [default: 2]"
    inputBinding:
      position: 101
      prefix: --n_threads
  - id: bbtools_memory
    type:
      - 'null'
      - string
    doc: "memory allocated to bbtools [default: 20g]"
    inputBinding:
      position: 101
      prefix: --bbtools_memory
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Run in a more verbose mode for debugging / troubleshooting purposes"
    inputBinding:
      position: 101
      prefix: --debug
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Run in a very quiet mode, will only show error/critical messages"
    inputBinding:
      position: 101
      prefix: --quiet
  - id: force_rerun
    type:
      - 'null'
      - boolean
    doc: "If you want to force SpacerExtractor to recompute all the steps"
    inputBinding:
      position: 101
      prefix: --force_rerun
outputs:
  - id: new_db_dir_output
    type: Directory
    doc: "The new repeat database folder"
    outputBinding:
      glob: $(inputs.new_db_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacerextractor:0.9.8--pyhdfd78af_0
