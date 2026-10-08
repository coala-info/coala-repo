cwlVersion: v1.2
class: CommandLineTool
baseCommand: phasesubsample.pl
label: finestructure_phasesubsample
doc: 'Extract a SNP range (inclusive) from a ChromoPainter (PHASE) format file.


  Tool homepage: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 1
      prefix: -v
  - id: from_snp
    type: int
    doc: First SNP to retain (1 is the first SNP)
    inputBinding:
      position: 2
  - id: to_snp
    type: int
    doc: Final SNP to retain
    inputBinding:
      position: 3
  - id: phasefile
    type: File
    doc: ChromoPainter/PHASE style SNP file
    inputBinding:
      position: 4
  - id: outputphasefile
    type: string
    doc: Output phase file
    inputBinding:
      position: 5
outputs:
  - id: output_phase
    type: File
    doc: Phase file with the SNP range
    outputBinding:
      glob: $(inputs.outputphasefile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
