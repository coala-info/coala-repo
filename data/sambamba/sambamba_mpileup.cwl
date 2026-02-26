cwlVersion: v1.2
class: CommandLineTool
baseCommand: sambamba-pileup
label: sambamba_mpileup
doc: "This subcommand relies on external tools and acts as a multi-core\nimplementation
  of samtools and bcftools.\n\nTool homepage: https://github.com/biod/sambamba"
inputs:
  - id: input_bam
    type:
      type: array
      items: File
    doc: Input BAM file(s)
    inputBinding:
      position: 1
  - id: bcftools_args
    type:
      - 'null'
      - string
    doc: bcftools call arguments
    inputBinding:
      position: 102
      prefix: --bcftools
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: chunk size (in bytes)
    default: 64000000
    inputBinding:
      position: 102
      prefix: --buffer-size
  - id: nthreads
    type:
      - 'null'
      - int
    doc: maximum number of threads to use
    inputBinding:
      position: 102
      prefix: --nthreads
  - id: output_buffer_size
    type:
      - 'null'
      - int
    doc: output buffer size (in bytes)
    default: 512000000
    inputBinding:
      position: 102
      prefix: --output-buffer-size
  - id: regions
    type:
      - 'null'
      - File
    doc: provide BED file with regions (no need to duplicate it in samtools 
      args); all input files must be indexed
    inputBinding:
      position: 102
      prefix: --regions
  - id: samtools_args
    type:
      - 'null'
      - string
    doc: samtools mpileup arguments
    inputBinding:
      position: 102
      prefix: --samtools
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 102
      prefix: --tmpdir
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: specify output filename
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sambamba:1.0.1--he614052_4
