cwlVersion: v1.2
class: CommandLineTool
baseCommand: lusstr config
label: lusstr_config
doc: "Create config file for running STR pipeline\n\nTool homepage: https://www.github.com/bioforensics/lusSTR"
inputs:
  - id: analysis_software
    type:
      - 'null'
      - string
    doc: Analysis software program used prior to lusSTR. Choices are uas, 
      straitrazor or genemarker.
    default: uas
    inputBinding:
      position: 101
      prefix: --analysis-software
  - id: custom
    type:
      - 'null'
      - boolean
    doc: Specifying custom sequence ranges.
    inputBinding:
      position: 101
      prefix: --custom
  - id: input
    type:
      - 'null'
      - string
    doc: Input file or directory
    inputBinding:
      position: 101
      prefix: --input
  - id: kintelligence
    type:
      - 'null'
      - boolean
    doc: Use if processing Kintelligence SNPs within a Kintellience Report(s)
    inputBinding:
      position: 101
      prefix: --kintelligence
  - id: nocombine
    type:
      - 'null'
      - boolean
    doc: Do not combine read counts for duplicate sequences within the UAS 
      region during the 'convert' step. By default, read counts are combined for
      sequences not run through the UAS.
    inputBinding:
      position: 101
      prefix: --nocombine
  - id: nofiltering
    type:
      - 'null'
      - boolean
    doc: For STRs, use to perform no filtering during the 'filter' step. For 
      SNPs, only alleles specified as 'Typed' by the UAS will be included at the
      'format' step.
    inputBinding:
      position: 101
      prefix: --nofiltering
  - id: noinfo
    type:
      - 'null'
      - boolean
    doc: Use to not create the Sequence Information File in the 'filter' step
    inputBinding:
      position: 101
      prefix: --noinfo
  - id: powerseq
    type:
      - 'null'
      - boolean
    doc: Use to indicate sequences were created using the PowerSeq Kit.
    inputBinding:
      position: 101
      prefix: --powerseq
  - id: probabilistic_genotyping_software
    type:
      - 'null'
      - string
    doc: Specify the probabilistic genotyping software package of choice. The 
      final output files will be in the correct format for direct use.
    default: strmix
    inputBinding:
      position: 101
      prefix: --software
  - id: reference
    type:
      - 'null'
      - boolean
    doc: Use for creating Reference profiles for STR workflow
    inputBinding:
      position: 101
      prefix: --reference
  - id: separate
    type:
      - 'null'
      - boolean
    doc: Use to separate EFM profiles in the 'filter' step. If specifying for 
      SNPs, each sample will also be separated into 10 different bins for 
      mixture deconvolution.
    inputBinding:
      position: 101
      prefix: --separate
  - id: sex
    type:
      - 'null'
      - boolean
    doc: Use if including the X and Y STR markers. Separate reports for these 
      markers will be created.
    inputBinding:
      position: 101
      prefix: --sex
  - id: snp_reference
    type:
      - 'null'
      - string
    doc: Specify any references for SNP data for use in EFM.
    inputBinding:
      position: 101
      prefix: --snp-reference
  - id: snp_type
    type:
      - 'null'
      - string
    doc: Specify the type of SNPs to include in the final report. 'p' will 
      include only the Phenotype SNPs; 'a' will include only the Ancestry SNPs; 
      'i' will include only the Identity SNPs; and 'all' will include all SNPs. 
      More than one type can be specified (e.g. 'p, a').
    default: all
    inputBinding:
      position: 101
      prefix: --snp-type
  - id: snps
    type:
      - 'null'
      - boolean
    doc: Use to create a config file for the SNP workflow
    inputBinding:
      position: 101
      prefix: --snps
  - id: str_type
    type:
      - 'null'
      - string
    doc: "Data type for STRs. Options are: CE allele ('ce'), sequence or bracketed
      sequence form('ngs'), or LUS+ allele ('lusplus')."
    default: ngs
    inputBinding:
      position: 101
      prefix: --str-type
  - id: strand
    type:
      - 'null'
      - string
    doc: Specify the strand orientation for the final output files. UAS 
      orientation is default for STRs; forward strand is default for SNPs.
    inputBinding:
      position: 101
      prefix: --strand
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: directory to add config file; default is current working directory
    default: .
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file/directory name
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lusstr:0.11--pyhdfd78af_0
