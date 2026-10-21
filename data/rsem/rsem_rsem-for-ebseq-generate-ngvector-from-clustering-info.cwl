cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-for-ebseq-generate-ngvector-from-clustering-info
label: rsem_rsem-for-ebseq-generate-ngvector-from-clustering-info
doc: "Generate the NgVector file used by EBSeq from the clustering information
  file made by rsem-for-ebseq-calculate-clustering-info. The transcripts are
  grouped into three groups by k-means clustering of their clustering value;
  transcripts without a value go to group 3.\n\nTool homepage:
  https://deweylab.github.io/RSEM/"
inputs:
  - id: input_file
    type: File
    doc: The clustering information file made by 
      rsem-for-ebseq-calculate-clustering-info.
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: The name of the NgVector output file.
    inputBinding:
      position: 2
outputs:
  - id: ngvector
    type: File
    outputBinding:
      glob: $(inputs.output_file)
    doc: The NgVector file (one group number per line).
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
