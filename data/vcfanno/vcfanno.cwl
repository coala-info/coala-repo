cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfanno
label: vcfanno
doc: "vcfanno version 0.3.7 [built with go1.24.6]\n\nTool homepage: https://github.com/brentp/vcfanno"
inputs:
  - id: config
    type: File
    doc: TOML configuration file that lists the annotation files and the fields
      to add
    inputBinding:
      position: 101
  - id: input_vcf
    type: File
    doc: VCF file to annotate (plain or bgzipped)
    inputBinding:
      position: 102
  - id: annotation_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Annotation files named in the config (and their .tbi or .csi indexes),
      staged into the working directory so the relative names in the config
      resolve
  - id: base_path
    type:
      - 'null'
      - string
    doc: optional base-path to prepend to annotation files in the config
    inputBinding:
      position: 1
      prefix: -base-path
  - id: ends
    type:
      - 'null'
      - boolean
    doc: annotate the start and end as well as the interval itself.
    inputBinding:
      position: 1
      prefix: -ends
  - id: lua
    type:
      - 'null'
      - File
    doc: optional path to a file containing custom lua functions to be used as 
      ops
    inputBinding:
      position: 1
      prefix: -lua
  - id: permissive_overlap
    type:
      - 'null'
      - boolean
    doc: annotate with an overlapping variant even it doesn't share the same ref
      and alt alleles. Default is to require exact match between variants.
    inputBinding:
      position: 1
      prefix: -permissive-overlap
  - id: processes
    type:
      - 'null'
      - int
    doc: number of processes to use.
    inputBinding:
      position: 1
      prefix: -p
outputs:
  - id: annotated_vcf
    type: stdout
    doc: Annotated VCF written to standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.annotation_files)
      - $(inputs.lua)
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfanno:0.3.7--he881be0_0
stdout: vcfanno.vcf
