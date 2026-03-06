cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- collate
label: samtools_collate
doc: "Shuffles and groups reads together by name\n\nTool homepage: https://github.com/samtools/samtools"
requirements:
- class: InlineJavascriptRequirement
inputs:
- id: input_bam
  type: File
  doc: Input BAM file
  inputBinding:
    position: 1
- id: prefix_positional
  type: string
  doc: Output prefix (required unless -o or -O is used)
  inputBinding:
    position: 2
- id: compression_level
  type: int?
  doc: Compression level
  default: 1
  inputBinding:
    position: 103
    prefix: -l
- id: fast
  type: boolean?
  doc: Fast (only primary alignments)
  inputBinding:
    position: 103
    prefix: -f
- id: input_fmt_option
  type: string[]?
  doc: Specify a single input file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 103
    prefix: --input-fmt-option
- id: nb_temp_files
  type: int?
  doc: Number of temporary files
  default: 64
  inputBinding:
    position: 103
    prefix: -n
- id: no_pg
  type: boolean?
  doc: do not add a PG line
  inputBinding:
    position: 103
    prefix: --no-PG
- id: output_fmt
  type: string?
  doc: Specify output format (SAM, BAM, CRAM)
  inputBinding:
    position: 103
    prefix: --output-fmt
- id: output_fmt_option
  type: string[]?
  doc: Specify a single output file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 103
    prefix: --output-fmt-option
- id: output_to_stdout
  type: boolean?
  doc: Output to stdout
  inputBinding:
    position: 103
    prefix: -O
- id: reference
  type: File?
  doc: Reference sequence FASTA FILE
  inputBinding:
    position: 103
    prefix: --reference
- id: temp_prefix
  type: string?
  doc: Write temporary files to PREFIX.nnnn.bam
  inputBinding:
    position: 103
    prefix: -T
- id: threads
  type: int?
  doc: Number of additional threads to use
  default: 0
  inputBinding:
    position: 103
    prefix: --threads
- id: uncompressed_bam
  type: boolean?
  doc: Uncompressed BAM output
  inputBinding:
    position: 103
    prefix: -u
- id: verbosity
  type: int?
  doc: Set level of verbosity
  inputBinding:
    position: 103
    prefix: --verbosity
- id: working_reads
  type: int?
  doc: Working reads stored (with -f)
  default: 10000
  inputBinding:
    position: 103
    prefix: -r
outputs:
- id: output_file
  type: File?
  doc: Output file name (use prefix if not set)
  outputBinding:
    glob: |
      ${
        if (inputs.prefix_positional) {
          return inputs.prefix_positional;
        }
        return "*";
      }
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
