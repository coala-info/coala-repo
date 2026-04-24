cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - FamSeq
label: famseq_FamSeq
doc: "FamSeq is a tool for variant calling in family-based sequencing data, supporting
  VCF and likelihood-only formats using Bayesian networks, Elston-Stewart, or MCMC
  methods.\n\nTool homepage: http://bioinformatics.mdanderson.org/main/FamSeq"
inputs:
  - id: input_type
    type: string
    doc: "Type of input file: 'vcf' for VCF files or 'LK' for likelihood-only format
      files."
    inputBinding:
      position: 1
  - id: geno_prob_k
    type:
      - 'null'
      - type: array
        items: string
    doc: Genotype probability of three kinds of genotype for autosome in 
      population (Pr(G)) when the variant is in dbSNP.
    inputBinding:
      position: 102
      prefix: -genoProbK
  - id: geno_prob_n
    type:
      - 'null'
      - type: array
        items: string
    doc: Genotype probability of three kinds of genotype for autosome in 
      population (Pr(G)) when the variant is not in dbSNP.
    inputBinding:
      position: 102
      prefix: -genoProbN
  - id: geno_prob_xk
    type:
      - 'null'
      - type: array
        items: string
    doc: Genotype probability of two kinds of genotype for chromosome X for male
      in population (Pr(G)) when the variant is in dbSNP.
    inputBinding:
      position: 102
      prefix: -genoProbXK
  - id: geno_prob_xn
    type:
      - 'null'
      - type: array
        items: string
    doc: Genotype probability of two kinds of genotype for chromosome X for male
      in population (Pr(G)) when the variant is not in dbSNP.
    inputBinding:
      position: 102
      prefix: -genoProbXN
  - id: lk_file
    type:
      - 'null'
      - File
    doc: The name of input likelihood only format file.
    inputBinding:
      position: 102
      prefix: -lkFile
  - id: lk_type
    type:
      - 'null'
      - string
    doc: 'The likelihood type stored in the likelihood only format file. n:normal(default);
      log10: log10 scaled; ln: ln scaled; PS: phred scaled.'
    inputBinding:
      position: 102
      prefix: -lkType
  - id: method
    type:
      - 'null'
      - int
    doc: 'Choose the method used in variant calling. 1(default): Bayesian network;
      2: Elston-Stewart algorithm; 3: MCMC.'
    inputBinding:
      position: 102
      prefix: -method
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: Mutation rate.
    inputBinding:
      position: 102
      prefix: -mRate
  - id: num_burn_in
    type:
      - 'null'
      - int
    doc: Number of burn in when the user chooses the MCMC method. The default 
      value is 1,000n, where n is the number of individuals in the pedigree.
    inputBinding:
      position: 102
      prefix: -numBurnIn
  - id: num_rep
    type:
      - 'null'
      - int
    doc: Number of iteration times when the user chooses MCMC method. The 
      default value is 20,000n.
    inputBinding:
      position: 102
      prefix: -numRep
  - id: only_variant_positions
    type:
      - 'null'
      - boolean
    doc: 'Only record the position at which the genotype is not RR in the output file.
      (R: reference allele, A: alternative allele).'
    inputBinding:
      position: 102
      prefix: -v
  - id: ped_file
    type:
      - 'null'
      - File
    doc: The name of the file storing the pedigree information.
    inputBinding:
      position: 102
      prefix: -pedFile
  - id: record_all_positions
    type:
      - 'null'
      - boolean
    doc: Record all the position in the output file.
    inputBinding:
      position: 102
      prefix: -a
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: The name of input vcf file.
    inputBinding:
      position: 102
      prefix: -vcfFile
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The name of output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/famseq:1.0.3--h9948957_8
