cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - simutrain
label: maq_simutrain
doc: "Train parameters for read simulation from known reads.\n\nTool homepage: http://maq.sourceforge.net/"
inputs:
  - id: simupars_file
    type: string
    doc: Output simulation parameters file name
    inputBinding:
      position: 1
  - id: known_reads_file
    type: File
    doc: Known reads file (FASTQ format)
    inputBinding:
      position: 2
outputs:
  - id: output_simupars
    type: File
    doc: Simulation parameters file
    outputBinding:
      glob: $(inputs.simupars_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_simutrain.out
