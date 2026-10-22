cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtf2revcom.pl
label: snpgenie_gtf2revcom.pl
doc: "Converts a '+' strand GTF file to its reverse complement representation.\n\nTool homepage: https://github.com/chasewnelson/SNPGenie"
inputs:
  - id: gtf_file
    type: File
    doc: A '+' strand GTF file containing both '+' and '-' strand products from the '+' strand point of view.
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: sequence_length
    type: int
    doc: The total sequence length.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: revcom_files
    type:
      type: array
      items: File
    doc: Reverse complement GTF file (<name>_revcom.gtf)
    outputBinding:
      glob: "*_revcom.gtf"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.gtf_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
stdout: snpgenie_gtf2revcom.pl.out
