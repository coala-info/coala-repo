cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_CorrectUmis
doc: "Corrects UMIs stored in BAM files when a set of fixed UMIs is in use. If the\
  \ set of UMIs used in an experiment is known and is a subset of the possible randomers\
  \ of the same length, it is possible to error-correct UMIs prior to grouping reads\
  \ by UMI. This tool takes an input BAM with UMIs in a tag ('RX' by default) and\
  \ set of known UMIs (either on the command line or in a file) and produces:\n\n\
  \  1. A new BAM with corrected UMIs in the same tag the UMIs were found in\n  2.\
  \ Optionally a set of metrics about the representation of each UMI in the set\n\
  \  3. Optionally a second BAM file of reads whose UMIs could not be corrected within\
  \ the specific parameters\n\nAll of the fixed UMIs must be of he same length, and\
  \ all UMIs in the BAM file must also have the same length. Multiple UMIs that are\
  \ concatenated with hyphens (e.g. 'AACCAGT-AGGTAGA') are split apart, corrected\
  \ individually and then re-assembled. A read is accepted only if all the UMIs can\
  \ be corrected.\n\nCorrection is controlled by two parameters that are applied per-UMI:\n\
  \n  1. --max-mismatches controls how many mismatches (no-calls are counted as mismatches)\
  \ are tolerated between a UMI as\n     read and a fixed UMI.\n  2. --min-distance\
  \ controls how many more mismatches the next best hit must have\n\nFor example,\
  \ with two fixed UMIs 'AAAAA' and 'CCCCC' and '--max-mismatches=3' and '--min-distance=2'\
  \ the following would happen:\n\n  * AAAAA would match to AAAAA\n  * AAGTG would\
  \ match to AAAAA with three mismatches because CCCCCC has six mismatches and 6 >=\
  \ 3 + 2\n  * AACCA would be rejected because it is 2 mismatches to AAAAA and 3 to\
  \ CCCCCC and 3 <= 2 + 2\n\nThe set of fixed UMIs may be specified on the command\
  \ line using '--umis umi1 umi2 ...' or via one or more files of UMIs with a single\
  \ sequence per line using '--umi-files umis.txt more_umis.txt'. If there are multiple\
  \ UMIs per template, leading to hyphenated UMI tags, the values for the fixed UMIs\
  \ should be single, non-hyphenated UMIs (e.g. if a record has 'RX:Z:ACGT-GGCA',\
  \ you would use '--umis ACGT GGCA').\n\nRecords which have their UMIs corrected\
  \ (i.e. the UMI is not identical to one of the expected UMIs but is close enough\
  \ to be corrected) will by default have their original UMI stored in the 'OX' tag.\
  \ This can be disabled with the '--dont-store-original-umis' option.\n\nFor a large\
  \ number of input UMIs, the '--cache-size' option may used to speed up the tool.\
  \ To disable using a cache, set the value to '0'.\n\nThe reverse complement (using\
  \ '--revcomp') option will reverse complement the UMI in place. In the case of multiple\
  \ UMIs concatenated together, the individual UMIs are reverse complemented and the\
  \ order reversed (eg. 'AAGG-ACTG' is changed to 'CAGT-CCTT').\n\nTool homepage:\
  \ https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
  - id: cache_size
    type:
      - 'null'
      - int
    doc: The number of uncorrected UMIs to cache; zero will disable the cache.
    inputBinding:
      position: 101
      prefix: --cache-size
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    inputBinding:
      position: 1
      prefix: --compression
  - id: cram_ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA for CRAM encoding/decoding.
    inputBinding:
      position: 1
      prefix: --cram-ref-fasta
  - id: dont_store_original_umis
    type:
      - 'null'
      - boolean
    doc: Don't store original UMIs upon correction.
    inputBinding:
      position: 101
      prefix: --dont-store-original-umis
  - id: input_bam
    type: File
    doc: Input SAM or BAM file.
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 1
      prefix: --log-level
  - id: max_mismatches
    type: int
    doc: Maximum number of mismatches between a UMI and an expected UMI.
    inputBinding:
      position: 101
      prefix: --max-mismatches
  - id: metrics
    type:
      - 'null'
      - string
    doc: Metrics file to write.
    inputBinding:
      position: 101
      prefix: --metrics
  - id: min_corrected
    type:
      - 'null'
      - float
    doc: The minimum ratio of kept UMIs to accept. A ratio below this will cause a
      failure (but all files will still be written).
    inputBinding:
      position: 101
      prefix: --min-corrected
  - id: min_distance
    type: int
    doc: Minimum difference (of mismatch distance) to next-best UMI.
    inputBinding:
      position: 101
      prefix: --min-distance
  - id: output_bam
    type: string
    doc: Output SAM or BAM file.
    inputBinding:
      position: 101
      prefix: --output
  - id: rejects_bam
    type:
      - 'null'
      - string
    doc: Reject BAM file to save unassigned reads.
    inputBinding:
      position: 101
      prefix: --rejects
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: Reverse complement the UMIs in the BAM file prior to correcting.
    inputBinding:
      position: 101
      prefix: --revcomp
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory to use for temporary files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
  - id: umi_files
    type:
      - 'null'
      - type: array
        items: File
    doc: File of UMI sequences, one per line.
    inputBinding:
      position: 101
      prefix: --umi-files
  - id: umi_tag
    type:
      - 'null'
      - string
    doc: Tag in which UMIs are stored.
    inputBinding:
      position: 101
      prefix: --umi-tag
  - id: umis
    type:
      - 'null'
      - type: array
        items: string
    doc: Expected UMI sequences.
    inputBinding:
      position: 101
      prefix: --umis
arguments:
  - position: 50
    valueFrom: CorrectUmis
outputs:
  - id: output_bam_out
    type: File
    doc: Output SAM or BAM file.
    outputBinding:
      glob: $(inputs.output_bam)
  - id: rejects_bam_out
    type:
      - 'null'
      - File
    doc: Reject BAM file to save unassigned reads.
    outputBinding:
      glob: $(inputs.rejects_bam)
  - id: metrics_out
    type:
      - 'null'
      - File
    doc: Metrics file to write.
    outputBinding:
      glob: $(inputs.metrics)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
