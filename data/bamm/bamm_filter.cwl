cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamm filter
label: bamm_filter
doc: "Apply stringency filter to Bam file reads\n\nTool homepage: https://github.com/Ecogenomics/BamM"
inputs:
  - id: bamfile
    type: File
    doc: bam file to filter
    inputBinding:
      position: 101
      prefix: --bamfile
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: select unmapped reads
    inputBinding:
      position: 101
      prefix: --invert_match
  - id: length
    type:
      - 'null'
      - int
    doc: minimum allowable query length
    inputBinding:
      position: 101
      prefix: --length
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: mapping quality threshold
    inputBinding:
      position: 101
      prefix: --mapping_quality
  - id: max_distance
    type:
      - 'null'
      - int
    doc: maximum allowable edit distance from query to reference
    inputBinding:
      position: 101
      prefix: --max_distance
  - id: percentage_aln
    type:
      - 'null'
      - float
    doc: minimum fraction of read mapped (between 0 and 1)
    inputBinding:
      position: 101
      prefix: --percentage_aln
  - id: percentage_id
    type:
      - 'null'
      - float
    doc: minimum base identity of mapped region (between 0 and 1)
    inputBinding:
      position: 101
      prefix: --percentage_id
  - id: use_secondary
    type:
      - 'null'
      - boolean
    doc: use reads marked with the secondary flag
    inputBinding:
      position: 101
      prefix: --use_secondary
  - id: use_supplementary
    type:
      - 'null'
      - boolean
    doc: use reads marked with the supplementary flag
    inputBinding:
      position: 101
      prefix: --use_supplementary
  - id: out_folder_path
    type: Directory
    doc: Output or path parameter `out_folder_path`
    inputBinding:
      position: 102
      prefix: --out-folder
outputs:
  - id: out_folder
    type:
      - 'null'
      - Directory
    doc: write to this folder (output file has '_filtered.bam' suffix)
    outputBinding:
      glob: $(inputs.out_folder_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamm:1.7.3--py312hdcc493e_15
