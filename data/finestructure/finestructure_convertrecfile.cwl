cwlVersion: v1.2
class: CommandLineTool
baseCommand: convertrecfile.pl
label: finestructure_convertrecfile
doc: 'Create recombination maps for ChromoPainter phase files from other maps (hapmap
  or plain format).


  Tool homepage: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: major_mode
    type:
      - 'null'
      - string
    doc: 'Major mode of the input recombination map: hapmap (4 columns: chromosome,
      position, rate in cM/Mb, map in cM) or plain (default; position and rate in
      Morgans per base).'
    inputBinding:
      position: 1
      prefix: -M
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 1
      prefix: -v
  - id: phasefile
    type: File
    doc: Valid ChromoPainter or ChromoPainter v2 input file ending in .phase
    inputBinding:
      position: 2
  - id: inrecfile
    type: File
    doc: Recombination file in the format given by the major mode
    inputBinding:
      position: 3
  - id: outputrecfile
    type: string
    doc: Output recombination file for use with ChromoPainter
    inputBinding:
      position: 4
outputs:
  - id: output_rec
    type: File
    doc: Output recombination file
    outputBinding:
      glob: $(inputs.outputrecfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
