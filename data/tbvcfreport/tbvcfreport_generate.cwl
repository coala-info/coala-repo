cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tbvcfreport
  - generate
label: tbvcfreport_generate
doc: "Generate an interactive HTML-based VCF report.\n\nTool homepage: http://github.com/COMBAT-TB/tbvcfreport"
inputs:
  - id: vcf_dir
    type: Directory
    doc: Directory containing VCF files
    inputBinding:
      position: 1
  - id: db_url
    type:
      - 'null'
      - string
    doc: URL to connect to COMBAT TB eXplorer NeoDB
    inputBinding:
      position: 102
      prefix: --db_url
  - id: filter_udi
    type:
      - 'null'
      - boolean
    doc: Filter upstream, downstream and intergenic variants.
    inputBinding:
      position: 102
      prefix: --filter-udi
  - id: no_filter_udi
    type:
      - 'null'
      - boolean
    doc: Do not filter upstream, downstream and intergenic variants.
    inputBinding:
      position: 102
      prefix: --no-filter-udi
  - id: tbprofiler_report
    type:
      - 'null'
      - File
    doc: TBProfiler json report.
    inputBinding:
      position: 102
      prefix: --tbprofiler-report
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbvcfreport:1.0.1--pyhdfd78af_0
stdout: tbvcfreport_generate.out
