cwlVersion: v1.2
class: CommandLineTool
baseCommand: AnnotSV
label: annotsv
doc: "AnnotSV is a tool for annotating Structural Variations (SV). (Note: The provided
  text was a Docker error log; arguments are based on standard AnnotSV CLI usage).\n\
  \nTool homepage: https://github.com/lgmgeo/AnnotSV"
inputs:
  - id: annotation_mode
    type:
      - 'null'
      - string
    doc: "Annotation mode: 'both', 'split', or 'full'"
    inputBinding:
      position: 101
      prefix: -annotationMode
  - id: genome_build
    type:
      - 'null'
      - string
    doc: Genome build (e.g., GRCh37, GRCh38)
    inputBinding:
      position: 101
      prefix: -genomeBuild
  - id: overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap percentage
    inputBinding:
      position: 101
      prefix: -overlap
  - id: reciprocal
    type:
      - 'null'
      - string
    doc: Use reciprocal overlap (yes/no)
    inputBinding:
      position: 101
      prefix: -reciprocal
  - id: snv_vcf
    type:
      - 'null'
      - File
    doc: Path to a SNV VCF file for frequency calculation
    inputBinding:
      position: 101
      prefix: -snvVCF
  - id: sv_input_file
    type: File
    doc: Path to the SV input file (VCF or BED)
    inputBinding:
      position: 101
      prefix: -SVinputFile
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to the output directory
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/annotsv:3.5.3--py313hdfd78af_0
