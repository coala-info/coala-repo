cwlVersion: v1.2
class: CommandLineTool
baseCommand: lambda2
label: lambda-align2_lambda2
doc: "Lambda is a local aligner optimized for many query sequences and searches in
  protein space. It is compatible to BLAST, but much faster than BLAST and many other
  comparable tools.\n\nTool homepage: http://seqan.github.io/lambda/"
inputs:
  - id: command
    type: string
    doc: The sub-program to execute. See below. One of searchp, searchn, 
      mkindexp, and mkindexn.
    inputBinding:
      position: 1
  - id: copyright
    type:
      - 'null'
      - boolean
    doc: Display long copyright information.
    inputBinding:
      position: 102
      prefix: --copyright
  - id: version_check
    type:
      - 'null'
      - boolean
    doc: Turn this option off to disable version update notifications of the 
      application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
    inputBinding:
      position: 102
      prefix: --version-check
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/lambda-align2:v2.0.0-6-deb_cv1
stdout: lambda-align2_lambda2.out
