cwlVersion: v1.2
class: CommandLineTool
baseCommand: beagle2chromopainter.pl
label: finestructure_beagle2chromopainter
doc: 'Converts phased BEAGLE (v3 or less, not VCF) output to ChromoPainter-style input
  files. Only biallelic SNPs are kept.


  Tool homepage: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: jitter
    type:
      - 'null'
      - boolean
    doc: Jitter (add 1) to SNP locations if SNPs are not strictly ascending. Otherwise
      an error is produced.
    inputBinding:
      position: 1
      prefix: -J
  - id: v1
    type:
      - 'null'
      - boolean
    doc: Produce output compatible with CHROMOPAINTER v1, i.e. include the line of
      S for each SNP.
    inputBinding:
      position: 1
      prefix: -v1
  - id: first_line
    type:
      - 'null'
      - boolean
    doc: Create the correct first line for standard fineSTRUCTURE usage (the first
      line is 0, all other lines are appended).
    inputBinding:
      position: 1
      prefix: -f
  - id: beagle_phased_output_file
    type: File
    doc: BEAGLE v3 or less (not VCF) phased file (unzipped) that contains phased haplotypes
    inputBinding:
      position: 2
  - id: output_filename_prefix
    type: string
    doc: Filename prefix for the ChromoPainter input files. The suffixes .phase and
      .ids are added
    inputBinding:
      position: 3
outputs:
  - id: phase_file
    type: File
    doc: ChromoPainter phase file
    outputBinding:
      glob: $(inputs.output_filename_prefix).phase
  - id: ids_file
    type: File
    doc: Individual ID file
    outputBinding:
      glob: $(inputs.output_filename_prefix).ids
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
