cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcferr
label: vcferr
doc: "Simulate genotypes in a VCF file with specified error probabilities.\n\nTool
  homepage: https://github.com/signaturescience/vcferr"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: p_aamm
    type:
      - 'null'
      - float
    doc: Probability of homozygous alt to missing (0,0) to (.,.)
    inputBinding:
      position: 102
      prefix: --p_aamm
  - id: p_aara
    type:
      - 'null'
      - float
    doc: Probability of homozygous alt drop out (1,1) to (0,1)
    inputBinding:
      position: 102
      prefix: --p_aara
  - id: p_aarr
    type:
      - 'null'
      - float
    doc: Probability of double homozygous alt drop out (1,1) to (0,0)
    inputBinding:
      position: 102
      prefix: --p_aarr
  - id: p_raaa
    type:
      - 'null'
      - float
    doc: Probability of homozygous alt drop in (0,1) or (1,0) to (1,1)
    inputBinding:
      position: 102
      prefix: --p_raaa
  - id: p_ramm
    type:
      - 'null'
      - float
    doc: Probability of heterozygous to missing (0,1) or (1,0) to (.,.)
    inputBinding:
      position: 102
      prefix: --p_ramm
  - id: p_rarr
    type:
      - 'null'
      - float
    doc: Probability of heterozygous drop out (0,1) or (1,0) to (0,0)
    inputBinding:
      position: 102
      prefix: --p_rarr
  - id: p_rraa
    type:
      - 'null'
      - float
    doc: Probability of double homozygous alt drop in (0,0) to (1,1)
    inputBinding:
      position: 102
      prefix: --p_rraa
  - id: p_rrmm
    type:
      - 'null'
      - float
    doc: Probability of homozygous ref to missing (0,0) to (.,.)
    inputBinding:
      position: 102
      prefix: --p_rrmm
  - id: p_rrra
    type:
      - 'null'
      - float
    doc: Probability of heterozygous drop in (0,0) to (0,1)
    inputBinding:
      position: 102
      prefix: --p_rrra
  - id: sample
    type: string
    doc: ID of sample in VCF file to be simulated
    inputBinding:
      position: 102
      prefix: --sample
  - id: seed
    type:
      - 'null'
      - int
    doc: Random number seed
    inputBinding:
      position: 102
      prefix: --seed
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: Output VCF file containing simulated genotypes
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcferr:1.0.2--pyh5e36f6f_0
