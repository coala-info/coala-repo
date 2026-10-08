cwlVersion: v1.2
class: CommandLineTool
baseCommand: validate_gtf.pl
label: eval_validate_gtf.pl
doc: "Validates a GTF file (optionally against its genome sequence) to find genes with in-frame stops, reading frame changes and other problems; can write bad-gene lists, a transcript file and a fixed GTF.\n\nTool homepage: http://mblab.wustl.edu/software.html"
inputs:
  - id: transcript_output
    type:
      - 'null'
      - string
    doc: "Output transcript file (needs the sequence file)"
    inputBinding:
      position: 1
      prefix: -t
  - id: create_fixed_gtf
    type:
      - 'null'
      - boolean
    doc: "Create a fixed gtf file next to the input (this may not be possible; always check the fixed file)"
    inputBinding:
      position: 2
      prefix: -f
  - id: max_error_messages
    type:
      - 'null'
      - int
    doc: "Maximum number of detailed error messages to return per error (default 5)"
    inputBinding:
      position: 3
      prefix: -e
  - id: output_inframe_stop_genes
    type:
      - 'null'
      - boolean
    doc: "Output list of inframe stop genes"
    inputBinding:
      position: 4
      prefix: -s
  - id: suppress_start_stop_warnings
    type:
      - 'null'
      - boolean
    doc: "Suppress warnings about missing start/stop"
    inputBinding:
      position: 5
      prefix: -c
  - id: suppress_splice_site_warnings
    type:
      - 'null'
      - boolean
    doc: "Suppress warnings about bad splice site sequence"
    inputBinding:
      position: 6
      prefix: -p
  - id: bad_genes_super_clean
    type:
      - 'null'
      - boolean
    doc: "Output a list of bad genes for a \"super-clean\" training set"
    inputBinding:
      position: 7
      prefix: -k
  - id: bad_genes_training
    type:
      - 'null'
      - boolean
    doc: "Output a list of bad genes for training applications"
    inputBinding:
      position: 8
      prefix: -l
  - id: bad_genes_evaluation
    type:
      - 'null'
      - boolean
    doc: "Output a list of bad genes for evaluation purposes"
    inputBinding:
      position: 9
      prefix: -m
  - id: gtf_file
    type: File
    doc: "The GTF file to be validated"
    inputBinding:
      position: 100
  - id: sequence_file
    type:
      - 'null'
      - File
    doc: "Sequence file (FASTA) of the chromosome"
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Validation messages and, with -s/-k/-l/-m, the bad gene list
  - id: transcript_file
    type:
      - 'null'
      - File
    doc: "Transcript file written by -t"
    outputBinding:
      glob: $(inputs.transcript_output)
  - id: fixed_gtf
    type:
      - 'null'
      - File
    doc: "Fixed GTF written by -f"
    outputBinding:
      glob: "*.fixed.gtf"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.gtf_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eval:2.2.8--pl526_0
stdout: eval_validate_gtf.pl.out
