cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytximport
label: pytximport
doc: "Call the tximport function via the command line.\n\nTool homepage: https://pytximport.readthedocs.io/en/latest/start.html"
inputs:
  - id: abundance_column
    type:
      - 'null'
      - string
    doc: The column name for the abundance.
    inputBinding:
      position: 101
      prefix: --abundance-column
  - id: counts_column
    type:
      - 'null'
      - string
    doc: The column name for the counts.
    inputBinding:
      position: 101
      prefix: --counts-column
  - id: counts_from_abundance
    type:
      - 'null'
      - string
    doc: The method to calculate the counts from the abundance. Leave empty to 
      use counts. For differential gene expression analysis, we recommend using 
      `length_scaled_tpm`. For differential transcript expression analysis, we 
      recommend using `scaled_tpm`. For differential isoform usage analysis, we 
      recommend using `dtu_scaled_tpm`.
    inputBinding:
      position: 101
      prefix: --counts-from-abundance
  - id: data_type
    type: string
    doc: The type of quantification files.
    inputBinding:
      position: 101
      prefix: --data-type
  - id: existence_optional
    type:
      - 'null'
      - boolean
    doc: Whether the existence of the files is optional.
    inputBinding:
      position: 101
      prefix: --existence-optional
  - id: file_paths
    type:
      type: array
      items: File
    doc: The path to an quantification file. To provide multiple input files, 
      use `-i input1.sf -i input2.sf ...`.
    inputBinding:
      position: 101
      prefix: --file-paths
  - id: gene_level
    type:
      - 'null'
      - boolean
    doc: Provide this flag when importing gene-level counts from RSEM files.
    inputBinding:
      position: 101
      prefix: --gene-level
  - id: id_column
    type:
      - 'null'
      - string
    doc: The column name for the transcript id.
    inputBinding:
      position: 101
      prefix: --id-column
  - id: ignore_after_bar
    type:
      - 'null'
      - boolean
    doc: Whether to split the transcript id after the bar character (`|`).
    inputBinding:
      position: 101
      prefix: --ignore-after-bar
  - id: ignore_transcript_version
    type:
      - 'null'
      - boolean
    doc: Whether to ignore the transcript version.
    inputBinding:
      position: 101
      prefix: --ignore-transcript-version
  - id: inferential_replicates
    type:
      - 'null'
      - boolean
    doc: Provide this flag to make use of inferential replicates. Will use the 
      median of the inferential replicates.
    inputBinding:
      position: 101
      prefix: --inferential-replicates
  - id: length_column
    type:
      - 'null'
      - string
    doc: The column name for the length.
    inputBinding:
      position: 101
      prefix: --length-column
  - id: output_format
    type:
      - 'null'
      - string
    doc: The format of the output file.
    inputBinding:
      position: 101
      prefix: --output-format
  - id: output_path_overwrite
    type:
      - 'null'
      - boolean
    doc: Provide this flag to overwrite an existing file at the output path.
    inputBinding:
      position: 101
      prefix: --save-path-overwrite
  - id: return_transcript_data
    type:
      - 'null'
      - boolean
    doc: Provide this flag to return transcript-level instead of gene-summarized
      data. Incompatible with gene-level input and 
      `counts_from_abundance=length_scaled_tpm`.
    inputBinding:
      position: 101
      prefix: --return-transcript-data
  - id: transcript_gene_map
    type:
      - 'null'
      - File
    doc: The path to the transcript to gene map. Either a tab-separated (.tsv) 
      or comma-separated (.csv) file. Expected column names are `transcript_id` 
      and `gene_id`.
    inputBinding:
      position: 101
      prefix: --transcript-gene-map
outputs:
  - id: output_path
    type: Directory
    doc: The output path to save the resulting counts to.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytximport:0.12.0--pyhdfd78af_0
