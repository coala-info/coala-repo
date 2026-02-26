cwlVersion: v1.2
class: CommandLineTool
baseCommand: igv_jasmine
label: jasminesv_igv_jasmine
doc: "Jasmine IGV Screenshot Maker\n\nTool homepage: https://github.com/mkirsche/Jasmine"
inputs:
  - id: bam_filelist
    type: string
    doc: a comma-separated list of BAM files
    inputBinding:
      position: 101
  - id: bed_file
    type:
      - 'null'
      - File
    doc: a bed file with a list of ranges (use instead of vcf_file)
    inputBinding:
      position: 101
  - id: genome_file
    type: File
    doc: the FASTA file with the reference genome
    inputBinding:
      position: 101
  - id: grep_filter
    type:
      - 'null'
      - string
    doc: filter to only lines containing a given QUERY
    inputBinding:
      position: 101
  - id: info_filter
    type:
      - 'null'
      - type: array
        items: string
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
  - id: vcf_filelist
    type:
      - 'null'
      - File
    doc: the txt file with a list of input VCFs in the same order as BAM files
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jasminesv:1.1.5--hdfd78af_0
stdout: jasminesv_igv_jasmine.out
