cwlVersion: v1.2
class: CommandLineTool
baseCommand: genmod compound
label: genmod_compound
doc: "Score compound variants in a vcf file based on their rank score.\n\nTool homepage:
  http://github.com/moonso/genmod"
inputs:
  - id: vcf_file
    type: File
    doc: Input VCF file or '-' for stdin
    inputBinding:
      position: 1
  - id: penalty
    type:
      - 'null'
      - int
    doc: Penalty applied together with --threshold
    inputBinding:
      position: 102
      prefix: --penalty
  - id: processes
    type:
      - 'null'
      - int
    doc: Define how many processes that should be use for annotation.
    inputBinding:
      position: 102
      prefix: --processes
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Do not print the variants.
    inputBinding:
      position: 102
      prefix: --silent
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Path to tempdir
    inputBinding:
      position: 102
      prefix: --temp_dir
  - id: threshold
    type:
      - 'null'
      - int
    doc: Threshold for model-dependent penalty if no compounds with passing 
      score
    inputBinding:
      position: 102
      prefix: --threshold
  - id: vep
    type:
      - 'null'
      - boolean
    doc: If variants are annotated with the Variant Effect Predictor.
    inputBinding:
      position: 102
      prefix: --vep
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Specify the path to a file where results should be stored.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genmod:3.10.2--pyh7e72e81_0
