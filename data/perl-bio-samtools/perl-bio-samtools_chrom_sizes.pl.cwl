cwlVersion: v1.2
class: CommandLineTool
baseCommand: chrom_sizes.pl
label: perl-bio-samtools_chrom_sizes.pl
doc: "Output a chrom_sizes file (sequence name and length, tab-separated) from the header of a BAM file.\n\nTool homepage: https://metacpan.org/pod/Bio::DB::Sam"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Chromosome sizes table on standard output
stdout: $(inputs.input_bam.nameroot).chrom.sizes
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-samtools:1.43--pl5321h577a1d6_6
