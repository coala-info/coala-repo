cwlVersion: v1.2
class: CommandLineTool
baseCommand: wigToBigWig.pl
label: perl-bio-bigfile_wigToBigWig.pl
doc: "Convert an ASCII wiggle file (without track lines) to an indexed bigWig file.\n\nTool homepage: https://metacpan.org/pod/Bio::DB::BigFile"
inputs:
  - id: input_wig
    type: File
    doc: Input wiggle file in one of the ASCII wiggle formats, without track lines
    inputBinding:
      position: 1
  - id: chrom_sizes
    type: File
    doc: 'Chromosome sizes file (two columns: <chromosome name> <size in bases>)'
    inputBinding:
      position: 2
  - id: output_name
    type: string
    doc: Name of the output indexed bigWig file
    inputBinding:
      position: 3
outputs:
  - id: output_bw
    type: File
    doc: Output bigWig file
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-bigfile:1.07--pl5321h41f7678_7
