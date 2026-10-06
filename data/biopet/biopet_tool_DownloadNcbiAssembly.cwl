cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - DownloadNcbiAssembly
label: biopet_tool_DownloadNcbiAssembly
doc: "Download the contigs of an NCBI assembly report into one FASTA file.\n\nTool homepage:\
  \ https://github.com/biopet/biopet"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: assembly_report
    type: File
    doc: NCBI assembly report file
    inputBinding:
      position: 101
      prefix: --assembly_report
  - id: output
    type: string
    doc: output Fasta file
    inputBinding:
      position: 101
      prefix: --output
  - id: report
    type:
      - 'null'
      - string
    doc: where to write report from ncbi
    inputBinding:
      position: 101
      prefix: --report
  - id: name_header
    type:
      - 'null'
      - string
    doc: What column to use from the NCBI report for the name of the contigs (e.g. 'Sequence-Name',
      'UCSC-style-name', 'RefSeq-Accn')
    inputBinding:
      position: 101
      prefix: --nameHeader
  - id: must_have_one
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --mustHaveOne
    doc: Filter on the NCBI report as <column_name>=<value>; at least 1 should be true
    inputBinding:
      position: 101
  - id: must_not_have
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --mustNotHave
    doc: Filter on the NCBI report as <column_name>=<value>; all should be false
    inputBinding:
      position: 101
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Level of log information printed. Possible levels: ''debug'', ''info'', ''warn'',
      ''error'''
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: fasta
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: $(inputs.output)
  - id: report_file
    type:
      - 'null'
      - File
    doc: Report from NCBI
    outputBinding:
      glob: '$(inputs.report ? inputs.report : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
