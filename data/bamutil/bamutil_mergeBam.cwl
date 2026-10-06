cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - mergeBam
label: bamutil_mergeBam
doc: "merge multiple BAMs and headers appending ReadGroupIDs if necessary\n\nTool\
  \ homepage: http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: out
    type: string
    doc: Output BAM file (sorted)
    inputBinding:
      position: 1
      prefix: --out
  - id: in
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --in
    doc: BAM file to be input, must be more than one of these options; cannot be used
      with --list
    inputBinding:
      position: 1
  - id: list
    type:
      - 'null'
      - File
    doc: RGAList File. Tab-delimited list with headers (BAM, ID, SM required; LB,
      DS, PU, PI, CN, DT, PL optional)
    inputBinding:
      position: 1
      prefix: --list
  - id: list_bams
    type:
      - 'null'
      - type: array
        items: File
    doc: BAM files named in the --list file (staged into the working directory so
      the names resolve)
  - id: regions
    type:
      - 'null'
      - string
    doc: list of intervals, '<chr>:<start>-<end>', to merge separated by commas
    inputBinding:
      position: 1
      prefix: --regions
  - id: region_file
    type:
      - 'null'
      - File
    doc: file containing list of intervals, '<chr>:<start>-<end>', to merge, one per
      line
    inputBinding:
      position: 1
      prefix: --regionFile
  - id: ignore_pi
    type:
      - 'null'
      - boolean
    doc: Ignore the RG PI field when comparing headers
    inputBinding:
      position: 1
      prefix: --ignorePI
  - id: log
    type:
      - 'null'
      - string
    doc: Log file
    inputBinding:
      position: 1
      prefix: --log
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on verbose mode
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Merged BAM file
    outputBinding:
      glob: $(inputs.out)
  - id: log_file
    type: File?
    doc: Log file
    outputBinding:
      glob: '$(inputs.log ? inputs.log : ''_none_'')'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '${ return inputs.list_bams ? inputs.list_bams : []; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
