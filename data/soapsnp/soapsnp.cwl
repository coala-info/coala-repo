cwlVersion: v1.2
class: CommandLineTool
baseCommand: soapsnp
label: soapsnp
doc: "SoapSNP\n\nTool homepage: https://github.com/zzhangjii/soapsnp"
inputs:
  - id: dbSNP_info
    type:
      - 'null'
      - File
    doc: Pre-formated dbSNP information
    inputBinding:
      position: 101
      prefix: -s
  - id: enable_monoploid_calling
    type:
      - 'null'
      - boolean
    doc: Enable monoploid calling mode, this will ensure all consensus as HOM 
      and you probably should SPECIFY higher altHOM rate.
    default: false
    inputBinding:
      position: 101
      prefix: -m
  - id: enable_rank_sum_test
    type:
      - 'null'
      - boolean
    doc: Enable rank sum test to give HET further penalty for better accuracy.
    default: false
    inputBinding:
      position: 101
      prefix: -u
  - id: extra_headers_glfv2
    type:
      - 'null'
      - string
    doc: Extra headers EXCEPTതിനു CHROMOSOME FIELD specified in GLFv2 output. 
      Format is "TypeName1:DataName1:TypeName2:DataName2"
    default: ''
    inputBinding:
      position: 101
      prefix: -E
  - id: global_error_dependency_coefficient
    type:
      - 'null'
      - float
    doc: Global Error Dependency Coefficient, 0.0(complete 
      dependent)~1.0(complete independent)
    default: 0.9
    inputBinding:
      position: 101
      prefix: -g
  - id: input_file
    type: File
    doc: Input SORTED Soap Result
    inputBinding:
      position: 101
      prefix: -i
  - id: max_fastq_quality_score
    type:
      - 'null'
      - string
    doc: maximum FASTQ quality score
    default: 40
    inputBinding:
      position: 101
      prefix: -Q
  - id: max_read_length
    type:
      - 'null'
      - string
    doc: maximum length of read
    default: 45
    inputBinding:
      position: 101
      prefix: -L
  - id: novel_althom_prior_probability
    type:
      - 'null'
      - float
    doc: novel altHOM prior probability
    default: 0.0005
    inputBinding:
      position: 101
      prefix: -r
  - id: novel_het_prior_probability
    type:
      - 'null'
      - float
    doc: novel HET prior probability
    default: 0.001
    inputBinding:
      position: 101
      prefix: -e
  - id: output_format
    type:
      - 'null'
      - int
    doc: 'Output format. 0: Text; 1: GLFv2; 2: GPFv2.'
    default: 0
    inputBinding:
      position: 101
      prefix: -F
  - id: output_potential_snps
    type:
      - 'null'
      - boolean
    doc: Only output potential SNPs. Useful in Text output mode.
    default: false
    inputBinding:
      position: 101
      prefix: -q
  - id: pcr_error_dependency_coefficient
    type:
      - 'null'
      - float
    doc: PCR Error Dependency Coefficient, 0.0(complete dependent)~1.0(complete 
      independent)
    default: 0.5
    inputBinding:
      position: 101
      prefix: -p
  - id: quality_calibration_matrix_input
    type:
      - 'null'
      - File
    doc: Input previous quality calibration matrix. It cannot be used 
      simutaneously with -M
    inputBinding:
      position: 101
      prefix: -I
  - id: quality_zero_char
    type:
      - 'null'
      - string
    doc: ASCII chracter standing for quality==0
    default: '@'
    inputBinding:
      position: 101
      prefix: -z
  - id: reference_sequence
    type: File
    doc: Reference Sequence in fasta format
    inputBinding:
      position: 101
      prefix: -d
  - id: refine_snps_using_dbsnp
    type:
      - 'null'
      - boolean
    doc: REFINE SNPs using dbSNPs information
    default: false
    inputBinding:
      position: 101
      prefix: '-2'
  - id: regions_file
    type:
      - 'null'
      - File
    doc: 'Only call consensus on regions specified in FILE. Format: ChrName\tStart\tEnd.'
    inputBinding:
      position: 101
      prefix: -T
  - id: set_transition_transversion_ratio
    type:
      - 'null'
      - boolean
    doc: set transition/transversion ratio to 2:1 in prior probability
    inputBinding:
      position: 101
      prefix: -t
  - id: unvalidated_althom_rate
    type:
      - 'null'
      - float
    doc: Unvalidated altHOM rate, if no allele frequency known
    default: 0.01
    inputBinding:
      position: 101
      prefix: -k
  - id: unvalidated_het_prior
    type:
      - 'null'
      - float
    doc: Unvalidated HET prior, if no allele frequency known
    default: 0.02
    inputBinding:
      position: 101
      prefix: -j
  - id: validated_althom_prior
    type:
      - 'null'
      - float
    doc: Validated altHOM prior, if no allele frequency known
    default: 0.05
    inputBinding:
      position: 101
      prefix: -b
  - id: validated_het_prior
    type:
      - 'null'
      - float
    doc: Validated HET prior, if no allele frequency known
    default: 0.1
    inputBinding:
      position: 101
      prefix: -a
outputs:
  - id: output_file
    type: File
    doc: Output consensus file
    outputBinding:
      glob: $(inputs.output_file)
  - id: quality_calibration_matrix_output
    type:
      - 'null'
      - File
    doc: Output the quality calibration matrix; the matrix can be reused with -I
      if you rerun the program
    outputBinding:
      glob: $(inputs.quality_calibration_matrix_output)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/soapsnp:v1.03-3-deb_cv1
