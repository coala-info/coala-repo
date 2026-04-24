cwlVersion: v1.2
class: CommandLineTool
baseCommand: MACARON
label: macaron_MACARON
doc: "Script to identify SnpClusters (SNPs within the same genetic codon)\n\nTool
  homepage: https://github.com/waqasuddinkhan/MACARON-GenMed-LabEx"
inputs:
  - id: add_anim
    type:
      - 'null'
      - boolean
    doc: Add animation while running (looks good but costs a thread)
    inputBinding:
      position: 101
      prefix: --add_anim
  - id: fields
    type:
      - 'null'
      - type: array
        items: string
    doc: "Single field name or comma-seperated ',' multiple field names can be given.
      Field name should be given according to the (INFO) field header of the input
      vcf file. Example: -f Func.refGene,ExonicFunc.refGene,Gene .refGene,1000g2015aug_all,ExAC_ALL,ExAC_EAS,clinvar_20
      161128,gnomAD_exome_ALL,gnomAD_genome_ALL,EFF,CSQ"
    inputBinding:
      position: 101
      prefix: --fields
  - id: gatk
    type:
      - 'null'
      - File
    doc: You can use this option to directly indicate the full path to the GATK 
      program (gatk wrapper or .jar)
    inputBinding:
      position: 101
      prefix: --GATK
  - id: gatk4_previous
    type:
      - 'null'
      - boolean
    doc: Use this option if you are using a version of gatk 4 older than gatk 
      4.1.4.1
    inputBinding:
      position: 101
      prefix: --gatk4_previous
  - id: hg_ref
    type:
      - 'null'
      - File
    doc: Indicate the full path to the reference genome fasta file
    inputBinding:
      position: 101
      prefix: --HG_REF
  - id: input_file
    type: File
    doc: Full path of the input VCF file.
    inputBinding:
      position: 101
      prefix: --infile
  - id: java_options
    type:
      - 'null'
      - string
    doc: You can use this option to specify java arguments required by GATK
    inputBinding:
      position: 101
      prefix: --JAVA_OPTIONS
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep temporary files in the directory tmp_macaron, at the same location
      than the output file.
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: snp_eff
    type:
      - 'null'
      - File
    doc: You can use this option to directly indicate the full path to the 
      snpEff jar or wrapper
    inputBinding:
      position: 101
      prefix: --SNPEFF
  - id: snp_eff_hg
    type:
      - 'null'
      - string
    doc: Indicate SnpEff human genome annotation database version
    inputBinding:
      position: 101
      prefix: --SNPEFF_HG
  - id: verbosity
    type:
      - 'null'
      - boolean
    doc: Use to print verbosity (Mostly GATK/SNPEFF output)
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path of the output txt file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macaron:1.0--pyh864c0ab_1
