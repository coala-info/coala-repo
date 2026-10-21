cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- reference
label: samtools_reference
doc: 'Generates a reference from aligned data


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_file
  type:
  - 'null'
  - File
  doc: Input CRAM, BAM or SAM file (uses embedded reference or MD:Z tags).
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: .csi
    required: false
  - pattern: .crai
    required: false
  - pattern: ^.bai
    required: false
  inputBinding:
    position: 104
- id: region
  type:
  - 'null'
  - string
  doc: Region to extract (-r).
  inputBinding:
    position: 103
    prefix: -r
- id: embedded_ref
  type:
  - 'null'
  - boolean
  doc: Enable CRAM embedded reference mode (needs CRAM made with embed_ref=1).
  inputBinding:
    position: 103
    prefix: -e
- id: quiet
  type:
  - 'null'
  - boolean
  doc: 'Quiet mode: no per-reference report.'
  inputBinding:
    position: 103
    prefix: -q
- id: output_filename
  type: string
  doc: Output FASTA file (-o).
  default: reference.fa
  inputBinding:
    position: 103
    prefix: -o
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use.
  inputBinding:
    position: 103
    prefix: -@
outputs:
- id: output
  type: File
  doc: Reconstructed reference sequence.
  outputBinding:
    glob: $(inputs.output_filename)
