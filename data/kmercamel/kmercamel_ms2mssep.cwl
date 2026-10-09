cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmercamel
  - ms2mssep
label: kmercamel_ms2mssep
doc: "Split a masked superstring into a mask file and a superstring file\n\nTool homepage: https://github.com/OndrejSladky/kmercamel"
inputs:
  - id: mask_file_out
    type: ['null', string]
    default: "ms2mssep_mask.txt"
    doc: "Output file with mask"
    inputBinding:
      position: 1
      prefix: "-m"
  - id: superstring_file_out
    type: ['null', string]
    default: "ms2mssep_superstring.txt"
    doc: "Output file with superstring"
    inputBinding:
      position: 1
      prefix: "-s"
  - id: ms
    type: File
    doc: "Input masked superstring (FASTA)"
    inputBinding:
      position: 10
outputs:
  - id: mask_out
    type: ['null', File]
    doc: "Mask file written with -m"
    outputBinding:
      glob: $(inputs.mask_file_out)
  - id: superstring_out
    type: ['null', File]
    doc: "Superstring file written with -s"
    outputBinding:
      glob: $(inputs.superstring_file_out)
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
stdout: kmercamel_ms2mssep.out
