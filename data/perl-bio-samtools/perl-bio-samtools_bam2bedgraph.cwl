cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam2bedgraph
label: perl-bio-samtools_bam2bedgraph
doc: "Create a BEDGraph file of genomic coverage from a sorted BAM file.\n\nTool homepage: https://metacpan.org/pod/Bio::DB::Sam"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file. It must be sorted and indexed.
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 1
  - id: region
    type:
      - 'null'
      - string
    doc: Optional region to restrict the output to (for example chr:start-end)
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: BEDGraph coverage on standard output
stdout: $(inputs.input_bam.nameroot).bedgraph
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-samtools:1.43--pl5321h577a1d6_6
