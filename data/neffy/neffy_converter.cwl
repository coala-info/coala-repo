cwlVersion: v1.2
class: CommandLineTool
baseCommand: neffy_converter
label: neffy_converter
doc: "Converts OCI (Open Container Initiative) blobs/images to SIF (Singularity Image
  Format)\n\nTool homepage: https://github.com/Maryam-Haghani/NEFFy"
inputs:
  - id: input_uri
    type: string
    doc: The URI of the OCI/Docker image to convert (e.g., docker://...)
    inputBinding:
      position: 1
outputs:
  - id: output_sif
    type: File
    doc: The path to the resulting SIF format file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neffy:0.1.1--py311he264feb_1
