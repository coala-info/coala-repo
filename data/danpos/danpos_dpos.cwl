cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - danpos
  - dpos
label: danpos_dpos
doc: "Analyze dynamics of nucleosome positions, including occupancy, position, and
  fuzziness changes.\n\nTool homepage: https://sites.google.com/site/danposdoc/"
inputs:
  - id: input_paths
    type:
      type: array
      items: File
    doc: Input files or directories containing nucleosome positioning data 
      (e.g., .wig, .bam, or .bed files).
    inputBinding:
      position: 1
  - id: distance
    type:
      - 'null'
      - int
    doc: The minimal distance between two nucleosomes.
    inputBinding:
      position: 102
      prefix: --distance
  - id: fdr_threshold
    type:
      - 'null'
      - float
    doc: FDR threshold for calling significant changes.
    inputBinding:
      position: 102
      prefix: --fdr
  - id: m_value_threshold
    type:
      - 'null'
      - float
    doc: M-value threshold for calling significant changes.
    inputBinding:
      position: 102
      prefix: --mvalue
  - id: p_value_threshold
    type:
      - 'null'
      - float
    doc: P-value threshold for calling significant changes.
    inputBinding:
      position: 102
      prefix: --pvalue
  - id: step
    type:
      - 'null'
      - int
    doc: Step size for the analysis.
    inputBinding:
      position: 102
      prefix: --step
  - id: width
    type:
      - 'null'
      - int
    doc: The width of nucleosome occupancy peaks.
    inputBinding:
      position: 102
      prefix: --width
  - id: output_directory_path
    type: Directory
    doc: Output or path parameter `output_directory_path`
    inputBinding:
      position: 103
      prefix: --output-directory
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory for the analysis results.
    outputBinding:
      glob: $(inputs.output_directory_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/danpos:v2.2.2_cv3
