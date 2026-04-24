cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam_to_bigWig.pl
label: perl-bio-viennangs_bam_to_bigwig.pl
doc: "Convert BAM files to bigWig format for visualization, with support for strand-specific
  data.\n\nTool homepage: http://metacpan.org/pod/Bio::ViennaNGS"
inputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: Input file in BAM format
    inputBinding:
      position: 101
      prefix: --bam
  - id: chromosome_sizes
    type:
      - 'null'
      - File
    doc: Chromosome sizes file
    inputBinding:
      position: 101
      prefix: --cs
  - id: log
    type:
      - 'null'
      - File
    doc: Name of the log file. Unless specified, the default log file will be 
      'bam_to_bigwig.log' in the given output directory.
    inputBinding:
      position: 101
      prefix: --log
  - id: strand
    type:
      - 'null'
      - string
    doc: Use this option if the input BAM file is strictly strand-specific. 
      Possible values are either '+' or '-'. If '+', interim bedGraph will have 
      positive values. If '-', interim bedGraph will have negative values 
      (required for UCSC negative strand visualization).
    inputBinding:
      position: 101
      prefix: --strand
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-viennangs:v0.19.2--pl526_5
