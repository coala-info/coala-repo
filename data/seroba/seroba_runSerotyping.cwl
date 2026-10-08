cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seroba
  - runSerotyping
label: seroba_runSerotyping
doc: "identify serotype of your input data\n\nTool homepage: https://github.com/sanger-pathogens/seroba"
inputs:
  - id: read1
    type: File
    doc: forward read file
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: read2
    type: File
    doc: backward read file
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: prefix
    type: string
    doc: unique prefix
    inputBinding:
      position: 3
  - id: coverage
    type:
      - 'null'
      - int
    doc: threshold for k-mer coverage of the reference sequence
    inputBinding:
      position: 104
      prefix: --coverage
  - id: databases
    type:
      - 'null'
      - Directory
    doc: path to database directory
    inputBinding:
      position: 104
      prefix: --databases
  - id: noclean
    type:
      - 'null'
      - boolean
    doc: Do not clean up intermediate files (assemblies, ariba report)
    inputBinding:
      position: 104
      prefix: --noclean
outputs:
  - id: output_dir
    type: Directory
    doc: Output folder named after the prefix, holding pred.tsv and the
      detailed results
    outputBinding:
      glob: $(inputs.prefix)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.read1)
      - $(inputs.read2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seroba:1.0.2--pyhdfd78af_1
stdout: seroba_runSerotyping.out
