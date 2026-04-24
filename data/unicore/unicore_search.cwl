cwlVersion: v1.2
class: CommandLineTool
baseCommand: unicore_search
label: unicore_search
doc: "Search Foldseek database against reference database\n\nTool homepage: https://github.com/steineggerlab/unicore"
inputs:
  - id: input
    type: File
    doc: Input database
    inputBinding:
      position: 1
  - id: target
    type: File
    doc: Target database to search against
    inputBinding:
      position: 2
  - id: output_prefix
    type: string
    doc: Output prefix; the result will be saved as OUTPUT.m8
    inputBinding:
      position: 3
  - id: tmp_dir
    type: Directory
    doc: Temp directory
    inputBinding:
      position: 4
  - id: keep_aln_db
    type:
      - 'null'
      - boolean
    doc: Keep intermediate Foldseek alignment database
    inputBinding:
      position: 105
      prefix: --keep-aln-db
  - id: search_options
    type:
      - 'null'
      - string
    doc: Arguments for foldseek options in string e.g. -s "-c 0.8"
    inputBinding:
      position: 105
      prefix: --search-options
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use; 0 to use all
    inputBinding:
      position: 105
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug)'
    inputBinding:
      position: 105
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
stdout: unicore_search.out
