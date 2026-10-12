cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomeCoverageBed.pl
label: perl-bio-samtools_genomeCoverageBed.pl
doc: "Write the genome coverage of a BAM file as a BEDGraph table on standard output.\n\nTool homepage: https://metacpan.org/pod/Bio::DB::Sam"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file. It must be sorted and indexed (.bai beside it).
    secondaryFiles:
      - .bai
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: BEDGraph coverage on standard output
stdout: $(inputs.input_bam.nameroot).coverage.bedgraph
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-samtools:1.43--pl5321h577a1d6_6
