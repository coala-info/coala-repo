cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mantis
  - validate
label: mantis_validate
doc: 'Check a mantis index against the original Squeakr CQF files by querying a set
  of sequences.


  Tool homepage: https://github.com/splatlab/mantis'
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.cqf_files)
inputs:
  - id: input_list
    type: File
    doc: file containing the list of input filters (Squeakr CQF file names, resolved
      from the job directory)
    inputBinding:
      position: 1
      prefix: -i
  - id: cqf_files
    type:
      type: array
      items: File
    doc: Squeakr CQF files named in the input list; they are staged in the job directory
  - id: dbg_prefix
    type: Directory
    doc: Directory containing the mantis dbg
    inputBinding:
      position: 2
      prefix: -p
      valueFrom: $(self.path)/
  - id: query
    type: File
    doc: Query file with one sequence per line
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
stdout: mantis_validate.out
