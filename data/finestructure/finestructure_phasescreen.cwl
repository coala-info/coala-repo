cwlVersion: v1.2
class: CommandLineTool
baseCommand: phasescreen.pl
label: finestructure_phasescreen
doc: 'Remove singletons or non-SNPs from ChromoPainter phase data.


  Tool homepage: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: phasefile
    type: File
    doc: ChromoPainter/PHASE style SNP file
    inputBinding:
      position: 1
  - id: outputphasefile
    type: string
    doc: Output phase file
    inputBinding:
      position: 2
outputs:
  - id: output_phase
    type: File
    doc: Screened phase file
    outputBinding:
      glob: $(inputs.outputphasefile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
