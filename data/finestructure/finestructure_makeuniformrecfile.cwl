cwlVersion: v1.2
class: CommandLineTool
baseCommand: makeuniformrecfile.pl
label: finestructure_makeuniformrecfile
doc: 'Create a uniform recombination file (about 0.1 Morgans per Mb) for a ChromoPainter
  phase file. Use only together with EM parameter estimation.


  Tool homepage: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: phasefile
    type: File
    doc: Valid ChromoPainter input file ending in .phase (v1 or v2 format)
    inputBinding:
      position: 1
  - id: outputfile
    type: string
    doc: Output recombination file, nominally in Morgans per base
    inputBinding:
      position: 2
outputs:
  - id: output_rec
    type: File
    doc: Output recombination file
    outputBinding:
      glob: $(inputs.outputfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
