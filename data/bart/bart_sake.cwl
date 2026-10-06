cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, sake]
requirements:
  - class: InlineJavascriptRequirement
label: bart_sake
doc: "Use SAKE algorithm to recover a full k-space from undersampled data using low-rank
  matrix completion.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: kspace
    type: File
    doc: Input k-space data
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 11
  - id: iterations
    type:
      - 'null'
      - int
    doc: number of iterations
    inputBinding:
      position: 1
      prefix: -i
  - id: signal_subspace_size
    type:
      - 'null'
      - float
    doc: rel. size of the signal subspace
    inputBinding:
      position: 1
      prefix: -s
outputs:
  - id: output
    type: File
    doc: Output file for the recovered k-space
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
