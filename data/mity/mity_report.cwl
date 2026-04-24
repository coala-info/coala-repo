cwlVersion: v1.2
class: CommandLineTool
baseCommand: mity report
label: mity_report
doc: "Create a report from mity VCF files.\n\nTool homepage: https://github.com/KCCG/mity"
inputs:
  - id: vcf
    type:
      type: array
      items: File
    doc: mity vcf files to create a report from
    inputBinding:
      position: 1
  - id: contig
    type:
      - 'null'
      - string
    doc: Contig used for annotation purposes
    inputBinding:
      position: 102
      prefix: --contig
  - id: custom_report_config
    type:
      - 'null'
      - File
    doc: Provide a custom report-config.yaml for custom report generation.
    inputBinding:
      position: 102
      prefix: --custom-report-config
  - id: custom_vcfanno_config
    type:
      - 'null'
      - File
    doc: Provide a custom vcfanno-config.toml for custom annotations.
    inputBinding:
      position: 102
      prefix: --custom-vcfanno-config
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enter debug mode
    inputBinding:
      position: 102
      prefix: --debug
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep all intermediate files
    inputBinding:
      position: 102
      prefix: --keep
  - id: min_vaf
    type:
      - 'null'
      - float
    doc: A variant must have at least this VAF to be included in the report.
    inputBinding:
      position: 102
      prefix: --min_vaf
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output files will be saved in OUTPUT_DIR.
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output files will be named with PREFIX
    inputBinding:
      position: 102
      prefix: --prefix
  - id: vcfanno_base_path
    type:
      - 'null'
      - Directory
    doc: Path to the custom annotations used for vcfanno. Only required if using
      custom annotations.
    inputBinding:
      position: 102
      prefix: --vcfanno-base-path
outputs:
  - id: output_annotated_vcf
    type:
      - 'null'
      - File
    doc: Output annotated vcf file
    outputBinding:
      glob: $(inputs.output_annotated_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mity:2.0.1--pyhdfd78af_0
