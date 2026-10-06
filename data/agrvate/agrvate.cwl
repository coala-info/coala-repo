cwlVersion: v1.2
class: CommandLineTool
baseCommand: agrvate
label: agrvate
doc: "Rapid identification of Staphylococcus aureus agr type and agr locus variants
  from assemblies.\n\nTool homepage: https://github.com/VishnuRaghuram94/AgrVATE"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite existing results directory
    inputBinding:
      position: 101
      prefix: --force
  - id: typing_only
    type:
      - 'null'
      - boolean
    doc: Does agr typing only (skips agr operon extraction and frameshift detection)
    inputBinding:
      position: 101
      prefix: --typing-only
  - id: mummer
    type:
      - 'null'
      - boolean
    doc: Uses mummer instead of usearch (May not perform frameshift detection). 
      usearch is not in the bioconda image, so set this unless typing_only is set.
    inputBinding:
      position: 101
      prefix: --mummer
  - id: databases
    type:
      - 'null'
      - Directory
    doc: Path to agrvate_databases (Not required if installed using Conda)
    inputBinding:
      position: 101
      prefix: --databases
  - id: input
    type: File
    doc: Input S. aureus genome in FASTA format
    inputBinding:
      position: 102
      prefix: --input
outputs:
  - id: output_directory
    type: Directory
    doc: Results directory named <input name without extension>-results
    outputBinding:
      glob: $(inputs.input.nameroot)-results
  - id: summary
    type: File
    doc: agr typing summary table
    outputBinding:
      glob: $(inputs.input.nameroot)-results/$(inputs.input.nameroot)-summary.tab
  - id: error_report
    type:
      - 'null'
      - File
    doc: Per-step error report table
    outputBinding:
      glob: $(inputs.input.basename)-error-report.tab
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agrvate:1.0.2--hdfd78af_0
