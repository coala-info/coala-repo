cwlVersion: v1.2
class: CommandLineTool
baseCommand: PePr-preprocess
label: pepr_PePr-preprocess
doc: "Pre-processing and parameter estimation for PePr (Peak-calling and Prioritization
  pipeline for ChIP-seq)\n\nTool homepage: https://github.com/shawnzhangyx/PePr/"
inputs:
  - id: chip1
    type:
      - 'null'
      - type: array
        items: File
    doc: chip1 file names separated by comma
    inputBinding:
      position: 101
      prefix: --chip1
  - id: chip2
    type:
      - 'null'
      - type: array
        items: File
    doc: chip2 file names separated by comma
    inputBinding:
      position: 101
      prefix: --chip2
  - id: diff
    type:
      - 'null'
      - boolean
    doc: Perform differential binding instead of peak-calling
    inputBinding:
      position: 101
      prefix: --diff
  - id: file_format
    type:
      - 'null'
      - string
    doc: bed, sam, bam, sampe, bampe...
    inputBinding:
      position: 101
      prefix: --file-format
  - id: input1
    type:
      - 'null'
      - type: array
        items: File
    doc: input1 file names separated by comma
    inputBinding:
      position: 101
      prefix: --input1
  - id: input2
    type:
      - 'null'
      - type: array
        items: File
    doc: input2 file names separated by comma
    inputBinding:
      position: 101
      prefix: --input2
  - id: input_directory
    type:
      - 'null'
      - Directory
    doc: where the data files are. Absolute path recommended.
    inputBinding:
      position: 101
      prefix: --input-directory
  - id: keep_max_dup
    type:
      - 'null'
      - int
    doc: maximum number of reads to keep at each position. if not specified, will
      not remove any duplicate.
    inputBinding:
      position: 101
      prefix: --keep-max-dup
  - id: name
    type:
      - 'null'
      - string
    doc: the experimental name. NA if none provided
    inputBinding:
      position: 101
      prefix: --name
  - id: normalization
    type:
      - 'null'
      - string
    doc: Normalization method. inter-group, intra-group, scale or no. Must manually
      specify for differential binding analysis.
    inputBinding:
      position: 101
      prefix: --normalization
  - id: num_processors
    type:
      - 'null'
      - int
    doc: number of cores for use.
    inputBinding:
      position: 101
      prefix: --num-processors
  - id: parameter_file
    type:
      - 'null'
      - File
    doc: provide a file that contain the parameters
    inputBinding:
      position: 101
      prefix: --parameter-file
  - id: peaktype
    type:
      - 'null'
      - string
    doc: sharp or broad. Default broad.
    default: broad
    inputBinding:
      position: 101
      prefix: --peaktype
  - id: shiftsize
    type:
      - 'null'
      - int
    doc: Half the fragment size.
    inputBinding:
      position: 101
      prefix: --shiftsize
  - id: threshold
    type:
      - 'null'
      - float
    doc: p-value threshold. Default 1e-5.
    default: 1e-05
    inputBinding:
      position: 101
      prefix: --threshold
  - id: windowsize
    type:
      - 'null'
      - int
    doc: Window sizes
    inputBinding:
      position: 101
      prefix: --windowsize
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: where you want the output files to be
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pepr:1.1.24--py35_0
