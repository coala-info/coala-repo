cwlVersion: v1.2
class: CommandLineTool
baseCommand: VueGen
label: vuegen
doc: "Please provide a configuration file or directory path:\n\nTool homepage: https://github.com/Multiomics-Analytics-Group/vuegen"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Path to the YAML configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: directory
    type:
      - 'null'
      - Directory
    doc: Path to the directory from which the YAML config will be inferred.
    inputBinding:
      position: 101
      prefix: --directory
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum depth for the recursive search of files in the input directory.
      Ignored if a config file is provided.
    inputBinding:
      position: 101
      prefix: --max_depth
  - id: quarto_checks
    type:
      - 'null'
      - boolean
    doc: Check if Quarto is installed and available for report generation.
    inputBinding:
      position: 101
      prefix: --quarto_checks
  - id: report_type
    type:
      - 'null'
      - string
    doc: 'Type of the report to generate: streamlit, html, pdf, docx, odt, revealjs,
      pptx, or jupyter.'
    inputBinding:
      position: 101
      prefix: --report_type
  - id: streamlit_autorun
    type:
      - 'null'
      - boolean
    doc: Automatically run the Streamlit app after report generation.
    inputBinding:
      position: 101
      prefix: --streamlit_autorun
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to the output directory for the generated report.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vuegen:0.6.0--pyhdfd78af_0
