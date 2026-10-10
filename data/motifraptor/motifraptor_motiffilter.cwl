cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MotifRaptor
  - motiffilter
label: motifraptor_motiffilter
doc: "Motifs filtering\n\nTool homepage: https://github.com/pinellolab/MotifRaptor"
inputs:
  - id: workdir
    type:
      - 'null'
      - string
    doc: "Working directory"
    inputBinding:
      position: 1
      prefix: -wd
  - id: motif_summary
    type:
      - 'null'
      - File
    doc: "Motif Summary File, usually from step2"
    inputBinding:
      position: 1
      prefix: -ms
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory (the working directory of the run)"
    outputBinding:
      glob: $(inputs.workdir)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
stdout: motifraptor_motiffilter.out
