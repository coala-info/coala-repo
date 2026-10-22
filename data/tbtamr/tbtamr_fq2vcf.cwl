cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tbtamr
  - fq2vcf
label: tbtamr_fq2vcf
doc: "Generate an annotated vcf file from paired-end fastq files - NO report generated.\n\nTool homepage: https://github.com/MDU-PHL/tbtamr"
inputs:
  - id: seq_id
    type:
      - 'null'
      - string
    doc: 'Sequence name (default tbtamr). The output folder has this name.'
    inputBinding:
      position: 101
      prefix: --seq_id
  - id: read1
    type:
      - 'null'
      - File
    doc: 'Path to read 1 - not required if vcf is supplied'
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - File
    doc: 'Path to read 2 - not required if vcf is supplied'
    inputBinding:
      position: 101
      prefix: --read2
  - id: min_depth
    type:
      - 'null'
      - int
    doc: 'Minimum depth to call a variant - only required if reads supplied as input (default 20)'
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: min_frac
    type:
      - 'null'
      - float
    doc: 'Minimum proportion to call a variant (0-1) - only required if reads supplied as input (default 0.1)'
    inputBinding:
      position: 101
      prefix: --min_frac
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Threads to use for generation of vcf file (default 8)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: ram
    type:
      - 'null'
      - int
    doc: 'Max ram to use (default 8)'
    inputBinding:
      position: 101
      prefix: --ram
  - id: keep
    type:
      - 'null'
      - boolean
    doc: 'Keep accessory files generated from alignment for further use.'
    inputBinding:
      position: 101
      prefix: --keep
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Force replace an existing folder.'
    inputBinding:
      position: 101
      prefix: --force
  - id: tmp
    type:
      - 'null'
      - string
    doc: 'temp directory to use (default /tmp)'
    inputBinding:
      position: 101
      prefix: --tmp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: result_dir
    type:
      - 'null'
      - Directory
    doc: Output folder named after the sequence id (annotated VCF and logs)
    outputBinding:
      glob: $(inputs.seq_id || 'tbtamr')
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
stdout: tbtamr_fq2vcf.out
