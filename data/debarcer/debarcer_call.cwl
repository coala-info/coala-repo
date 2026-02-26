cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - debarcer.py
  - call
label: debarcer_call
doc: "Call variants based on consensus files and thresholds.\n\nTool homepage: https://github.com/oicr-gsi/debarcer"
inputs:
  - id: consensus_files
    type:
      type: array
      items: File
    doc: List of consensus files
    inputBinding:
      position: 1
  - id: alt_threshold
    type:
      - 'null'
      - float
    doc: 'Minimum allele frequency (in percent) to consider an alternative allele
      at a variable position (ie. allele freq >= alt_threshold and ref freq <= ref_threshold:
      alternative allele)'
    inputBinding:
      position: 102
      prefix: --AlternativeThreshold
  - id: config
    type:
      - 'null'
      - string
    doc: Path to the config file
    inputBinding:
      position: 102
      prefix: --Config
  - id: famsize
    type: int
    doc: Minimum UMI family size
    inputBinding:
      position: 102
      prefix: --Famsize
  - id: filter_threshold
    type:
      - 'null'
      - int
    doc: Minimum number of reads to pass alternative variants (ie. filter = PASS
      if variant depth >= alt_threshold)
    inputBinding:
      position: 102
      prefix: --FilterThreshold
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory where subdirectories are created
    inputBinding:
      position: 102
      prefix: --Outdir
  - id: ref_threshold
    type:
      - 'null'
      - float
    doc: Maximum reference frequency to consider (in percent) alternative 
      variants (ie. position with ref freq <= ref_threshold is considered 
      variable)
    inputBinding:
      position: 102
      prefix: --RefThreshold
  - id: reference
    type: File
    doc: Path to the refeence genome
    inputBinding:
      position: 102
      prefix: --Reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/debarcer:2.1.4--pyhdfd78af_2
stdout: debarcer_call.out
