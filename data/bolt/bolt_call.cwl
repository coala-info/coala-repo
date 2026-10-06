cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bolt
  - call
label: bolt_call
doc: "Call variants using the BOLT tool\n\nTool homepage: https://github.com/sakkayaphab/bolt"
inputs:
  - id: reference_file
    type: File
    doc: reference file path (FASTA with .fai index)
    secondaryFiles:
      - .fai
    inputBinding:
      position: 101
      prefix: -r
  - id: sample_file
    type: File
    doc: sample file path (sorted, indexed BAM)
    secondaryFiles:
      - .bai
    inputBinding:
      position: 101
      prefix: -b
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: -t
  - id: output_path_path
    type: string
    doc: output folder path (*required)
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_path
    type: Directory
    doc: output folder (result.vcf and the analysis folder)
    outputBinding:
      glob: $(inputs.output_path_path)
  - id: result_vcf
    type: File
    doc: called structural variants
    outputBinding:
      glob: $(inputs.output_path_path)/result.vcf
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bolt:0.3.0--h3889886_0
