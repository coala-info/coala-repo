cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - BaseCounter
label: biopet_tool_BaseCounter
doc: "Count bases per gene, transcript and exon from a BAM file and a refFlat annotation.\n\
  \nTool homepage: https://github.com/biopet/biopet"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - '${ return [{"class": "Directory", "basename": inputs.output_dir, "listing": [], "writable":
        true}]; }'
inputs:
  - id: ref_flat
    type: File
    doc: refFlat file. Mandatory
    inputBinding:
      position: 101
      prefix: --refFlat
  - id: output_dir
    type: string
    doc: Output directory. Mandatory
    inputBinding:
      position: 101
      prefix: --outputDir
  - id: bam
    type: File
    doc: Bam file. Mandatory
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 101
      prefix: --bam
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for the output file names
    inputBinding:
      position: 101
      prefix: --prefix
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
  - id: output
    type: Directory
    doc: Output directory with the count files
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
