cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmercamel
  - ms2spss
label: kmercamel_ms2spss
doc: "Converts a masked superstring to a set of k-mers.\n\nTool homepage: https://github.com/OndrejSladky/kmercamel/"
inputs:
  - id: ms_file
    type: File
    doc: Path to the masked superstring file
    inputBinding:
      position: 1
  - id: kmer_size
    type: int
    doc: k-mer size
    inputBinding:
      position: 102
      prefix: -k
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output for the (minone) masked superstring; if not specified, printed 
      to stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
