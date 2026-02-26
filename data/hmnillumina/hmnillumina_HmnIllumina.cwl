cwlVersion: v1.2
class: CommandLineTool
baseCommand: IlluminaSav
label: hmnillumina_HmnIllumina
doc: "Extract Illumina SAV (Sequence Analysis Viewer) Interop data\n\nTool homepage:
  https://github.com/guillaume-gricourt/HmnIllumina"
inputs:
  - id: input_folder
    type: Directory
    doc: folder Interop
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output_file
    type: File
    doc: file output
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnillumina:1.5.1--h077b44d_2
