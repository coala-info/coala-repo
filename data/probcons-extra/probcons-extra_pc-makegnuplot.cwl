cwlVersion: v1.2
class: CommandLineTool
baseCommand: pc-makegnuplot
label: probcons-extra_pc-makegnuplot
doc: "Make a gnuplot script from the annotation scores written by probcons -annot.\n\nTool homepage: http://probcons.stanford.edu/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: annotscores
    type: File
    doc: "Annotation scores file (written by probcons -annot)"
    inputBinding:
      position: 1
  - id: refscores
    type:
      - 'null'
      - File
    doc: "Reference scores file"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: reliability_plot
    type:
      - 'null'
      - File
    doc: Column reliability plot (PostScript) drawn with gnuplot
    outputBinding:
      glob: reliability.ps
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/probcons-extra:v1.12-12-deb_cv1
stdout: probcons-extra_pc-makegnuplot.out
