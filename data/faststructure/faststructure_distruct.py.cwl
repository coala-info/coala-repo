cwlVersion: v1.2
class: CommandLineTool
baseCommand: distruct.py
label: faststructure_distruct.py
doc: "Plot the estimated admixture proportions of a fastStructure run as a bar
  figure (distruct plot).\n\nTool homepage: https://github.com/rajanil/fastStructure"
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.mean_q)
inputs:
  - id: k
    type: int
    doc: Number of populations
    inputBinding:
      position: 1
      prefix: -K
  - id: mean_q
    type: 'File[]'
    doc: The <prefix>.<K>.meanQ file written by structure.py (staged in the working
      directory)
  - id: input_prefix
    type: string
    doc: Output prefix that was passed to structure.py
    inputBinding:
      position: 2
      prefix: --input=
      separate: false
  - id: output
    type: string
    doc: Output figure file name (extension sets the format, e.g. .svg or .png)
    inputBinding:
      position: 3
      prefix: --output=
      separate: false
  - id: popfile
    type: ['null', File]
    doc: File with known categorical labels, one per sample
    inputBinding:
      position: 4
      prefix: --popfile=
      separate: false
  - id: title
    type: ['null', string]
    doc: Title for the figure
    inputBinding:
      position: 5
      prefix: --title=
      separate: false
outputs:
  - id: figure
    type: File
    doc: Distruct figure
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/faststructure:1.0--py311h1f01909_6
stdout: faststructure_distruct.py.out
