cwlVersion: v1.2
class: CommandLineTool
baseCommand: denovo_scoring.py
label: manta_denovo_scoring.py
doc: 'Add a de novo quality score (DQ) to the proband genotype of a Manta joint-call
  VCF of a trio. Writes <vcf prefix>.de_novo.vcf and <vcf prefix>.de_novo.stats.txt
  next to the input VCF.


  Tool homepage: https://github.com/Illumina/manta'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.vcf_file)
        writable: true
inputs:
  - id: vcf_file
    type: File
    doc: Uncompressed VCF file with the trio samples; staged in the job directory
      because the outputs are written beside it
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: proband_id
    type: string
    doc: Sample ID of the proband
    inputBinding:
      position: 2
  - id: father_id
    type: string
    doc: Sample ID of the father
    inputBinding:
      position: 3
  - id: mother_id
    type: string
    doc: Sample ID of the mother
    inputBinding:
      position: 4
outputs:
  - id: de_novo_vcf
    type: File
    doc: VCF with the DQ format field added
    outputBinding:
      glob: '*.de_novo.vcf'
  - id: de_novo_stats
    type: File
    doc: Counts of inconsistent genotype combinations
    outputBinding:
      glob: '*.de_novo.stats.txt'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/manta:1.6.0--py27h9948957_6
