cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff2bed.pl
label: perl-bio-viennangs_gff2bed.pl
doc: "Extract specific features from a GFF3 file and convert them to BED format.\n\
  \nTool homepage: http://metacpan.org/pod/Bio::ViennaNGS"
inputs:
  - id: feature
    type:
      - 'null'
      - string
    doc: Specify feature type (eg. CDS,tRNA,rRNA,SBS, etc) to be extracted from 
      GFF3.
    inputBinding:
      position: 101
      prefix: --feature
  - id: gff
    type:
      - 'null'
      - File
    doc: Input GFF file.
    inputBinding:
      position: 101
      prefix: --gff
  - id: man
    type:
      - 'null'
      - boolean
    doc: Prints the manual page and exits
    inputBinding:
      position: 101
      prefix: --man
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output path.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-viennangs:v0.19.2--pl526_5
