cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varlociraptor
  - genotype
label: varlociraptor_genotype
doc: 'Infer classical genotypes from Varlociraptor''s AF field (1.0: 1/1, 0.5: 0/1,
  0.0: 0/0, otherwise: 0/1). This assumes diploid samples. Input is read from standard
  input.


  Tool homepage: https://varlociraptor.github.io'
inputs:
  - id: input_bcf
    type: File
    doc: Varlociraptor calls in BCF format (standard input).
outputs:
  - id: output_bcf
    type: stdout
    doc: BCF with genotypes
stdin: $(inputs.input_bcf.path)
stdout: genotyped.bcf
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
