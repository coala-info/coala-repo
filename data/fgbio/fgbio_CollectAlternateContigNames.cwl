cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fgbio
  - CollectAlternateContigNames
label: fgbio_CollectAlternateContigNames
doc: "Collates the alternate contig names from an NCBI assembly report.\nThe input
  is to be the '*.assembly_report.txt' obtained from NCBI.\nThe output will be a \"\
  sequence dictionary\", which is a valid SAM file, containing the version header
  line and one line\nper contig. The primary contig name (i.e. '@SQ.SN') is specified
  with '--primary' option, while alternate names (i.e.\naliases) are specified with
  the '--alternates' option.\nThe 'Assigned-Molecule' column, if specified as an '--alternate',
  will only be used for sequences with 'Sequence-Role'\n'assembled-molecule'.\nWhen
  updating an existing sequence dictionary with '--existing' the primary contig names
  must match. I.e. the contig\nname from the assembly report column specified by '--primary'
  must match the contig name in the existing sequence\ndictionary ('@SQ.SN'). All
  contigs in the existing sequence dictionary must be present in the assembly report.\n\
  Furthermore, contigs in the assembly report not found in the sequence dictionary
  will be ignored.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: allow_mismatching_lengths
    type:
      - 'null'
      - boolean
    doc: Allow mismatching sequence lengths when using an existing sequence 
      dictionary file.
    default: false
    inputBinding:
      position: 101
      prefix: --allow-mismatching-lengths
  - id: alternates
    type:
      - 'null'
      - type: array
        items: string
    doc: The assembly report column(s) for the alternate contig name(s)
    inputBinding:
      position: 101
      prefix: --alternates
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    default: false
    inputBinding:
      position: 101
      prefix: --async-io
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    default: 5
    inputBinding:
      position: 101
      prefix: --compression
  - id: cram_ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA for CRAM encoding/decoding.
    inputBinding:
      position: 101
      prefix: --cram-ref-fasta
  - id: existing
    type:
      - 'null'
      - File
    doc: Update an existing sequence dictionary file. The primary names must 
      match.
    inputBinding:
      position: 101
      prefix: --existing
  - id: input
    type: File
    doc: Input NCBI assembly report file.
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: Minimum severity log-level to emit.
    default: Info
    inputBinding:
      position: 101
      prefix: --log-level
  - id: primary
    type:
      - 'null'
      - string
    doc: The assembly report column for the primary contig name.
    default: RefSeqAccession
    inputBinding:
      position: 101
      prefix: --primary
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: Validation stringency for SAM/BAM reading.
    default: SILENT
    inputBinding:
      position: 101
      prefix: --sam-validation-stringency
  - id: sequence_roles
    type:
      - 'null'
      - type: array
        items: string
    doc: "Only output sequences with the given sequence roles. If none given, all
      sequences will be\noutput."
    inputBinding:
      position: 101
      prefix: --sequence-roles
  - id: skip_missing_alternates
    type:
      - 'null'
      - boolean
    doc: Skip contigs that have no alternates
    default: true
    inputBinding:
      position: 101
      prefix: --skip-missing-alternates
  - id: sort_by_sequencing_role
    type:
      - 'null'
      - boolean
    doc: "Sort by the sequencing role (only when not updating an existing sequence
      dictionary\nfile). Uses the order from '--sequence-roles' if provided."
    default: false
    inputBinding:
      position: 101
      prefix: --sort-by-sequencing-role
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to use for temporary files.
    default: /tmp
    inputBinding:
      position: 101
      prefix: --tmp-dir
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output sequence dictionary file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
