cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - reports.py
  - assembly_stats
label: viral-ngs_reports_assembly_stats
doc: "Fetch assembly-level statistics for a given sample\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: samples
    type:
      type: array
      items: string
    doc: "Sample names."
    inputBinding:
      position: 1
  - id: out_file
    type: string
    doc: "Output report file."
    inputBinding:
      position: 2
  - id: cov_thresholds
    type:
      - 'null'
      - type: array
        items: int
    doc: "Genome coverage thresholds to report on. (default: (1, 5, 20, 100))"
    inputBinding:
      position: 20
      prefix: --cov_thresholds
  - id: assembly_dir
    type:
      - 'null'
      - Directory
    doc: "Directory with assembly outputs. (default: data/02_assembly)"
    inputBinding:
      position: 20
      prefix: --assembly_dir
  - id: assembly_tmp
    type:
      - 'null'
      - Directory
    doc: "Directory with assembly temp files. (default: tmp/02_assembly)"
    inputBinding:
      position: 20
      prefix: --assembly_tmp
  - id: align_dir
    type:
      - 'null'
      - Directory
    doc: "Directory with reads aligned to own assembly. (default: data/02_align_to_self)"
    inputBinding:
      position: 20
      prefix: --align_dir
  - id: reads_dir
    type:
      - 'null'
      - Directory
    doc: "Directory with unaligned filtered read BAMs. (default: data/01_per_sample)"
    inputBinding:
      position: 20
      prefix: --reads_dir
  - id: raw_reads_dir
    type:
      - 'null'
      - Directory
    doc: "Directory with unaligned raw read BAMs. (default: data/00_raw)"
    inputBinding:
      position: 20
      prefix: --raw_reads_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_file_out
    type: File
    doc: "Output report file"
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_reports_assembly_stats.out
