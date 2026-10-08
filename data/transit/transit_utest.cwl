cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transit
  - utest
label: transit_utest
doc: "Mann-Whitney U-test for conditional essentiality between a control and an experimental condition.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: control_files
    type: File[]
    doc: "Comma-separated .wig control files"
    inputBinding:
      position: 1
      itemSeparator: ','
  - id: experimental_files
    type: File[]
    doc: "Comma-separated .wig experimental files"
    inputBinding:
      position: 2
      itemSeparator: ','
  - id: annotation_file
    type: File
    doc: "Annotation .prot_table or GFF3 file"
    inputBinding:
      position: 3
  - id: output_filename
    type: string
    doc: "Output file name"
    inputBinding:
      position: 4
  - id: normalization_method
    type: ['null', string]
    doc: "Normalization method. Default: TTR"
    inputBinding:
      position: 20
      prefix: -n
  - id: include_zero_rows
    type: ['null', boolean]
    doc: "Include rows with zero accross conditions."
    inputBinding:
      position: 20
      prefix: -iz
  - id: loess_correction
    type: ['null', boolean]
    doc: "Perform LOESS Correction; Helps remove possible genomic position bias. Default: Turned Off."
    inputBinding:
      position: 20
      prefix: -l
  - id: ignore_n_terminus_fraction
    type: ['null', float]
    doc: "Ignore TAs occuring at given fraction (as integer) of the N terminus. Default: 0"
    inputBinding:
      position: 20
      prefix: -iN
  - id: ignore_c_terminus_fraction
    type: ['null', float]
    doc: "Ignore TAs occuring at given fraction (as integer) of the C terminus. Default: 0"
    inputBinding:
      position: 20
      prefix: -iC
outputs:
  - id: output_file
    type: File
    doc: "Output file"
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
