cwlVersion: v1.2
class: CommandLineTool
baseCommand: genmod_sort
label: genmod_sort
doc: "Sort a VCF file based on rank score.\n\nTool homepage: http://github.com/moonso/genmod"
inputs:
  - id: vcf_file
    type: File
    doc: VCF file to sort
    inputBinding:
      position: 1
  - id: family_id
    type:
      - 'null'
      - string
    doc: Specify the family id for sorting.
    inputBinding:
      position: 102
      prefix: --family_id
  - id: position
    type:
      - 'null'
      - boolean
    doc: If variants should be sorted by position.
    inputBinding:
      position: 102
      prefix: -p
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Do not print the variants.
    inputBinding:
      position: 102
      prefix: --silent
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Path to tempdir
    inputBinding:
      position: 102
      prefix: --temp_dir
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Specify the path to a file where results should be stored.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genmod:3.10.2--pyh7e72e81_0
