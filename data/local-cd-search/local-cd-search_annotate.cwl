cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - local-cd-search
  - annotate
label: local-cd-search_annotate
doc: "Run the annotation pipeline.\n\nTool homepage: https://github.com/apcamargo/local-cd-search"
inputs:
  - id: input_file
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: db_dir
    type: Directory
    doc: Database directory
    inputBinding:
      position: 2
  - id: data_mode
    type:
      - 'null'
      - string
    doc: Redundancy level of domain hit data passed to rpsbproc. 'rep' (best 
      model per region of the query), 'std' (best model per source per region of
      the query), 'full' (all models meeting E-value significance).
    inputBinding:
      position: 103
      prefix: --data-mode
  - id: evalue
    type:
      - 'null'
      - float
    doc: Maximum allowed E-value for hits.
    inputBinding:
      position: 103
      prefix: --evalue
  - id: include_generic_site
    type:
      - 'null'
      - boolean
    doc: Include generic site hits in the output sites table.
    inputBinding:
      position: 103
      prefix: --gs
  - id: include_non_specific
    type:
      - 'null'
      - boolean
    doc: Include non-specific hits in the output results table.
    inputBinding:
      position: 103
      prefix: --ns
  - id: include_superfamily
    type:
      - 'null'
      - boolean
    doc: Include superfamily hits in the output results table.
    inputBinding:
      position: 103
      prefix: --sf
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress non-error console output.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for rpsblast.
    inputBinding:
      position: 103
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to store intermediate files. If not specified, temporary 
      files will be deleted after execution.
    inputBinding:
      position: 103
      prefix: --tmp-dir
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
  - id: sites_output
    type:
      - 'null'
      - File
    doc: Path to write functional site annotations.
    outputBinding:
      glob: $(inputs.sites_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/local-cd-search:0.3.1--pyhdfd78af_0
