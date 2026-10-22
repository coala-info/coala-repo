cwlVersion: v1.2
class: CommandLineTool
baseCommand: subindel
label: subread_subindel
doc: "Detect short and long indels from read mapping results.\n\nTool homepage: http://subread.sourceforge.net/"
inputs:
  - id: input_file
    type: File
    doc: SAM file with the read mapping results.
    inputBinding:
      position: 1
      prefix: -i
  - id: index_basename
    type: string
    doc: Subread index base name.
    inputBinding:
      position: 1
      prefix: -g
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files built by subread-buildindex (staged in the working directory so the base name resolves)
  - id: output_file
    type: string
    doc: Output name; the tool writes <name>.indel.vcf and <name>.reassembly.fa
    inputBinding:
      position: 1
      prefix: -o
  - id: fragment_distance
    type:
      - 'null'
      - int
    doc: Expected fragment distance.
    inputBinding:
      position: 1
      prefix: -d
  - id: max_indel_length
    type:
      - 'null'
      - int
    doc: Maximum indel length.
    inputBinding:
      position: 1
      prefix: -I
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: The reads are paired-end.
    inputBinding:
      position: 1
      prefix: --paired-end
outputs:
  - id: indels
    type: File
    doc: Detected indels in VCF format (the tool appends .indel.vcf to the output name)
    outputBinding:
      glob: $(inputs.output_file).indel.vcf
  - id: reassembly
    type:
      - 'null'
      - File
    doc: Reassembled sequences around the indels
    outputBinding:
      glob: $(inputs.output_file).reassembly.fa
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.index_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
