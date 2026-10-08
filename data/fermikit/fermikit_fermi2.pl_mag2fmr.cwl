cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fermi2.pl
  - mag2fmr
label: fermikit_fermi2.pl_mag2fmr
doc: "Generate a Makefile that creates an FMR index for one or more MAG unitig assemblies.\
  \n\nTool homepage: https://github.com/lh3/fermikit"
inputs:
  - id: mag_files
    type:
      type: array
      items: File
    doc: MAG unitig assemblies (file1.mag.gz ...)
    inputBinding:
      position: 201
  - id: all_unitigs
    type:
      - 'null'
      - boolean
    doc: use all unitigs without the length and coverage filtering
    inputBinding:
      position: 101
      prefix: -a
  - id: input_fmr
    type:
      - 'null'
      - string
    doc: existing FMR index to extend (its name is written into the Makefile)
    inputBinding:
      position: 101
      prefix: -i
  - id: min_length
    type:
      - 'null'
      - int
    doc: minimum unitig length
    inputBinding:
      position: 101
      prefix: -l
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: mask unitig bases covered by fewer than INT reads
    inputBinding:
      position: 101
      prefix: -d
  - id: max_memory
    type:
      - 'null'
      - int
    doc: ropebwt2 -M value
    inputBinding:
      position: 101
      prefix: -M
outputs:
  - id: makefile
    type: stdout
    doc: Makefile that builds the FMR index
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermikit:0.14.dev1--pl5321h86e5fe9_2
stdout: fermikit_fermi2.pl_mag2fmr.out
