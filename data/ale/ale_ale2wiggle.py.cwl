cwlVersion: v1.2
class: CommandLineTool
baseCommand: ale2wiggle.py
label: ale_ale2wiggle.py
doc: "Converts ALE (Assembly Likelihood Evaluation) output files to Wiggle format.\n\
  \nTool homepage: https://github.com/sc932/ALE"
inputs:
  - id: input_ale
    type: File
    doc: The input ALE file to be converted to Wiggle format.
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
outputs:
  - id: wiggle_files
    type:
      type: array
      items: File
    doc: Wiggle tracks written next to the input (<input>.wig, -depth.wig, -place.wig,
      -insert.wig, -kmer.wig)
    outputBinding:
      glob: $(inputs.input_ale.basename)*.wig
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_ale)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ale:20180904--py27ha92aebf_0
stdout: ale_ale2wiggle.py.out
