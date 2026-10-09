cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmercamel
  - mssep2ms
label: kmercamel_mssep2ms
doc: "Combine a mask file and a superstring file into a masked superstring (cannot have both redirected from stdin)\n\nTool homepage: https://github.com/OndrejSladky/kmercamel"
inputs:
  - id: output_file
    type: ['null', string]
    default: "mssep2ms_out.fa"
    doc: "Output for the masked superstring; if not specified, printed to stdout"
    inputBinding:
      position: 1
      prefix: "-o"
  - id: mask_file
    type: ['null', File]
    doc: "Input file with mask"
    inputBinding:
      position: 1
      prefix: "-m"
  - id: superstring_file
    type: ['null', File]
    doc: "Input file with superstring"
    inputBinding:
      position: 1
      prefix: "-s"
outputs:
  - id: output_file_out
    type: ['null', File]
    doc: "Output file written with -o"
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
stdout: kmercamel_mssep2ms.out
