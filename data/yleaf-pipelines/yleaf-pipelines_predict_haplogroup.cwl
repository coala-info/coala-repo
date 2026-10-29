cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - predict_haplogroup
label: yleaf-pipelines_predict_haplogroup
doc: "Erasmus MC: Genetic Identification Y-Haplogroup Prediction\n\nTool homepage: https://github.com/trianglegrrl/Yleaf-pipelines"
inputs:
  - id: input
    type: File
    doc: Output file or path produced from Yleaf
    inputBinding:
      position: 101
      prefix: --input
  - id: outfile
    type: string
    doc: Output file name
    inputBinding:
      position: 101
      prefix: --outfile
  - id: minimum_score
    type:
      - 'null'
      - float
    doc: Minimum score needed in order for a prediction to be considered for 
      inclusion in the final data (default=0.7).
    inputBinding:
      position: 101
      prefix: --minimum_score
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (default=1).
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type: File
    doc: Haplogroup prediction table
    outputBinding:
      glob: $(inputs.outfile)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yleaf-pipelines:3.3.0--pyh7e72e81_0
stdout: yleaf-pipelines_predict_haplogroup.out
