cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - umi-transfer
  - external
label: umi-transfer_external
doc: "Integrate UMIs from a separate FastQ file\n\nTool homepage: https://github.com/SciLifeLab/umi-transfer"
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: 'Choose the compression level: Maximum 9, defaults to 3. Higher numbers result
      in smaller files but take longer to compress.'
    default: 3
    inputBinding:
      position: 101
      prefix: --compression_level
  - id: correct_numbers
    type:
      - 'null'
      - boolean
    doc: Read numbers will be altered to ensure the canonical read numbers 1 and
      2 in output file sequence headers.
    inputBinding:
      position: 101
      prefix: --correct_numbers
  - id: delim
    type:
      - 'null'
      - string
    doc: Delimiter to use when joining the UMIs to the read name. Defaults to 
      `.`.
    default: ':'
    inputBinding:
      position: 101
      prefix: --delim
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing output files without further warnings or prompts.
    inputBinding:
      position: 101
      prefix: --force
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Compress output files. Turned off by default.
    inputBinding:
      position: 101
      prefix: --gzip
  - id: in_r1
    type: File
    doc: Input file 1 with reads.
    inputBinding:
      position: 101
      prefix: --in
  - id: in_r2
    type: File
    doc: Input file 2 with reads.
    inputBinding:
      position: 101
      prefix: --in2
  - id: target_position
    type:
      - 'null'
      - string
    doc: "Choose the target position for the UMI: 'header' or 'inline'. Defaults to
      'header'."
    default: header
    inputBinding:
      position: 101
      prefix: --position
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads to use for processing. Preferably pick odd 
      numbers, 9 or 11 recommended. Defaults to the maximum number of cores 
      available.
    inputBinding:
      position: 101
      prefix: --threads
  - id: umi_in
    type: File
    doc: Input file with UMI.
    inputBinding:
      position: 101
      prefix: --umi
outputs:
  - id: out_r1
    type:
      - 'null'
      - File
    doc: Path to FastQ output file for R1.
    outputBinding:
      glob: $(inputs.out_r1)
  - id: out_r2
    type:
      - 'null'
      - File
    doc: Path to FastQ output file for R2.
    outputBinding:
      glob: $(inputs.out_r2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umi-transfer:1.6.0--hc1c3326_0
