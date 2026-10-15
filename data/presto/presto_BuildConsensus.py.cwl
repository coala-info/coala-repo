cwlVersion: v1.2
class: CommandLineTool
baseCommand: BuildConsensus.py
label: presto_BuildConsensus.py
doc: "Builds a consensus sequence for each set of input sequences (for example reads
  with the same UMI barcode).\n\nTool homepage: http://presto.readthedocs.io"
inputs:
  - id: seq_files
    type:
      type: array
      items: File
      inputBinding:
        prefix: -s
        position: 1
    doc: A list of FASTA/FASTQ files containing sequences to process. Supports both
      uncompressed and gzip-compressed (.gz) files.
  - id: out_files
    type:
      - 'null'
      - type: array
        items: string
    doc: Explicit output file name(s). Cannot be used with --failed, --outdir or
      --outname.
    inputBinding:
      position: 2
      prefix: -o
  - id: out_dir
    type: string
    doc: Output directory (created before the run). The input file directory is
      used by the tool if this is not given, which is read-only here, so it is
      required.
    inputBinding:
      position: 2
      prefix: --outdir
  - id: out_name
    type:
      - 'null'
      - string
    doc: Changes the prefix of the successfully processed output file to the
      string specified. May not be specified with multiple input files.
    inputBinding:
      position: 2
      prefix: --outname
  - id: log_file
    type:
      - 'null'
      - string
    doc: Specify to write verbose logging to a file. May not be specified with
      multiple input files.
    inputBinding:
      position: 2
      prefix: --log
  - id: failed
    type:
      - 'null'
      - boolean
    doc: If specified create files containing records that fail processing.
    inputBinding:
      position: 2
      prefix: --failed
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Specify to force output as FASTA rather than FASTQ.
    inputBinding:
      position: 2
      prefix: --fasta
  - id: gzip_output
    type:
      - 'null'
      - boolean
    doc: Specify to force gzip compressed output files.
    inputBinding:
      position: 2
      prefix: --gzip-output
  - id: delimiter
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of the three delimiters that separate annotation blocks, field
      names and values, and values within a field, respectively (default | = ,).
    inputBinding:
      position: 2
      prefix: --delim
  - id: nproc
    type:
      - 'null'
      - int
    doc: The number of simultaneous computational processes to execute (CPU cores
      to utilized).
    inputBinding:
      position: 2
      prefix: --nproc
  - id: min_count
    type:
      - 'null'
      - int
    doc: The minimum number of sequences needed to define a valid consensus.
    inputBinding:
      position: 2
      prefix: -n
  - id: barcode_field
    type:
      - 'null'
      - string
    doc: Position of description barcode field to group sequences by (default
      BARCODE).
    inputBinding:
      position: 2
      prefix: --bf
  - id: min_qual
    type:
      - 'null'
      - float
    doc: Consensus quality score cut-off under which an ambiguous character is
      assigned; does not apply when quality scores are unavailable.
    inputBinding:
      position: 2
      prefix: -q
  - id: min_freq
    type:
      - 'null'
      - float
    doc: Fraction of character occurrences under which an ambiguous character is
      assigned (default 0.6).
    inputBinding:
      position: 2
      prefix: --freq
  - id: max_gap
    type:
      - 'null'
      - float
    doc: If specified, this defines a cut-off for the frequency of allowed gap
      values for each position. Positions exceeding the threshold are deleted from
      the consensus.
    inputBinding:
      position: 2
      prefix: --maxgap
  - id: primer_field
    type:
      - 'null'
      - string
    doc: Specifies the field name of the primer annotations.
    inputBinding:
      position: 2
      prefix: --pf
  - id: primer_freq
    type:
      - 'null'
      - float
    doc: Specify to define a minimum primer frequency required to assign a
      consensus primer, and filter out sequences with minority primers from the
      consensus building step.
    inputBinding:
      position: 2
      prefix: --prcons
  - id: copy_fields
    type:
      - 'null'
      - type: array
        items: string
    doc: Specifies a set of additional annotation fields to copy into the
      consensus sequence annotations.
    inputBinding:
      position: 2
      prefix: --cf
  - id: copy_actions
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of actions (min, max, sum, set, majority), one per copy field,
      which define how each annotation is combined into a single value."
    inputBinding:
      position: 2
      prefix: --act
  - id: dep
    type:
      - 'null'
      - boolean
    doc: Specify to calculate consensus quality with a non-independence
      assumption.
    inputBinding:
      position: 2
      prefix: --dep
  - id: max_diversity
    type:
      - 'null'
      - float
    doc: Calculate the nucleotide diversity of each read group (average pairwise
      error rate) and remove groups exceeding the given diversity threshold.
      Mutually exclusive with --maxerror.
    inputBinding:
      position: 2
      prefix: --maxdiv
  - id: max_error
    type:
      - 'null'
      - float
    doc: Calculate the error rate of each read group (rate of mismatches from
      consensus) and remove groups exceeding the given error threshold. Mutually
      exclusive with --maxdiv.
    inputBinding:
      position: 2
      prefix: --maxerror
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type: Directory
    doc: Directory with the consensus-pass (and, with --failed, consensus-fail) files
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.out_dir)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/presto:0.7.8--pyhdfd78af_0
stdout: presto_BuildConsensus.py.out
