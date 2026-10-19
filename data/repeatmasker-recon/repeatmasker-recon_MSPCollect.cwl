cwlVersion: v1.2
class: CommandLineTool
baseCommand: MSPCollect
label: repeatmasker-recon_MSPCollect
doc: "Convert a BLAST output into an MSP file, which is used by repeatmasker-recon as input.\n\nTool homepage: https://www.repeatmasker.org/RepeatMasker"
inputs:
  - id: blast_output_file
    type: File
    doc: BLAST output file
    inputBinding:
      position: 1
outputs:
  - id: msp_output
    type: stdout
    doc: MSP file (score %iden start end query_name start end subject_name)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/repeatmasker-recon:v1.08-4-deb_cv1
stdout: $(inputs.blast_output_file.basename).msp
