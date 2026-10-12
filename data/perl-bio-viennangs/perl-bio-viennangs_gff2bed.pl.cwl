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
    type: File
    doc: Input GFF file.
    inputBinding:
      position: 101
      prefix: --gff
  - id: out_path
    type: string
    doc: Output directory (created by the tool). One BED12 file per feature type is written there.
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: out
    type: Directory
    doc: Output directory with the BED12 files and the feature summary
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-viennangs:v0.19.2--pl526_5
