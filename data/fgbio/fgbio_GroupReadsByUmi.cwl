cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_GroupReadsByUmi
doc: "Groups reads together that appear to have come from the same original molecule.\
  \ Reads are grouped by template, and then templates are sorted by the 5' mapping\
  \ positions of the reads from the template, used from earliest mapping position\
  \ to latest. Reads that have the same end positions are then sub-grouped by UMI\
  \ sequence.\n\nAccepts reads in any order (including 'unsorted') and outputs reads\
  \ sorted by:\n\n  1. The lower genome coordinate of the two outer ends of the templates\
  \ (strand-aware)\n  2. The sequencing library\n  3. The assigned UMI tag\n  4. Read\
  \ Name\n\nIt is recommended to sort the reads into template-coordinate (i.e. 'SO:unsorted\
  \ GO:query SS:unsorted:template-coordinate') prior to running this tool to avoid\
  \ this tool re-sorting the input. It is recommended to use 'samtools sort --template-coordinate\
  \ --threads $(nrpoc)' for the pre-sorting. The output will always be written in\
  \ template-coordinate order.\n\nDuring grouping, reads and templates are filtered\
  \ out as follows:\n\n  1. Templates are filtered if all reads for the template are\
  \ unmapped\n  2. Templates are filtered if any non-secondary, non-supplementary\
  \ read has mapping quality < 'min-map-q'\n  3. Templates are filtered if any UMI\
  \ sequence contains one or more 'N' bases\n  4. Templates are filtered if '--min-umi-length'\
  \ is specified and the UMI does not meet the length requirement\n  5. Records are\
  \ filtered out if flagged as either secondary or supplementary\n\nGrouping of UMIs\
  \ is performed by one of four strategies:\n\n  1. identity: only reads with identical\
  \ UMI sequences are grouped together. This strategy may be useful for evaluating\n\
  \     data, but should generally be avoided as it will generate multiple UMI groups\
  \ per original molecule in the presence\n     of errors.\n  2. edit: reads are clustered\
  \ into groups such that each read within a group has at least one other read in\
  \ the group\n     with <= edits differences and there are inter-group pairings with\
  \ <= edits differences. Effective when there are\n     small numbers of reads per\
  \ UMI, but breaks down at very high coverage of UMIs.\n  3. adjacency: a version\
  \ of the directed adjacency method described in umi_tools (http://dx.doi.org/10.1101/051755)\n\
  \     that allows for errors between UMIs but only when there is a count gradient.\n\
  \  4. paired: similar to adjacency but for methods that produce template such that\
  \ a read with A-B is related to but not\n     identical to a read with B-A. Expects\
  \ the UMI sequences to be stored in a single SAM tag separated by a hyphen (e.g.\n\
  \     'ACGT-CCGG') and allows for one of the two UMIs to be absent (e.g. 'ACGT-'\
  \ or '-ACGT'). The molecular IDs produced\n     have more structure than for single\
  \ UMI strategies and are of the form '{base}/{A|B}'. E.g. two UMI pairs would be\n\
  \     mapped as follows AAAA-GGGG -> 1/A, GGGG-AAAA -> 1/B.\n\nStrategies 'edit',\
  \ 'adjacency', and 'paired' make use of the '--edits' parameter to control the matching\
  \ of non-identical UMIs.\n\nBy default, all UMIs must be the same length. If '--min-umi-length=len'\
  \ is specified then reads that have a UMI shorter than 'len' will be discarded,\
  \ and when comparing UMIs of different lengths, the first len bases will be compared,\
  \ where 'len' is the length of the shortest UMI. The UMI length is the number of\
  \ ACGT bases in the UMI (i.e. does not count dashes and other non-ACGT characters).\
  \ This option is not implemented for reads with UMI pairs (i.e. using the paired\
  \ assigner).\n\nIf the '--mark-duplicates' option is given, reads will also have\
  \ their duplicate flag set in the BAM file. Each tag-family is treated separately,\
  \ and a single template within the tag family is chosen to be the \"unique\" template\
  \ and marked as non-duplicate, while all other templates in the tag family are then\
  \ marked as duplicate. There are a few limitations of duplicate-marking mode (vs.\
  \ e.g. Picard MarkDuplicates):\n\n  1. read pairs with one unmapped read are duplicate-marked\
  \ independently from read pairs with both reads mapped\n  2. secondary and supplementary\
  \ records are discarded\n\nNote: the '--min-map-q' parameter defaults to 0 in duplicate\
  \ marking mode and 1 otherwise, and is directly settable on the command line.\n\n\
  Multi-threaded operation is supported via the '--threads/-@' option. This only applies\
  \ to the Adjacency and Paired strategies. Additionally the only operation that is\
  \ multi-threaded is the comparisons of UMIs at the same genomic position. Running\
  \ with e.g. '--threads 8' can provide a substantial reduction in runtime when there\
  \ are many UMIs observed at the same genomic location, such as can occur in amplicon\
  \ sequencing or ultra-deep coverage data.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: assign_tag
    type:
      - 'null'
      - string
    doc: The output tag for UMI grouping.
    inputBinding:
      position: 101
      prefix: --assign-tag
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
  - id: cell_tag
    type:
      - 'null'
      - string
    doc: The tag containing the cell barcode.
    inputBinding:
      position: 101
      prefix: --cell-tag
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
  - id: edits
    type:
      - 'null'
      - int
    doc: The allowable number of edits between UMIs.
    inputBinding:
      position: 101
      prefix: --edits
  - id: family_size_histogram
    type:
      - 'null'
      - string
    doc: Optional output of tag family size counts.
    inputBinding:
      position: 101
      prefix: --family-size-histogram
  - id: grouping_metrics
    type:
      - 'null'
      - string
    doc: Optional output of UMI grouping metrics.
    inputBinding:
      position: 101
      prefix: --grouping-metrics
  - id: include_non_pf_reads
    type:
      - 'null'
      - boolean
    doc: Include non-PF reads.
    inputBinding:
      position: 101
      prefix: --include-non-pf-reads
  - id: input_bam
    type: File
    doc: The input BAM file.
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
  - id: mark_duplicates
    type:
      - 'null'
      - boolean
    doc: Turn on duplicate marking mode.
    inputBinding:
      position: 101
      prefix: --mark-duplicates
  - id: min_map_q
    type:
      - 'null'
      - int
    doc: Minimum mapping quality for mapped reads.
    inputBinding:
      position: 101
      prefix: --min-map-q
  - id: min_umi_length
    type:
      - 'null'
      - int
    doc: The minimum UMI length. If not specified then all UMIs must have the same
      length, otherwise discard reads with UMIs shorter than this length and allow
      for differing UMI lengths.
    inputBinding:
      position: 101
      prefix: --min-umi-length
  - id: output_bam
    type: string
    doc: The output BAM file.
    inputBinding:
      position: 101
      prefix: --output
  - id: raw_tag
    type:
      - 'null'
      - string
    doc: The tag containing the raw UMI.
    inputBinding:
      position: 101
      prefix: --raw-tag
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: strategy
    type: string
    doc: 'The UMI assignment strategy. Options: Identity, Edit, Adjacency, Paired.'
    inputBinding:
      position: 101
      prefix: --strategy
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use when comparing UMIs. Only recommended for amplicon
      or similar data.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory to use for temporary files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
arguments:
  - position: 50
    valueFrom: GroupReadsByUmi
outputs:
  - id: output_bam_out
    type: File
    doc: The output BAM file.
    outputBinding:
      glob: $(inputs.output_bam)
  - id: family_size_histogram_out
    type:
      - 'null'
      - File
    doc: Optional output of tag family size counts.
    outputBinding:
      glob: $(inputs.family_size_histogram)
  - id: grouping_metrics_out
    type:
      - 'null'
      - File
    doc: Optional output of UMI grouping metrics.
    outputBinding:
      glob: $(inputs.grouping_metrics)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
