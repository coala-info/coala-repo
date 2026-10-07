cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - run_dbcan
  - cgc_finder
label: dbcan_cgc_finder
doc: "identify CAZyme Gene Clusters(CGCs)\n\nTool homepage: http://bcb.unl.edu/dbCAN2/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - |-
        ${ if (inputs.input_dir) { return [{"entry": inputs.input_dir, "entryname": inputs.output_dir, "writable": true}]; } return []; }
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable verbose logging (equivalent to --log-level DEBUG)"
    inputBinding:
      position: 102
      prefix: --verbose
  - id: log_file
    type:
      - 'null'
      - string
    doc: "Write logs to file in addition to console"
    inputBinding:
      position: 102
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Set logging level (default: WARNING, only shows warnings and errors) (one of DEBUG, INFO, WARNING, ERROR, CRITICAL)"
    inputBinding:
      position: 102
      prefix: --log-level
  - id: output_dir
    type: string
    doc: "Directory for the output files [required]"
    inputBinding:
      position: 102
      prefix: --output_dir
  - id: feature_type
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --feature_type
    doc: "GFF feature types to include (multiple allowed)."
    inputBinding:
      position: 102
  - id: min_cluster_genes
    type:
      - 'null'
      - int
    doc: "Minimum number of genes required per CGC."
    inputBinding:
      position: 102
      prefix: --min_cluster_genes
  - id: min_core_cazyme
    type:
      - 'null'
      - int
    doc: "Minimum number of core CAZymes required per CGC."
    inputBinding:
      position: 102
      prefix: --min_core_cazyme
  - id: extend_gene_count
    type:
      - 'null'
      - int
    doc: "When --extend_mode=gene, extend this many genes on each side."
    inputBinding:
      position: 102
      prefix: --extend_gene_count
  - id: extend_bp
    type:
      - 'null'
      - int
    doc: "When --extend_mode=bp, extend this many base pairs on each side."
    inputBinding:
      position: 102
      prefix: --extend_bp
  - id: extend_mode
    type:
      - 'null'
      - string
    doc: "Extend CGC region on both sides after identification. 'bp' extends by base pairs; 'gene' extends by gene count; 'none' disables extension. (one of none, bp, gene)"
    inputBinding:
      position: 102
      prefix: --extend_mode
  - id: use_distance
    type:
      - 'null'
      - boolean
    doc: "Use base pair distance in CGC annotation."
    inputBinding:
      position: 102
      prefix: --use_distance
  - id: use_null_genes
    type:
      - 'null'
      - boolean
    doc: "Use null genes in CGC annotation."
    inputBinding:
      position: 102
      prefix: --use_null_genes
  - id: no_use_null_genes
    type:
      - 'null'
      - boolean
    doc: "Turn off: Use null genes in CGC annotation."
    inputBinding:
      position: 102
      prefix: --no-use_null_genes
  - id: base_pair_distance
    type:
      - 'null'
      - int
    doc: "Base pair distance of signature genes."
    inputBinding:
      position: 102
      prefix: --base_pair_distance
  - id: num_null_gene
    type:
      - 'null'
      - int
    doc: "Maximum number of null genes allowed between signature genes."
    inputBinding:
      position: 102
      prefix: --num_null_gene
  - id: additional_min_categories
    type:
      - 'null'
      - int
    doc: "When --additional_logic=any, require at least this number of distinct additional categories."
    inputBinding:
      position: 102
      prefix: --additional_min_categories
  - id: additional_logic
    type:
      - 'null'
      - string
    doc: "Logic for multiple --additional_genes: 'all' requires all present; 'any' requires at least one. (one of all, any)"
    inputBinding:
      position: 102
      prefix: --additional_logic
  - id: additional_genes
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --additional_genes
    doc: "Specify additional gene types for CGC annotation, including TC, TF, and STP"
    inputBinding:
      position: 102
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: "Results folder of an earlier run_dbcan step; it is copied (writable) to --output_dir so this step can read and add to it"
outputs:
  - id: output
    type: Directory
    doc: Output folder
    outputBinding:
      glob: $(inputs.output_dir)
  - id: log_output
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbcan:5.2.8--pyhdfd78af_0
