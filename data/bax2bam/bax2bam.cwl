cwlVersion: v1.2
class: CommandLineTool
baseCommand: bax2bam
label: bax2bam
doc: "bax2bam converts the legacy PacBio basecall format (bax.h5) into the BAM basecall
  format.\n\nTool homepage: https://github.com/PacificBiosciences/bax2bam"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files which should be from the same movie (movie.1.bax.h5 movie.2.bax.h5
      ...)
    inputBinding:
      position: 1
  - id: allow_unrecognized_chemistry_triple
    type:
      - 'null'
      - boolean
    doc: By default, bax2bam only allows the conversion of files with chemistries
      that are supported in SMRT Analysis 3. Set this flag to disable the strict check
      and allow generation of BAM files containing legacy chemistries.
    inputBinding:
      position: 102
      prefix: --allowUnrecognizedChemistryTriple
  - id: ccs
    type:
      - 'null'
      - boolean
    doc: Output CCS sequences (requires ccs.h5 input)
    inputBinding:
      position: 102
      prefix: --ccs
  - id: fofn
    type:
      - 'null'
      - File
    doc: File-of-file-names containing a list of input files
    inputBinding:
      position: 102
      prefix: --fofn
  - id: hqregion
    type:
      - 'null'
      - boolean
    doc: Output HQ regions
    inputBinding:
      position: 102
      prefix: --hqregion
  - id: internal
    type:
      - 'null'
      - boolean
    doc: Output BAMs in internal mode. Currently this indicates that non-sequencing
      ZMWs should be included in the output scraps BAM file, if applicable.
    inputBinding:
      position: 102
      prefix: --internal
  - id: losslessframes
    type:
      - 'null'
      - boolean
    doc: Store full, 16-bit IPD/PulseWidth data, instead of (default) downsampled,
      8-bit encoding.
    inputBinding:
      position: 102
      prefix: --losslessframes
  - id: polymeraseread
    type:
      - 'null'
      - boolean
    doc: Output full polymerase read
    inputBinding:
      position: 102
      prefix: --polymeraseread
  - id: pulsefeatures
    type:
      - 'null'
      - string
    doc: Comma-separated list of desired pulse features (DeletionQV, DeletionTag,
      InsertionQV, IPD, PulseWidth, MergeQV, SubstitutionQV, SubstitutionTag)
    inputBinding:
      position: 102
      prefix: --pulsefeatures
  - id: subread
    type:
      - 'null'
      - boolean
    doc: Output subreads (default)
    inputBinding:
      position: 102
      prefix: --subread
  - id: xml
    type:
      - 'null'
      - File
    doc: DataSet XML file containing a list of movie names
    inputBinding:
      position: 102
      prefix: --xml
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix of output filenames. Movie name will be used if no prefix provided
    outputBinding:
      glob: $(inputs.output_prefix)
  - id: output_xml
    type:
      - 'null'
      - File
    doc: Explicit output XML name. If none provided via this arg, bax2bam will use
      -o prefix (<prefix>.dataset.xml). If that is not specified either, the output
      XML filename will be <moviename>.dataset.xml
    outputBinding:
      glob: $(inputs.output_xml)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bax2bam:0.0.11--0
