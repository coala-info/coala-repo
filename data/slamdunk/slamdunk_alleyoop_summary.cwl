cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alleyoop
  - summary
label: slamdunk_alleyoop_summary
doc: "Display summary information and statistics on read numbers\n\nTool homepage: http://t-neumann.github.io/slamdunk"
inputs:
  - id: bam
    type:
      type: array
      items: File
    doc: 'Filtered BAM files (produced by slamdunk filter or all)'
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 100
  - id: tcount_dir
    type: ['null', Directory]
    doc: 'Folder containing tcount files'
    inputBinding:
      position: 1
      prefix: --tcountDir
  - id: output_file
    type: string
    default: summary_out.tsv
    doc: Output file
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slamdunk:0.4.3--py_0
