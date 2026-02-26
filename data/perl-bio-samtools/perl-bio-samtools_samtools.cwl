cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools
label: perl-bio-samtools_samtools
doc: "Tools for alignments in the SAM format\n\nTool homepage: https://www.htslib.org/"
inputs:
  - id: command
    type: string
    doc: The subcommand to execute (view, sort, mpileup, depth, faidx, tview, 
      index, idxstats, fixmate, flagstat, calmd, merge, rmdup, reheader, cat, 
      bedcov, targetcut, phase, or bamshuf)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-samtools:1.43--pl5321h577a1d6_6
stdout: perl-bio-samtools_samtools.out
