cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainseeker_strainseeker.pl
label: strainseeker_strainseeker.pl
doc: "StrainSeeker is a tool for identifying bacterial strains from raw sequencing
  reads. (Note: The provided input text contained system error logs rather than the
  tool's help documentation, so arguments could not be extracted.)\n\nTool homepage:
  http://bioinfo.ut.ee/strainseeker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainseeker:1.5.1--h7b50bb2_5
stdout: strainseeker_strainseeker.pl.out
