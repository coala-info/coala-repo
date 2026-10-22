cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sequenza-utils
  - pileup2acgt
label: sequenza-utils_pileup2acgt
doc: 'Parse the format from the samtools mpileup command, and report the occurrence of the 4 nucleotides in each position.


  Tool homepage: http://sequenza-utils.readthedocs.org'
inputs:
  - id: mpileup
    type: File
    doc: The input mpileup (SAMtools) file. Gzip is detected by the .gz extension.
    inputBinding:
      position: 1
      prefix: --mpileup
  - id: output_name
    type: string
    doc: Name of the output file. To use gzip compression name the file ending in .gz. Default STDOUT.
    inputBinding:
      position: 2
      prefix: --output
  - id: min_depth
    type:
      - 'null'
      - int
    doc: The minimum required read depth on a position to test for mutation. Default 1.
    inputBinding:
      position: 3
      prefix: -n
  - id: qlimit
    type:
      - 'null'
      - int
    doc: Minimum nucleotide quality score filter. Default 20.
    inputBinding:
      position: 4
      prefix: --qlimit
  - id: no_end
    type:
      - 'null'
      - boolean
    doc: Discard the base located at the end of the read.
    inputBinding:
      position: 5
      prefix: --no-end
  - id: no_start
    type:
      - 'null'
      - boolean
    doc: Discard the base located at the start of the read.
    inputBinding:
      position: 6
      prefix: --no-start
  - id: qformat
    type:
      - 'null'
      - string
    doc: Quality format, "sanger" or "illumina". Default "sanger".
    inputBinding:
      position: 7
      prefix: --qformat
outputs:
  - id: output_acgt
    type: File
    doc: Output ACGT file.
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
