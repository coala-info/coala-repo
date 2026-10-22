cwlVersion: v1.2
class: CommandLineTool
baseCommand: SHAPEIT5_ligate
label: shapeit5_ligate
doc: "Ligate multiple phased chunks (VCF/BCF) into a single chromosome-length file.\n\
  \ \nTool homepage: https://odelaneau.github.io/shapeit5/"
inputs:
  - id: chunks
    type:
      - 'null'
      - type: array
        items: File
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .tbi
        required: false
    doc: The VCF/BCF chunk files named in the input list. They are staged in
      the working directory so that the names in the list resolve.
  - id: pedigree
    type:
      - 'null'
      - File
    doc: Pedigree file (kid father mother)
    inputBinding:
      position: 101
      prefix: --pedigree
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed of the random number generator
    inputBinding:
      position: 101
      prefix: --seed
  - id: input
    type: File
    doc: Text file containing the list of VCF/BCF files to ligate (one per 
      line).
    inputBinding:
      position: 101
      prefix: --input
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: --thread
  - id: log_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `log_path`
    inputBinding:
      position: 102
      prefix: --log
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output ligated VCF/BCF file.
    secondaryFiles:
      - pattern: .csi
        required: false
    outputBinding:
      glob: $(inputs.output_path)
  - id: log
    type:
      - 'null'
      - File
    doc: Log file.
    outputBinding:
      glob: $(inputs.log_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.chunks)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeit5:5.1.1--h34261f4_2
