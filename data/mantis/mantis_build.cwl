cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mantis
  - build
label: mantis_build
doc: 'Build a colored de Bruijn graph index (mantis index) from a collection of Squeakr
  counting quotient filter (CQF) files.


  Tool homepage: https://github.com/splatlab/mantis'
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.cqf_files)
inputs:
  - id: eqclass_dist
    type:
      - 'null'
      - boolean
    doc: write the eqclass abundance distribution
    inputBinding:
      position: 1
      prefix: -e
  - id: log_slots
    type: int
    doc: log of number of slots in the output CQF
    inputBinding:
      position: 2
      prefix: -s
  - id: input_list
    type: File
    doc: file containing the list of input filters (one Squeakr CQF file name per
      line, resolved from the job directory)
    inputBinding:
      position: 3
      prefix: -i
  - id: cqf_files
    type:
      type: array
      items: File
    doc: Squeakr CQF files named in the input list; they are staged in the job directory
  - id: build_output
    type: string
    doc: directory where results should be written
    inputBinding:
      position: 4
      prefix: -o
outputs:
  - id: index_dir
    type: Directory
    doc: Mantis index directory
    outputBinding:
      glob: $(inputs.build_output)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
stdout: mantis_build.out
