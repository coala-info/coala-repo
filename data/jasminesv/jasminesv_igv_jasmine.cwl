cwlVersion: v1.2
class: CommandLineTool
baseCommand: igv_jasmine
label: jasminesv_igv_jasmine
doc: "Jasmine IGV Screenshot Maker\n\nTool homepage: https://github.com/mkirsche/Jasmine"
inputs:
  - id: bam_filelist
    type: File
    doc: a text file listing the BAM files (one per line, in the same order as the input VCFs); the paths must
      resolve in the working directory, see staged_files
    inputBinding:
      position: 101
      prefix: bam_filelist=
      separate: false
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: BAM files (with their .bai) named in bam_filelist, staged in the working directory so the names resolve.
  - id: bed_file
    type:
      - 'null'
      - File
    doc: a bed file with a list of ranges (use instead of vcf_file)
    inputBinding:
      position: 101
      prefix: bed_file=
      separate: false
  - id: genome_file
    type: File
    doc: the FASTA file with the reference genome
    inputBinding:
      position: 101
      prefix: genome_file=
      separate: false
  - id: grep_filter
    type:
      - 'null'
      - string
    doc: filter to only lines containing a given QUERY
    inputBinding:
      position: 101
      prefix: grep_filter=
      separate: false
  - id: info_filter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: info_filter=
          separate: false
    doc: filter by an INFO field value (multiple allowed) e.g., 
      info_filter=SUPP_VEC,101
    inputBinding:
      position: 101
  - id: normalize_chr_names
    type:
      - 'null'
      - boolean
    doc: normalize the VCF chromosome names to strip "chr"
    inputBinding:
      position: 101
      prefix: --normalize_chr_names
  - id: out_prefix
    type: string
    doc: the prefix of the output directory and filenames
    inputBinding:
      position: 101
      prefix: out_prefix=
      separate: false
  - id: precise
    type:
      - 'null'
      - boolean
    doc: require variant to contain "PRECISE" as an INFO field
    inputBinding:
      position: 101
      prefix: --precise
  - id: specific
    type:
      - 'null'
      - boolean
    doc: shorthand for info_filter=IS_SPECIFIC,1
    inputBinding:
      position: 101
      prefix: --specific
  - id: squish
    type:
      - 'null'
      - boolean
    doc: squishes tracks to fit more reads
    inputBinding:
      position: 101
      prefix: --squish
  - id: svg
    type:
      - 'null'
      - boolean
    doc: save as an SVG instead of a PNG
    inputBinding:
      position: 101
      prefix: --svg
  - id: vcf_file
    type: File
    doc: the VCF file with merged SVs
    inputBinding:
      position: 101
      prefix: vcf_file=
      separate: false
  - id: vcf_filelist
    type:
      - 'null'
      - File
    doc: the txt file with a list of input VCFs in the same order as BAM files
    inputBinding:
      position: 101
      prefix: vcf_filelist=
      separate: false
requirements:
  - class: InitialWorkDirRequirement
    listing: |
      ${ return inputs.staged_files ? inputs.staged_files : []; }
  - class: InlineJavascriptRequirement
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_prefix_dir
    type: Directory
    doc: Output directory named with the out_prefix
    outputBinding:
      glob: $(inputs.out_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jasminesv:1.1.5--hdfd78af_0
stdout: jasminesv_igv_jasmine.out
