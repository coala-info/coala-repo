cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - convert_bowtie_output.pl
label: mirdeep2_convert_bowtie_output.pl
doc: "Convert bowtie default-format read mappings (.bwt) to the miRDeep2 arf format\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: bowtie_output
    type: File
    doc: Bowtie mapping output file (reads_mapped.bwt)
    inputBinding:
      position: 1
outputs:
  - id: arf
    type: stdout
    doc: Read mappings in arf format
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: mappings.arf
