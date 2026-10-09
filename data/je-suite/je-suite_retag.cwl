cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - je
  - retag
label: je-suite_retag
doc: "Extracts barcode and UMI sequence(s) embedded in read names and tags reads with the proper BAM tag.\n\
  \nTool homepage: https://gbcs.embl.de/Je"
inputs:
  - id: input
    type: File
    doc: Input SAM/BAM file
    inputBinding:
      position: 1
      prefix: INPUT=
      separate: false
  - id: output
    type: string
    doc: Output SAM/BAM file
    inputBinding:
      position: 2
      prefix: OUTPUT=
      separate: false
  - id: bc_slot
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: BC_SLOT=
          separate: false
    doc: 'Where to find the BARCODE(s) in the read name once read name has been tokenized using the SPLIT
      character (e.g. '':''). This option can be specified multiple time when multiple BARCODES are present
      in read header. Counting starts at 1 and negative numbers can be used to start counting from the
      end (last token is ''-1''). BARCODE(s) extracted from read name are used to assemble a ''BC:Z:GATCCTAG''
      tag (BC is default, see BC_TAG). Following SAM specifications, in the case of multiple barcodes,
      all the barcodes are concatenated using a hyphen (''-'') between the barcodes. The order of concatenation
      follows the order of BC_SLOT in the command line. For example, consider the following read name
      that lists 3 different barcodes in the end : HISEQ:44:C6KC0ANXX:8:2112:20670:79594:CGATGTTT:GATCCTAG:AAGGTACG
      to indicate that the three slots contain barcodes, use BC_SLOT=-1 BC_SLOT=-2 BC_SLOT=-3 ; which
      will result as BC:Z:AAGGTACG-GATCCTAG-CGATGTTT if only the 2 last ones should be considered, use
      BC_SLOT=-1 BC_SLOT=-2 ; which will result as BC:Z:AAGGTACG-GATCCTAG Note that BC_SLOT order matters
      as : BC_SLOT=-2 BC_SLOT=-1 ; would result as BC:Z:GATCCTAG-AAGGTACG'
    inputBinding:
      position: 3
  - id: umi_slot
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: UMI_SLOT=
          separate: false
    doc: 'Where to find the UMI(s) in the read name once read name has been tokenized using the SPLIT
      character (e.g. '':''). This option can be specified multiple time when multiple UMIs are present
      in read header. Counting starts at 1 and negative numbers can be used to start counting from the
      end (last token is ''-1''). UMI(s) extracted from read name are used to assemble both a RX and OX
      tag e.g. ''RX:Z:GATCCTAG'' tag. Following SAM specifications, in the case of multiple UMIs, all
      the UMIs are concatenated using a hyphen (''-''). The order of concatenation follows the order of
      UMI_SLOT in the command line. For example, consider the following read name that lists 3 different
      sequence codes in the end : HISEQ:44:C6KC0ANXX:8:2112:20670:79594:CGATGTTT:GATCCTAG:AAGGTACG to
      indicate that the 2 last slots contain UMIs, use UMI_SLOT=-1 UMI_SLOT=-2 ; which will result as
      RX:Z:AAGGTACG-GATCCTAG Note that UMI_SLOT order matters as : UMI_SLOT=-2 UMI_SLOT=-1 ; would result
      as RX:Z:GATCCTAG-AAGGTACG'
    inputBinding:
      position: 4
  - id: clustered_codes_file
    type:
      - 'null'
      - File
    doc: 'Group of barcodes (clusters) for on-the-fly correction of the BARCODEs. This file contains mapping
      between the barcodes sequences as originally found in the FASTQ reads (and in the read name of the
      input BAM) and the corrected sample barcode sequences (e.g. as identified by clustering with mismatches
      using tools like starcode or vsearch ) that should be written in the BC tag in place of the original
      sequence. If provided, the BARCODE sequence(s) extracted from read name are converted to the ''real''
      barcodes according to the mapping described in this file. If the sequence is not found in the supplied
      mapping file, the read is either trashed or kept (according to option KEEP_UNASSIGNED_BARCODES),
      in which case the value defined by UNASSIGNED_BARCODE_VALUE is used. Format: two column text file,
      one cluster per line with the real barcode in the first line and the comma separated list of codes
      in the second column i.e. : ACTGTAC ACTCTAC,TCTGTAC,ACTGTAG All the codes MUST have the same length'
    inputBinding:
      position: 5
      prefix: CLUSTERED_CODES_FILE=
      separate: false
  - id: keep_unassigned_barcodes
    type:
      - 'null'
      - boolean
    doc: 'Should read be keep when no mapping was defined for the orginal barcode sequence in provided
      CLUSTERED_CODES_FILE. If false, the read is not written in output file. Possible values: {true,
      false}'
    inputBinding:
      position: 6
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "KEEP_UNASSIGNED_BARCODES="
        + self; }
  - id: unassigned_barcode_value
    type:
      - 'null'
      - string
    doc: Value to use for the BARCODE tag when CLUSTERED_CODES_FILE was provided and no mapping was defined
      for the orginal barcode sequence.
    inputBinding:
      position: 7
      prefix: UNASSIGNED_BARCODE_VALUE=
      separate: false
  - id: trim_headers
    type:
      - 'null'
      - boolean
    doc: 'Should barcode/UMIs information be removed from read names in the output BAM ? Possible values:
      {true, false}'
    inputBinding:
      position: 8
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "TRIM_HEADERS=" +
        self; }
  - id: tslots
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: TSLOTS=
          separate: false
    doc: 'Where to find *all* barcode(s) and UMIs in the read name once has been tokenized using the SPLIT
      character (e.g. '':''). This option is only considered when TRIM_HEADERS=true and should only be
      used when UMI_SLOT and BC_SLOT do not describe all the slots that should be trimmed. When TSLOTS
      is ommited while TRIM_HEADERS=true, the values of UMI_SLOT and BC_SLOT apply. IMPORTANT : counting
      starts at 1 and negative numbers can be used to start counting from the end. See UMI_SLOT help for
      examples.'
    inputBinding:
      position: 9
  - id: split_char
    type:
      - 'null'
      - string
    doc: Character to use to split up the read header line, default is ':'.
    inputBinding:
      position: 10
      prefix: SPLIT_CHAR=
      separate: false
  - id: bc_tag
    type:
      - 'null'
      - string
    doc: SAM Tag to use to store barcode(s) sequences extracted from barcode slots (BC by default). Do
      not change unless you have good reasons to.
    inputBinding:
      position: 11
      prefix: BC_TAG=
      separate: false
  - id: qt_tag
    type:
      - 'null'
      - string
    doc: SAM Tag to use to store barcode(s) quality score extracted from barcode slots (QT by default).
      Do not change unless you have good reasons to.
    inputBinding:
      position: 12
      prefix: QT_TAG=
      separate: false
  - id: with_rx
    type:
      - 'null'
      - boolean
    doc: 'Should the RX (and QX when relevant) SAM Tag(s) be used to store UMI(s) sequence (and quality)
      extracted from UMI slots. Set to FALSE if you don''t want these tags to be set. Possible values:
      {true, false}'
    inputBinding:
      position: 13
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "WITH_RX=" + self;
        }
  - id: with_ox
    type:
      - 'null'
      - boolean
    doc: 'Should the OX (and BZ when relevant) SAM Tag(s) be used to store UMI(s) sequence (and quality)
      extracted from UMI slots. Set to FALSE if you don''t want these tags to be set. Possible values:
      {true, false}'
    inputBinding:
      position: 14
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "WITH_OX=" + self;
        }
  - id: umi_seq_tag
    type:
      - 'null'
      - string
    doc: SAM Tag to use to store original UMI(s) sequence extracted from UMI slots (instead of RX / OX)
    inputBinding:
      position: 15
      prefix: UMI_SEQ_TAG=
      separate: false
  - id: umi_qual_tag
    type:
      - 'null'
      - string
    doc: SAM Tag to use to store original UMI(s) sequence extracted from UMI slots (instead of QX / BZ)
    inputBinding:
      position: 16
      prefix: UMI_QUAL_TAG=
      separate: false
  - id: add_rg
    type:
      - 'null'
      - boolean
    doc: 'Should a read group be created for each barcode. This option is only considered when providing
      a CLUSTERED_CODES_FILE. Possible values: {true, false}'
    inputBinding:
      position: 17
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "ADD_RG=" + self;
        }
  - id: rgpl
    type:
      - 'null'
      - string
    doc: Read Group platform (e.g. illumina, solid) ; only considered when RG=true
    inputBinding:
      position: 18
      prefix: RGPL=
      separate: false
  - id: rgpg
    type:
      - 'null'
      - string
    doc: Read Group program group; only considered when RG=true
    inputBinding:
      position: 19
      prefix: RGPG=
      separate: false
  - id: program_record_id
    type:
      - 'null'
      - string
    doc: The program record ID for the @PG record(s) created by this program. Set to null to disable PG
      record creation. This string may have a suffix appended to avoid collision with other program record
      IDs.
    inputBinding:
      position: 20
      prefix: PROGRAM_RECORD_ID=
      separate: false
  - id: program_group_version
    type:
      - 'null'
      - string
    doc: Value of VN tag of PG record to be created. If not specified, the version will be detected automatically.
    inputBinding:
      position: 21
      prefix: PROGRAM_GROUP_VERSION=
      separate: false
  - id: program_group_command_line
    type:
      - 'null'
      - string
    doc: Value of CL tag of PG record to be created. If not supplied the command line will be detected
      automatically.
    inputBinding:
      position: 22
      prefix: PROGRAM_GROUP_COMMAND_LINE=
      separate: false
  - id: program_group_name
    type:
      - 'null'
      - string
    doc: Value of PN tag of PG record to be created.
    inputBinding:
      position: 23
      prefix: PROGRAM_GROUP_NAME=
      separate: false
  - id: comment
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: COMMENT=
          separate: false
    doc: 'Comment(s) to include in the output file''s header.[help] je retag: ok via je retag --help (--help=ok,
      -h=ok, -help=ok, (no args)=ok)'
    inputBinding:
      position: 24
outputs:
  - id: output_file
    type: File
    doc: Output file written to the path given in output
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/je-suite:2.0.RC--0
