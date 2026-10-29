cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_FindSwitchbackReads
doc: "Finds reads where a template switch occurred during library construction. Some\
  \ library construction methods, notably\nultra-low-input shotgun methods, are prone\
  \ to template switching events that create molecules (templates, inserts) that\n\
  instead of being a linear copy of a segment of genomic DNA, instead are chimeras\
  \ formed by starting on one strand of\nDNA and then, switching to the opposite strand.\
  \ Frequently when the switch occurs there may be a small offset between\nwhere the\
  \ first strand was departed and the opposite strand joined.\n\nAlgorithm\n\nTemplates\
  \ that contain strand switch events (switch-backs) are found by this tool in two\
  \ different ways:\n\n  1. By looking at reads that contain soft-clipped bases at\
  \ their 5' end that, when reverse complemented, matches the\n     genome proximal\
  \ to the 5'-most mapped base of the read. We call these matches \"read based switchbacks\"\
  . Finding read\n     based switchbacks is based on several parameters:\n    1. 'max-offset'\
  \ controls how far away to search for the reverse-complemented sequence. The default\
  \ value of '35'\n       allows matches to be found when the soft-clipped sequence\
  \ matches the genome starting at most 35bp from the 5'\n       mapped position of\
  \ the read, and reading in the opposite direction.\n    2. 'min-length' controls\
  \ the minimum number of soft-clipped bases that must exist to trigger the search.\
  \ Given that\n       the search looks at '2 * max-offset' locations (default=70)\
  \ it is important that 'min-length' is set such that\n       '4^min-length >> 2\
  \ * 'max-offset` in order to avoid false positives.\n    3. 'max-error-rate' allows\
  \ for some mismatches to exist between the soft-clipped sequence and the genome\
  \ when\n       matching.\n  2. By identifying templates with 'FF' or 'RR' (aka tandem)\
  \ orientation where it is surmised that the template switch\n     occurred in the\
  \ un-sequenced region of the template between R1 and R2. We call these 'tandem based\
  \ switchbacks'. This\n     is controlled by a single parameter, 'max-gap', which\
  \ causes the tool to only identify a tandem read pair as a\n     switch-back if\
  \ the gap between the end of the first read and the start of the second read is\
  \ '+/- max-gap'.\n\nBy default, when a switch-back template is identified, the primary\
  \ reads are made unmapped (and the original alignment\nstored in the OA tag) and\
  \ all secondary and supplementary alignments are discarded. This can be disabled\
  \ with the\n'--dont-unmap' or '-d' option.\n\nAll reads from a switch-back template\
  \ are also tagged with an 'sb' tag that describes the nature of the switchback.\
  \ If\nthe template was identified base on soft-clipped sequence within a read the\
  \ format is:\n\n'sb:Z:r,[read|mate],{offset},{length}'\n\nIf the template is identified\
  \ due to it's tandem pair orientation then the format is:\n\n'sb:Z:t,{gap}'\n\n\
  Inputs and Outputs\n\nThe tool takes as input a SAM or BAM file, and by default\
  \ consumes from 'stdin'. The primary output is also a SAM or\nBAM file, and defaults\
  \ to compressed BAM on 'stdout'. This allows the tool to be run immediately after\
  \ an aligner in a\npipe, e.g. 'bwa mem ref.fa r1.fq r2.fq | fgbio -Xmx8g --ref=ref.fa\
  \ | ...'.\n\nIf the input is neither 'queryname' sorted nor 'queryname' grouped\
  \ (i.e. all reads with the same name grouped together)\nit will be sorted into 'queryname'\
  \ order by the tool before processing.\n\nBy default the output BAM is produced\
  \ in the order the reads were processed (i.e. the input ordering or queryname\n\
  sorted if sorting was required). This can be overridden with the '--sort-order'\
  \ option.\n\nA number of text files are also produced if the '--metrics' option\
  \ is specified. E.g. when specifying\n'--metrics=s1.switchback' the following files\
  \ are produced:\n\n  1. 's1.switchback.summary.txt': A table of summary metrics\
  \ describing the number of reads, switchbacks, etc.\n  2. 's1.switchback.lengths.txt':\
  \ A table of the distribution of observed switchback lengths in read-based switchbacks.\n\
  \  3. 's1.switchback.offsets.txt': A table of the distribution of observed offsets\
  \ in read-based switchbacks.\n  4. 's1.switchback.gaps.txt': A table of the distribution\
  \ of gap lengths in tampl\n  5. 's1.switchback.plots.pdf': A PDF containing plots\
  \ of the distributions from 2-4.\n\nNote: because this tool accesses the reference\
  \ genome in a random manner it pre-loads the entire reference fasta into\nmemory.\
  \ As a result the tool is best run with '-Xmx8g' to give it sufficient memory.\n\
  \nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
      separate: false
      valueFrom: $("=" + self)
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
  - id: dont_unmap
    type:
      - 'null'
      - boolean
    doc: 'IF true, do NOT unmap reads from switchback templates. [Default: false].'
    inputBinding:
      position: 101
      prefix: --dont-unmap
      separate: false
      valueFrom: $("=" + self)
  - id: input_bam
    type: File
    doc: 'Input BAM file. [Default: /dev/stdin].'
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
  - id: max_error_rate
    type:
      - 'null'
      - double
    doc: 'Maximum mismatch error rate of switchback match to genome. [Default: 0.1].'
    inputBinding:
      position: 101
      prefix: --max-error-rate
  - id: max_gap
    type:
      - 'null'
      - int
    doc: 'Maximum gap between R1 and R2 of tandem reads to call a template a switchback.
      Set to 0 to disable tandem-based checks. [Default: 500].'
    inputBinding:
      position: 101
      prefix: --max-gap
  - id: max_offset
    type:
      - 'null'
      - int
    doc: 'Maximum offset between end the two segments of the read on the reference.
      Set to 0 to disable read-based checks. [Default: 35].'
    inputBinding:
      position: 101
      prefix: --max-offset
  - id: metrics_prefix
    type:
      - 'null'
      - string
    doc: Metrics output file.
    inputBinding:
      position: 101
      prefix: --metrics
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'Minimum match length of the switched back segment. [Default: 6].'
    inputBinding:
      position: 101
      prefix: --min-length
  - id: output_bam
    type: string
    doc: 'Output BAM file. [Default: /dev/stdout].'
    inputBinding:
      position: 101
      prefix: --output
  - id: ref_fasta
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: true
    type: File
    doc: Reference genome fasta file.
    inputBinding:
      position: 101
      prefix: --ref
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: sort_order
    type:
      - 'null'
      - string
    doc: 'Output sort order. Options: Coordinate, Queryname, Random, RandomQuery,
      TemplateCoordinate, Unsorted, Unknown.'
    inputBinding:
      position: 101
      prefix: --sort-order
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
    valueFrom: FindSwitchbackReads
outputs:
  - id: output_bam_out
    type: File
    doc: Output BAM file.
    outputBinding:
      glob: $(inputs.output_bam)
  - id: metrics_out
    type:
      - 'null'
      - type: array
        items: File
    doc: Metrics output files, when --metrics is given.
    outputBinding:
      glob: $(inputs.metrics_prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
