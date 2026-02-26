cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylpy
  - add-methylation-level
label: methylpy_add-methylation-level
doc: "Add methylation level information to genomic intervals in a TSV file using ALLC
  files.\n\nTool homepage: https://github.com/yupenghe/methylpy"
inputs:
  - id: allc_files
    type:
      type: array
      items: File
    doc: List of allc files.
    inputBinding:
      position: 101
      prefix: --allc-files
  - id: buffer_line_number
    type:
      - 'null'
      - int
    doc: size of buffer for reads to be written on hard drive.
    default: 100000
    inputBinding:
      position: 101
      prefix: --buffer-line-number
  - id: extra_info
    type:
      - 'null'
      - boolean
    doc: Boolean to indicate whether to generate two output extra files with the
      total basecalls and covered sites in each of the regions.
    default: false
    inputBinding:
      position: 101
      prefix: --extra-info
  - id: input_no_header
    type:
      - 'null'
      - boolean
    doc: Indicating whether input tsv file contains a header. If this is set to 
      True, a header will be automatically generated in the output file.
    default: false
    inputBinding:
      position: 101
      prefix: --input-no-header
  - id: input_tsv_file
    type: File
    doc: A tab-separate file that specifies genomic intervals. The file contains
      a header. First three columns are required to be chromosome, start and 
      end, which are 1-based coordinates.
    inputBinding:
      position: 101
      prefix: --input-tsv-file
  - id: max_cov
    type:
      - 'null'
      - int
    doc: Maximum coverage for a site to be included. By default this cutoff is 
      not applied.
    inputBinding:
      position: 101
      prefix: --max-cov
  - id: mc_type
    type:
      - 'null'
      - type: array
        items: string
    doc: List of space separated mc nucleotide contexts for which you want to 
      look for DMRs. These classifications may use the wildcards H (indicating 
      anything but a G) and N (indicating any nucleotide).
    default:
      - CGN
    inputBinding:
      position: 101
      prefix: --mc-type
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum coverage for a site to be included
    default: 0
    inputBinding:
      position: 101
      prefix: --min-cov
  - id: num_procs
    type:
      - 'null'
      - int
    doc: Number of processors you wish to use to parallelize this function
    default: 1
    inputBinding:
      position: 101
      prefix: --num-procs
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: List of space separated samples matching allc files. By default sample 
      names will be inferred from allc filenames
    inputBinding:
      position: 101
      prefix: --samples
outputs:
  - id: output_file
    type: File
    doc: Name of output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
