cwlVersion: v1.2
class: CommandLineTool
baseCommand: pydownsampler
label: pydownsampler
doc: "Downsample a BAM/SAM/CRAM file to a desired average coverage, or print the\
  \ average coverage of the file.\n\nTool homepage: https://github.com/LindoNkambule/pydownsampler"
inputs:
  - id: input_file
    type: File
    doc: BAM/SAM/CRAM file to be downsampled (Required argument)
    inputBinding:
      position: 1
    secondaryFiles:
      - pattern: .bai
        required: true
  - id: downcoverage
    type:
      - 'null'
      - int
    doc: The coverage you want to downsample to (Required argument for downsampling)
    inputBinding:
      position: 2
      prefix: -d
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output filename prefix (Optional); .bam is appended
    inputBinding:
      position: 3
      prefix: -o
  - id: coverage
    type:
      - 'null'
      - boolean
    doc: Print out average coverage for file
    inputBinding:
      position: 2
      prefix: -c
outputs:
  - id: downsampled
    type:
      - 'null'
      - File
    doc: Downsampled BAM file
    outputBinding:
      glob: '*.bam'
  - id: stdout
    type: stdout
    doc: Messages printed by the tool (average coverage, downsampling fraction)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydownsampler:1.0--py_0
stdout: pydownsampler.out
