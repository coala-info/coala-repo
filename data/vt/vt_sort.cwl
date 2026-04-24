cwlVersion: v1.2
class: CommandLineTool
baseCommand: vt_sort
label: vt_sort
doc: "Sorts a VCF or BCF or VCF.GZ file.\n\nTool homepage: https://github.com/Aikoyori/ProgrammingVTuberLogos"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF/VCF.GZ/BCF file
    inputBinding:
      position: 1
  - id: local_window_size
    type:
      - 'null'
      - int
    doc: local sorting window size, set by default to 1000 under local mode.
    inputBinding:
      position: 102
      prefix: -w
  - id: print_options
    type:
      - 'null'
      - boolean
    doc: print options and summary
    inputBinding:
      position: 102
      prefix: -p
  - id: sorting_mode
    type:
      - 'null'
      - string
    doc: "sorting modes. [full]\n              local : locally sort within a 1000bp
      window.  Window size may be set by -w.\n              chrom : sort chromosomes
      based on order of contigs in header.\n                      input must be indexed\n\
      \              full  : full sort with no assumptions"
    inputBinding:
      position: 102
      prefix: -m
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output VCF/VCF.GZ/BCF file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
