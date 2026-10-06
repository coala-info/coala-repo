cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - bam2FastQ
label: bamutil_bam2FastQ
doc: "Convert the specified BAM file to fastQs.\n\nTool homepage: http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: in
    type: File
    doc: the SAM/BAM file to convert to FastQ
    inputBinding:
      position: 1
      prefix: --in
  - id: read_name
    type:
      - 'null'
      - boolean
    doc: Process the BAM as readName sorted instead of coordinate if the header does
      not indicate a sort order.
    inputBinding:
      position: 1
      prefix: --readName
  - id: split_rg
    type:
      - 'null'
      - boolean
    doc: Split into RG specific fastqs.
    inputBinding:
      position: 1
      prefix: --splitRG
  - id: qual_field
    type:
      - 'null'
      - string
    doc: Use the base quality from the specified tag rather than from the Quality
      field (default)
    inputBinding:
      position: 1
      prefix: --qualField
  - id: merge
    type:
      - 'null'
      - boolean
    doc: Generate 1 interleaved (merged) FASTQ for paired-ends (unpaired in a separate
      file)
    inputBinding:
      position: 1
      prefix: --merge
  - id: ref_file
    type:
      - 'null'
      - File
    doc: Reference file for converting '=' in the sequence to the actual base
    inputBinding:
      position: 1
      prefix: --refFile
  - id: first_rn_ext
    type:
      - 'null'
      - string
    doc: read name extension to use for first read in a pair (default "/1")
    inputBinding:
      position: 1
      prefix: --firstRNExt
  - id: second_rn_ext
    type:
      - 'null'
      - string
    doc: read name extension to use for second read in a pair (default "/2")
    inputBinding:
      position: 1
      prefix: --secondRNExt
  - id: rn_plus
    type:
      - 'null'
      - boolean
    doc: Add the Read Name/extension to the '+' line of the fastq records
    inputBinding:
      position: 1
      prefix: --rnPlus
  - id: no_reverse_comp
    type:
      - 'null'
      - boolean
    doc: Do not reverse complement reads marked as reverse
    inputBinding:
      position: 1
      prefix: --noReverseComp
  - id: region
    type:
      - 'null'
      - string
    doc: Only convert reads containing the specified region/nucleotide (chr:pos:base)
    inputBinding:
      position: 1
      prefix: --region
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Compress the output FASTQ files using gzip
    inputBinding:
      position: 1
      prefix: --gzip
  - id: out_base
    type: string
    doc: Base output name for generated output files
    inputBinding:
      position: 1
      prefix: --outBase
    default: reads
  - id: first_out
    type:
      - 'null'
      - string
    doc: Output name for the first in pair file (over-rides outBase)
    inputBinding:
      position: 1
      prefix: --firstOut
  - id: second_out
    type:
      - 'null'
      - string
    doc: Output name for the second in pair file (over-rides outBase)
    inputBinding:
      position: 1
      prefix: --secondOut
  - id: unpaired_out
    type:
      - 'null'
      - string
    doc: Output name for unpaired reads (over-rides outBase)
    inputBinding:
      position: 1
      prefix: --unpairedOut
  - id: noeof
    type:
      - 'null'
      - boolean
    doc: Do not expect an EOF block on a bam file.
    inputBinding:
      position: 1
      prefix: --noeof
  - id: params
    type:
      - 'null'
      - boolean
    doc: Print the parameter settings
    inputBinding:
      position: 1
      prefix: --params
  - id: no_phone_home
    type:
      - 'null'
      - boolean
    doc: Do not send usage information (phone home)
    inputBinding:
      position: 1
      prefix: --noPhoneHome
  - id: phone_home_thinning
    type:
      - 'null'
      - int
    doc: Phone home thinning percentage [50]
    inputBinding:
      position: 1
      prefix: --phoneHomeThinning
outputs:
  - id: fastq_files
    type: File[]
    doc: FASTQ files (first/second in pair, unpaired, interleaved or per read group)
    outputBinding:
      glob: $(inputs.out_base)*
  - id: named_fastq_files
    type: File[]
    doc: FASTQ files written with --firstOut, --secondOut or --unpairedOut
    outputBinding:
      glob: $([inputs.first_out, inputs.second_out, inputs.unpaired_out].filter(function(x){return
        x;}))
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.ref_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
