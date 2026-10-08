cwlVersion: v1.2
class: CommandLineTool
baseCommand: glnexus_cli
label: glnexus_glnexus_cli
doc: "Merge and joint-call input gVCF files, emitting multi-sample BCF on standard
  output.\n\nTool homepage: https://github.com/dnanexus-rnd/GLnexus"
inputs:
  - id: input_vcfs
    type:
      type: array
      items: File
    doc: Input gVCF files
    inputBinding:
      position: 1
  - id: bed_file
    type:
      - 'null'
      - File
    doc: 'three-column BED file with ranges to analyze (if neither --range nor --bed:
      use full length of all contigs)'
    inputBinding:
      position: 102
      prefix: --bed
  - id: config
    type:
      - 'null'
      - string
    doc: 'configuration preset name or .yml filename (default: gatk)'
    inputBinding:
      position: 102
      prefix: --config
  - id: list_files
    type:
      - 'null'
      - boolean
    doc: expect given files to contain lists of gVCF filenames, one per line
    inputBinding:
      position: 102
      prefix: --list
  - id: mem_gbytes
    type:
      - 'null'
      - float
    doc: 'memory budget, in gbytes (default: most of system memory)'
    inputBinding:
      position: 102
      prefix: --mem-gbytes
  - id: more_pl
    type:
      - 'null'
      - boolean
    doc: include PL from reference bands and other cases omitted by default
    inputBinding:
      position: 102
      prefix: --more-PL
  - id: scratch_directory
    type:
      - 'null'
      - string
    doc: "scratch directory path (mustn't already exist; default: ./GLnexus.DB)"
    inputBinding:
      position: 102
      prefix: --dir
  - id: squeeze
    type:
      - 'null'
      - boolean
    doc: reduce pVCF size by suppressing detail in cells derived from reference 
      bands
    inputBinding:
      position: 102
      prefix: --squeeze
  - id: threads
    type:
      - 'null'
      - int
    doc: 'thread budget (default: all hardware threads)'
    inputBinding:
      position: 102
      prefix: --threads
  - id: trim_uncalled_alleles
    type:
      - 'null'
      - boolean
    doc: remove alleles with no output GT calls in postprocessing
    inputBinding:
      position: 102
      prefix: --trim-uncalled-alleles
  - id: output_name
    type: string
    default: glnexus.bcf
    doc: Name of the multi-sample BCF file that receives the standard output
outputs:
  - id: output
    type: File
    doc: Multi-sample BCF file with the joint calls
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glnexus:1.4.1--h17e8430_5
stdout: $(inputs.output_name)
