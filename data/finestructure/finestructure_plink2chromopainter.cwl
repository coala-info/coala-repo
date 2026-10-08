cwlVersion: v1.2
class: CommandLineTool
baseCommand: plink2chromopainter.pl
label: finestructure_plink2chromopainter
doc: 'Convert PLINK ped/map files (diploid, recoded with --recode12) to a ChromoPainter
  phase file. A recombination file still has to be created with convertrecfile.pl
  or makeuniformrecfile.pl.


  Tool homepage: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: pedfile
    type: File
    doc: Valid PLINK ped input file (diploid)
    inputBinding:
      position: 1
      prefix: -p=
      separate: false
  - id: mapfile
    type: File
    doc: Valid PLINK map file
    inputBinding:
      position: 2
      prefix: -m=
      separate: false
  - id: phasefile
    type: string
    doc: Output ChromoPainter phase file
    inputBinding:
      position: 3
      prefix: -o=
      separate: false
  - id: idfile
    type:
      - 'null'
      - string
    doc: Optional output file with the list of individual names
    inputBinding:
      position: 4
      prefix: -d=
      separate: false
  - id: family_ids
    type:
      - 'null'
      - boolean
    doc: Use the IDs from the first column of the ped file (the family ID). The default
      tries the second and falls back to the first.
    inputBinding:
      position: 4
      prefix: -f
  - id: chromosome_gap
    type:
      - 'null'
      - int
    doc: Gap in bp placed between different chromosomes (default 10e6)
    inputBinding:
      position: 4
      prefix: -g=
      separate: false
  - id: asis
    type:
      - 'null'
      - boolean
    doc: Assume the SNPs are stored as 0/1 rather than 1/2
    inputBinding:
      position: 4
      prefix: --asis
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Reduce the amount of screen output
    inputBinding:
      position: 4
      prefix: --quiet
outputs:
  - id: output_phase
    type: File
    doc: ChromoPainter phase file
    outputBinding:
      glob: $(inputs.phasefile)
  - id: output_ids
    type:
      - 'null'
      - File
    doc: Individual name file
    outputBinding:
      glob: $(inputs.idfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
