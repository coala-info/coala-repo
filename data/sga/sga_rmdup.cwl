cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - rmdup
label: sga_rmdup
doc: "Remove duplicate reads from the data set.\n\nTool homepage: https://github.com/jts/sga"
inputs:
  - id: readfile
    type: File
    doc: Input read file
    inputBinding:
      position: 1
  - id: error_rate
    type:
      - 'null'
      - float
    doc: the maximum error rate allowed to consider two sequences identical
    inputBinding:
      position: 102
      prefix: --error-rate
  - id: prefix
    type:
      - 'null'
      - string
    doc: use PREFIX instead of the prefix of the reads filename for the 
      input/output files
    inputBinding:
      position: 102
      prefix: --prefix
  - id: sample_rate
    type:
      - 'null'
      - int
    doc: sample the symbol counts every N symbols in the FM-index. Higher values
      use significantly less memory at the cost of higher runtime. This value 
      must be a power of 2
    default: 256
    inputBinding:
      position: 102
      prefix: --sample-rate
  - id: threads
    type:
      - 'null'
      - int
    doc: use N threads
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write the output to FILE
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
