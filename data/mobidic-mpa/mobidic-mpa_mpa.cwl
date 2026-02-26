cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpa
label: mobidic-mpa_mpa
doc: "Annotate VCF with Mobidic Prioritization Algorithm score (MPA).\n\nTool homepage:
  https://neuro-2.iurc.montp.inserm.fr/mpaweb/"
inputs:
  - id: input
    type: File
    doc: 'The vcf file to annotate (format: VCF). This vcf must be annotate with annovar.'
    inputBinding:
      position: 101
      prefix: --input
  - id: logging_level
    type:
      - 'null'
      - string
    doc: The logger level.
    default: INFO
    inputBinding:
      position: 101
      prefix: --logging-level
  - id: mpa_directory
    type:
      - 'null'
      - Directory
    doc: The path to the MPA installation folder.
    default: /usr/local/bin
    inputBinding:
      position: 101
      prefix: --mpa-directory
  - id: no_progress_bar
    type:
      - 'null'
      - boolean
    doc: Disable progress bar (avoid to read vcf twice for large vcf).
    inputBinding:
      position: 101
      prefix: --no-progress-bar
  - id: no_refseq_version
    type:
      - 'null'
      - boolean
    doc: Annotation without using refseq version with annovar.
    inputBinding:
      position: 101
      prefix: --no-refseq-version
outputs:
  - id: output
    type: File
    doc: 'The output vcf file with annotation (format : VCF)'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mobidic-mpa:1.3.0--pyh5e36f6f_0
