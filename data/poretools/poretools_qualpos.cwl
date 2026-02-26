cwlVersion: v1.2
class: CommandLineTool
baseCommand: poretools qualpos
label: poretools_qualpos
doc: "Analyze read quality and position in FAST5 files.\n\nTool homepage: https://github.com/arq5x/poretools"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: The input FAST5 files.
    inputBinding:
      position: 1
  - id: bin_width
    type:
      - 'null'
      - int
    doc: 'The width of bins (default: 1000 bp).'
    default: 1000
    inputBinding:
      position: 102
      prefix: --bin-width
  - id: end_time
    type:
      - 'null'
      - string
    doc: Only analyze reads from before end timestamp
    inputBinding:
      position: 102
      prefix: --end
  - id: high_quality
    type:
      - 'null'
      - boolean
    doc: Only analyze reads with more complement events than template.
    inputBinding:
      position: 102
      prefix: --high-quality
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum read length to be included in analysis.
    inputBinding:
      position: 102
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum read length to be included in analysis.
    inputBinding:
      position: 102
      prefix: --min-length
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 102
      prefix: --quiet
  - id: saveas
    type:
      - 'null'
      - string
    doc: Save the plot to a file named filename.extension (e.g. pdf, jpg)
    inputBinding:
      position: 102
      prefix: --saveas
  - id: start_time
    type:
      - 'null'
      - string
    doc: Only analyze reads from after start timestamp
    inputBinding:
      position: 102
      prefix: --start
  - id: type
    type:
      - 'null'
      - string
    doc: Which type of reads should be analyzed? Def.=all, choices=[all, fwd, 
      rev, 2D, fwd,rev, best]
    inputBinding:
      position: 102
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poretools:0.6.1a0--py27_0
stdout: poretools_qualpos.out
