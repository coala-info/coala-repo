cwlVersion: v1.2
class: CommandLineTool
baseCommand: convert_vcf_to_features
label: cct_convert_vcf_to_features
doc: "This script converts a VCF (Variant Call Format) file into a feature file (GFF).
  The resulting GFF file can be used by the CGview Comparison tool.\n\nTool homepage:
  https://github.com/paulstothard/cgview_comparison_tool"
inputs:
  - id: input
    type: File
    doc: Input VCF file (tab deliminated).
    inputBinding:
      position: 1
      prefix: -i
  - id: output
    type: string
    doc: Name to call the output file. One file per chromosome is written, 
      named <name without .gff>_<chrom>.gff.
    inputBinding:
      position: 2
      prefix: -o
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: GFF feature files, one per chromosome
    outputBinding:
      glob: $(inputs.output.replace(/\.gff/, ''))_*.gff
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cct:v20170919dfsg-1-deb_cv1
