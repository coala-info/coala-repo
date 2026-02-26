cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - qimba
  - merge
label: qimba_merge
doc: "Merge paired end into a single file using USEARCH\n\n  This command generates
  a merged FASTQ file\n\nTool homepage: https://github.com/quadram-institute-bioscience/qimba"
inputs:
  - id: input_samplesheet
    type: File
    doc: Input samplesheet
    inputBinding:
      position: 101
      prefix: --input-samplesheet
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: '4'
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory (overrides config value)
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: Output FASTQ file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qimba:0.4.0--pyhdfd78af_0
