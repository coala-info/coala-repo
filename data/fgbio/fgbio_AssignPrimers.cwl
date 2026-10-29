cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_AssignPrimers
doc: "Assigns reads to primers post-alignment. Takes in a BAM file of aligned reads\
  \ and a tab-delimited file with five\ncolumns ('chrom', 'left_start', 'left_end',\
  \ 'right_start', and 'right_end') which provide the 1-based inclusive start\nand\
  \ end positions of the primers for each amplicon. The primer file must include headers,\
  \ e.g:\n\n  chrom  left_start  left_end  right_start right_end\n  chr1   1010873\
  \     1010894   1011118     1011137\n\nOptionally, a sixth column column 'id' may\
  \ be given with a unique name for the amplicon. If not given, the coordinates\n\
  of the amplicon's primers will be used: '<chrom>:<left_start>-<left_end>,<chrom>:<right_start>:<right_end>'\n\
  \nEach read is assigned independently of its mate (for paired end reads). The primer\
  \ for a read is assumed to be located\nat the start of the read in 5' sequencing\
  \ order. Therefore, a positive strand read will use its aligned start position\n\
  to match against the amplicon's left-most coordinate, while a negative strand read\
  \ will use its aligned end position to\nmatch against the amplicon's right-most\
  \ coordinate.\n\nFor paired end reads, the assignment for mate will also be stored\
  \ in the current read, using the same procedure as\nabove but using the mate's coordinates.\
  \ This requires the input BAM have the mate-cigar (\"MC\") SAM tag. Read pairs must\n\
  have both ends mapped in forward/reverse configuration to have an assignment. Furthermore,\
  \ the amplicon assignment may\nbe different for a read and its mate. This may occur,\
  \ for example, if tiling nearby amplicons and a large deletion\noccurs over a given\
  \ primer and therefore \"skipping\" an amplicon. This may also occur if there are\
  \ translocations across\namplicons.\n\nThe output will have the following tags added:\n\
  \n  * ap: the assigned primer coordinates (ex. 'chr1:1010873-1010894')\n  * am:\
  \ the mate's assigned primer coordinates (ex. 'chr1:1011118-1011137')\n  * ip: the\
  \ assigned amplicon id\n  * im: the mate's assigned amplicon id (or '=' if the same\
  \ as the assigned amplicon)\n\nThe read sequence of the primer is not checked against\
  \ the expected reference sequence at the primer's genomic\ncoordinates.\n\nIn some\
  \ cases, large deletions within one end of a read pair may cause a primary and supplementary\
  \ alignments to be\nproduced by the aligner, with the supplementary alignment containing\
  \ the primer end of the read (5' sequencing order).\nIn this case, the primer may\
  \ not be assigned for this end of the read pair. Therefore, it is recommended to\
  \ prefer or\nchoose the primary alignment that has the closest aligned read base\
  \ to the 5' end of the read in sequencing order. For\nexample, from 'bwa' version\
  \ '0.7.16' onwards, the '-5' option may be used. Consider also using the '-q' option\
  \ for\n'bwa' '0.7.16' as well, which is standard in '0.7.17' onwards when the '-5'\
  \ option is used.\n\nThe '--annotate-all' option may be used to annotate all alignments\
  \ for a given read end (eg. R1) with the same\nassignment. If the assignment differs\
  \ across alignments for the same read end, no assignment is given. Furthermore,\
  \ if\nthe input BAM is neither 'queryname' sorted nor 'query' grouped, it will be\
  \ sorted into queryname order to assign all\nalignments cross a template simultaneously.\
  \ The output is written in coordinate order.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: amplicon_identifier_tag
    type:
      - 'null'
      - string
    doc: 'The SAM tag for the assigned amplicon identifier. [Default: ra].'
    inputBinding:
      position: 101
      prefix: --amplicon-identifier-tag
  - id: annotate_all
    type:
      - 'null'
      - boolean
    doc: 'Annotate all R1 (or R2) with same value. [Default: false].'
    inputBinding:
      position: 101
      prefix: --annotate-all
      separate: false
      valueFrom: $("=" + self)
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
  - id: input_bam
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    type: File
    doc: Input BAM file.
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
  - id: mate_amplicon_identifier_tag
    type:
      - 'null'
      - string
    doc: 'The SAM tag for the mate''s assigned amplicon identifier. [Default: ma].'
    inputBinding:
      position: 101
      prefix: --mate-amplicon-identifier-tag
  - id: mate_primer_coordinates_tag
    type:
      - 'null'
      - string
    doc: 'The SAM tag for the mate''s assigned primer coordinate. [Default: mp].'
    inputBinding:
      position: 101
      prefix: --mate-primer-coordinates-tag
  - id: metrics_file
    type: string
    doc: Output metrics file.
    inputBinding:
      position: 101
      prefix: --metrics
  - id: output_bam
    type: string
    doc: Output BAM file.
    inputBinding:
      position: 101
      prefix: --output
  - id: primer_coordinates_tag
    type:
      - 'null'
      - string
    doc: 'The SAM tag for the assigned primer coordinate. [Default: rp].'
    inputBinding:
      position: 101
      prefix: --primer-coordinates-tag
  - id: primers
    type: File
    doc: File with primer locations.
    inputBinding:
      position: 101
      prefix: --primers
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: slop
    type:
      - 'null'
      - int
    doc: 'Match to primer locations +/- this many bases. [Default: 5].'
    inputBinding:
      position: 101
      prefix: --slop
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory to use for temporary files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
  - id: unclipped_coordinates
    type:
      - 'null'
      - boolean
    doc: 'True to based on the unclipped coordinates (adjust based on hard/soft clipping),
      otherwise the aligned bases [Default: true].'
    inputBinding:
      position: 101
      prefix: --unclipped-coordinates
      separate: false
      valueFrom: $("=" + self)
arguments:
  - position: 50
    valueFrom: AssignPrimers
outputs:
  - id: output_bam_out
    type: File
    doc: Output BAM file.
    outputBinding:
      glob: $(inputs.output_bam)
  - id: metrics_out
    type: File
    doc: Output metrics file.
    outputBinding:
      glob: $(inputs.metrics_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
