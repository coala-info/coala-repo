cwlVersion: v1.2
class: CommandLineTool
baseCommand: simwalk2
label: simwalk2
doc: "SimWalk2 is a statistical genetics software package for haplotype analysis,
  linkage analysis, and more. (Note: The provided text contains container build logs
  and error messages rather than help text; therefore, no arguments could be extracted.)\n
  \nTool homepage: http://www.genetics.ucla.edu/software/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simwalk2:2.91--haf399aa_6
stdout: simwalk2.out
