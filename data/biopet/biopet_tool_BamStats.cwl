cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - BamStats
label: biopet_tool_BamStats
doc: "Generate statistics (flagstat, insert size, mapping quality, clipping) from a BAM file.\n\
  \nTool homepage: https://github.com/biopet/biopet"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - '${ return [{"class": "Directory", "basename": inputs.output_dir, "listing": [], "writable":
        true}]; }'
inputs:
  - id: reference
    type:
      - 'null'
      - File
    doc: Fasta file of reference
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
    inputBinding:
      position: 101
      prefix: --reference
  - id: output_dir
    type: string
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outputDir
  - id: bam
    type: File
    doc: Input bam file
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 101
      prefix: --bam
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Bin size of stats (beta)
    inputBinding:
      position: 101
      prefix: --binSize
  - id: thread_bin_size
    type:
      - 'null'
      - int
    doc: Size of region per thread
    inputBinding:
      position: 101
      prefix: --threadBinSize
  - id: tsv_outputs
    type:
      - 'null'
      - boolean
    doc: Also output tsv files, default there is only a json
    inputBinding:
      position: 101
      prefix: --tsvOutputs
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
    doc: Output directory with bamstats.json and bamstats.summary.json
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
