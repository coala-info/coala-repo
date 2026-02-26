cwlVersion: v1.2
class: CommandLineTool
baseCommand: vtools-gcoverage
label: vtools_vtools-gcoverage
doc: "Collect coverage metrics from VCF files.\n\nTool homepage: https://github.com/LUMC/vtools"
inputs:
  - id: input_gvcf
    type: File
    doc: Path to input VCF file
    inputBinding:
      position: 101
      prefix: --input-gvcf
  - id: per_exon
    type:
      - 'null'
      - boolean
    doc: Collect metrics per exon
    inputBinding:
      position: 101
      prefix: --per-exon
  - id: per_transcript
    type:
      - 'null'
      - boolean
    doc: Collect metrics per transcript
    inputBinding:
      position: 101
      prefix: --per-transcript
  - id: refflat_file
    type: File
    doc: Path to refFlat file
    inputBinding:
      position: 101
      prefix: --refflat-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vtools:1.1.0--py311h93dcfea_7
stdout: vtools_vtools-gcoverage.out
