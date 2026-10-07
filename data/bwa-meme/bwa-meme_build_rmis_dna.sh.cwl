cwlVersion: v1.2
class: CommandLineTool
baseCommand: build_rmis_dna.sh
label: bwa-meme_build_rmis_dna.sh
doc: "Learned-index training script for BWA-MEME. For human reference, training requires
  around 15 minutes and 64GB memory.\n\nTool homepage: https://github.com/kaist-ina/BWA-MEME"
inputs:
  - id: reference_file
    type: File
    doc: Reference fasta file; its suffix array (<reference>.suffixarray_uint64 from
      bwa-meme index -a meme) must sit beside it
    secondaryFiles:
      - pattern: .suffixarray_uint64
        required: true
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: num_models_exponent
    type:
      - 'null'
      - int
    doc: Set number of models to use for second layer as a power of 2 (e.g., 26 for
      2^26)
    inputBinding:
      position: 2
outputs:
  - id: rmi_parameters
    type: File[]
    doc: Learned-index model files (<reference>.suffixarray_uint64_L0_PARAMETERS, _L1_
      and _L2_PARAMETERS) used by bwa-meme mem -7
    outputBinding:
      glob: $(inputs.reference_file.basename).suffixarray_uint64_*
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reference_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa-meme:1.0.6--hdcf5f25_2
stdout: bwa-meme_build_rmis_dna.sh.out
