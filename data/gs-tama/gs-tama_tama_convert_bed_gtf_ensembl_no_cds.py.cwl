cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_convert_bed_gtf_ensembl_no_cds.py
label: gs-tama_tama_convert_bed_gtf_ensembl_no_cds.py
doc: "This script is used to convert the pacbio bed format file into a gtf file that mimics Ensembl's format, for use on bed files without CDS information (outputs of tama merge or tama collapse)\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: bed_file
    type: File
    doc: Bed12 file from tama merge or tama collapse
    inputBinding:
      position: 1
  - id: output_file_name
    type: string
    doc: Output file name
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type: File
    doc: Gtf file in Ensembl style
    outputBinding:
      glob: $(inputs.output_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_convert_bed_gtf_ensembl_no_cds.py.out
