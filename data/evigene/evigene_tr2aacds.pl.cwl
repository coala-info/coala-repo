cwlVersion: v1.2
class: CommandLineTool
baseCommand: evigene_tr2aacds.pl
label: evigene_tr2aacds.pl
doc: "Evigene transcript to amino acid coding sequences. (Note: The provided text
  contains container runtime error messages and does not include the tool's help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: http://arthropods.eugenes.org/EvidentialGene/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evigene:23.7.15--hdfd78af_1
stdout: evigene_tr2aacds.pl.out
