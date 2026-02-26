cwlVersion: v1.2
class: CommandLineTool
baseCommand: bgenix
label: bgen-cpp_bgenix
doc: "OPTIONS:\n\nTool homepage: https://enkre.net/cgi-bin/code/bgen/"
inputs:
  - id: bgen_file
    type:
      - 'null'
      - File
    doc: Path of bgen file to operate on.  (An optional form where "-g" is 
      omitted and the filename is specified as the first argument, i.e. bgenix 
      <filename>, can also be used).
    inputBinding:
      position: 101
      prefix: -g
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: Specify that bgenix should overwrite existing index file if it exists.
    inputBinding:
      position: 101
      prefix: -clobber
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Zlib compression level to use when transcoding to BGEN v1.1 format.  
      Defaults to "9".
    default: 9
    inputBinding:
      position: 101
      prefix: -compression-level
  - id: exclude_range
    type:
      - 'null'
      - type: array
        items: string
    doc: Exclude variants in the specified genomic interval from the output. See
      the description of -in-cl-range for details.If this is specified multiple 
      times, variants in any of the specified ran-ges will be excluded.
    inputBinding:
      position: 101
      prefix: -excl-range
  - id: exclude_rsids
    type:
      - 'null'
      - type: array
        items: string
    doc: Exclude variants with the specified rsid(s) from the output. See the 
      description of -incl-rang-e for details.If this is specified multiple 
      times, variants with any of the specified ids will be excluded.
    inputBinding:
      position: 101
      prefix: -excl-rsids
  - id: include_range
    type:
      - 'null'
      - type: array
        items: string
    doc: Include variants in the specified genomic interval in the output. (If 
      the argument is the name of a valid readable file, the file will be opened
      and whitespace-separated rsids read from it instead.) Each interval must 
      be of the form <chr>:<pos1>-<pos2> where <chr> is a chromosome id-entifier  
      and pos1 and pos2 are positions with pos2 >= pos1.  One of pos1 and pos2 
      can also be omitted, in which case the range extends to the start or end 
      of the chromosome as appropriate.  Position ranges are treated as closed 
      (i.e. <pos1> and <pos2> are included in the range).If th-is is specified 
      multiple times, variants in any of the specified ranges will be included.
    inputBinding:
      position: 101
      prefix: -incl-range
  - id: include_rsids
    type:
      - 'null'
      - type: array
        items: string
    doc: Include variants with the specified rsid(s) in the output. If the 
      argument is the name of a va-lid readable file, the file will be opened 
      and whitespace-separated rsids read from it instead.I-f this is specified 
      multiple times, variants with any of the specified ids will be included.
    inputBinding:
      position: 101
      prefix: -incl-rsids
  - id: index
    type:
      - 'null'
      - boolean
    doc: Specify that bgenix should build an index for the BGEN file specified 
      by the -g option.
    inputBinding:
      position: 101
      prefix: -index
  - id: index_file
    type:
      - 'null'
      - File
    doc: Path of index file to use. If not specified, bgenix will look for an 
      index file of the form '<f-ilename>.bgen.bgi'  where '<filename>.bgen' is 
      the bgen file name specified by the -g option.
    inputBinding:
      position: 101
      prefix: -i
  - id: list
    type:
      - 'null'
      - boolean
    doc: Suppress BGEN output; instead output a list of variants.
    inputBinding:
      position: 101
      prefix: -list
  - id: table
    type:
      - 'null'
      - string
    doc: Specify the table (or view) that bgenix should read the file index 
      from. This only affects rea-ding the index file.  The named table or view 
      should have the same schema as the Variant table written by bgenix on 
      index creation.  Defaults to "Variant".
    default: Variant
    inputBinding:
      position: 101
      prefix: -table
  - id: transcode_v11
    type:
      - 'null'
      - boolean
    doc: Transcode to BGEN v1.1 format.  (Currently, this is only supported if 
      the input is in BGEN v1.2 format with 8 bits per probability, all samples 
      are diploid, and all variants biallelic).
    inputBinding:
      position: 101
      prefix: -v11
  - id: transcode_vcf
    type:
      - 'null'
      - boolean
    doc: Transcode to VCF format.  VCFs will have GP field (or 'HP' field for 
      phased data), and a GT fi-eld inferred from the probabilities by 
      threshholding.
    inputBinding:
      position: 101
      prefix: -vcf
  - id: with_rowid
    type:
      - 'null'
      - boolean
    doc: Create an index file that does not use the 'WITHOUT ROWID' feature. 
      These are suitable for use with sqlite versions < 3.8.2, but may be less 
      efficient.
    inputBinding:
      position: 101
      prefix: -with-rowid
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bgen-cpp:1.1.7--h5ca1c30_0
stdout: bgen-cpp_bgenix.out
