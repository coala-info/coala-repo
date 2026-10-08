cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromopainter2chromopainterv2.pl
label: finestructure_chromopainter2chromopainterv2
doc: 'Converts a ChromoPainter v1 phase file to the v2 format.


  Tool homepage: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: ploidy
    type:
      - 'null'
      - int
    doc: Ploidy
    inputBinding:
      position: 1
      prefix: -p
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
    doc: ChromoPainter/PHASE style SNP file
    inputBinding:
      position: 2
  - id: outputphasefile
    type: string
    doc: Output phase file
    inputBinding:
      position: 3
outputs:
  - id: output_phase
    type: File
    doc: Output phase file
    outputBinding:
      glob: $(inputs.outputphasefile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
