cwlVersion: v1.2
class: CommandLineTool
baseCommand: pileupCaller
label: sequencetools_pileupCaller
doc: "PileupCaller is a tool to create genotype calls from bam files using read-sampling
  methods. To use this tool, you need to convert bam files into the mpileup-format,
  specified at http://www.htslib.org/doc/samtools.html (under \"mpileup\"). The recommended
  command line to create a multi-sample mpileup file to be processed with pileupCaller
  is\n\n    samtools mpileup -B -q30 -Q30 -l <BED_FILE> -R -f <FASTA_REFERENCE_FILE>\n\
  \        Sample1.bam Sample2.bam Sample3.bam | pileupCaller ...\n\nYou can lookup
  what these options do in the samtools documentation. Note that flag -B in samtools
  is very important to reduce reference bias in low coverage data.\n\nTool homepage:
  https://github.com/stschiff/sequenceTools"
inputs:
  - id: down_sampling
    type:
      - 'null'
      - boolean
    doc: When this switch is given, the MajorityCalling mode will downsample 
      from the total number of reads a number of reads (without replacement) 
      equal to the --minDepth given. This mitigates reference bias in the 
      MajorityCalling model, which increases with higher coverage. The 
      recommendation for rare-allele calling is --majorityCall --downsampling 
      --minDepth 3
    inputBinding:
      position: 101
      prefix: --downSampling
  - id: keep_incongruent_reads
    type:
      - 'null'
      - boolean
    doc: 'By default, pileupCaller now removes reads with tri-allelic alleles that
      are neither of the two alleles specified in the SNP file. To keep those reads
      for sampling, set this flag. With this option given, if the sampled read has
      a tri-allelic allele that is neither of the two given alleles in the SNP file,
      a missing genotype is generated. IMPORTANT NOTE: The default behaviour has changed
      in pileupCaller version 1.4.0. If you want to emulate the previous behaviour,
      use this flag. I recommend now to NOT set this flag and use the new behaviour.'
    inputBinding:
      position: 101
      prefix: --keepIncongruentReads
  - id: majority_call
    type:
      - 'null'
      - boolean
    doc: Pick the allele supported by the most reads at a site. If an equal 
      numbers of alleles fulfil this, pick one at random. This results in a 
      haploid call. See --downSampling for best practices for calling rare 
      variants
    inputBinding:
      position: 101
      prefix: --majorityCall
  - id: min_depth
    type:
      - 'null'
      - int
    doc: 'specify the minimum depth for a call. For sites with fewer reads than this
      number, declare Missing (default: 1)'
    inputBinding:
      position: 101
      prefix: --minDepth
  - id: pop_name_as_both
    type:
      - 'null'
      - boolean
    doc: 'Only valid for Plink Output: Write the population name into both the first
      and last column of the fam file, so both as Family-ID and as a Phenotype according
      to the Plink Spec. By default, the population name is specified only as the
      first column (family name in the Plink spec)'
    inputBinding:
      position: 101
      prefix: --popNameAsBoth
  - id: pop_name_as_phenotype
    type:
      - 'null'
      - boolean
    doc: 'Only valid for Plink Output: Write the population name into the last column
      of the fam file, as a Phenotype according to the Plink Spec. By default, the
      population name is specified as the first column only (family name in the Plink
      spec)'
    inputBinding:
      position: 101
      prefix: --popNameAsPhenotype
  - id: random_diploid
    type:
      - 'null'
      - boolean
    doc: Sample two reads at random (without replacement) at each site and 
      represent the individual by a diploid genotype constructed from those two 
      random picks. This will always assign missing data to positions where only
      one read is present, even if minDepth=1. The main use case for this option
      is for estimating mean heterozygosity across sites.
    inputBinding:
      position: 101
      prefix: --randomDiploid
  - id: random_haploid
    type:
      - 'null'
      - boolean
    doc: This method samples one read at random at each site, and uses the 
      allele on that read as the one for the actual genotype. This results in a 
      haploid call
    inputBinding:
      position: 101
      prefix: --randomHaploid
  - id: random_seed
    type:
      - 'null'
      - int
    doc: random seed used for the random number generator. If not given, use 
      system clock to seed the random number generator.
    inputBinding:
      position: 101
      prefix: --seed
  - id: sample_name_file
    type:
      - 'null'
      - File
    doc: give the names of the samples in a file with one name per line
    inputBinding:
      position: 101
      prefix: --sampleNameFile
  - id: sample_names
    type:
      - 'null'
      - type: array
        items: string
    doc: give the names of the samples as comma-separated list (no spaces)
    inputBinding:
      position: 101
      prefix: --sampleNames
  - id: sample_pop_name
    type:
      - 'null'
      - type: array
        items: string
    doc: 'specify the population name(s) of the samples, which are included in the
      output *.ind.txt file in Eigenstrat output. This will be ignored if the output
      format is not Eigenstrat. If a single name is given, it is applied to all samples,
      if multiple are given, their number must match the the number of samples (default:
      Left "Unknown")'
    inputBinding:
      position: 101
      prefix: --samplePopName
  - id: single_strand_mode
    type:
      - 'null'
      - boolean
    doc: '[THIS IS CURRENTLY AN EXPERIMENTAL FEATURE]. At C/T polymorphisms, ignore
      reads aligning to the forward strand. At G/A polymorphisms, ignore reads aligning
      to the reverse strand. This should remove post-mortem damage in ancient DNA
      libraries prepared with the non-UDG single-stranded protocol.'
    inputBinding:
      position: 101
      prefix: --singleStrandMode
  - id: skip_transitions
    type:
      - 'null'
      - boolean
    doc: skip transition SNPs entirely in the output, resulting in a dataset 
      with fewer sites.
    inputBinding:
      position: 101
      prefix: --skipTransitions
  - id: snp_file
    type: File
    doc: an Eigenstrat-formatted SNP list file for the positions and alleles to 
      call. All positions in the SNP file will be output, adding missing data 
      where there is no data. Note that pileupCaller automatically checks 
      whether alleles in the SNP file are flipped with respect to the human 
      reference, and in those cases flips the genotypes accordingly. But it 
      assumes that the strand-orientation of the SNPs given in the SNP list is 
      the one in the reference genome used in the BAM file underlying the pileup
      input. Note that both the SNP file and the incoming pileup data have to be
      ordered by chromosome and position, and this is checked. The chromosome 
      order in humans is 1-22,X,Y,MT. Chromosome can generally begin with "chr".
      In case of non-human data with different chromosome names, you should 
      convert all names to numbers. They will always considered to be 
      numerically ordered, even beyond 22. Finally, I note that for internally, 
      X is converted to 23, Y to 24 and MT to 90. This is the most widely used 
      encoding in Eigenstrat databases for human data, so using a SNP file with 
      that encoding will automatically be correctly aligned to pileup data with 
      actual chromosome names X, Y and MT (or chrX, chrY and chrMT, 
      respectively).
    inputBinding:
      position: 101
      prefix: --snpFile
  - id: transitions_missing
    type:
      - 'null'
      - boolean
    doc: mark transitions as missing in the output, but do output the sites.
    inputBinding:
      position: 101
      prefix: --transitionsMissing
  - id: zip_eigenstrat_plink
    type:
      - 'null'
      - boolean
    doc: GZip the output Eigenstrat or Plink genotype and SNP files. Filenames 
      will be appended with '.gz'. To zip FreqSum or VCF output, just zip the 
      standard output of this program, for example `pileupCaller ... --vcf | 
      gzip -c > out.vcf.gz
    inputBinding:
      position: 101
      prefix: '----zip'
outputs:
  - id: eigenstrat_out
    type:
      - 'null'
      - File
    doc: "Set Eigenstrat as output format. Specify the filenames for the EigenStrat
      SNP, IND and GENO file outputs: <FILE_PREFIX>.snp, <FILE_PREFIX>.ind and <FILE_PREFIX>.geno.
      If not set, output will be FreqSum (Default). Note that freqSum format, described
      at https://rarecoal-docs.readthedocs.io/en/latest/rarecoal-tools.html#vcf2freqsum,
      is useful for testing your pipeline, since it's output to standard out"
    outputBinding:
      glob: $(inputs.eigenstrat_out)
  - id: plink_out
    type:
      - 'null'
      - File
    doc: "Set Plink as output format. Specify the filenames for the Plink BIM, FAM
      and BED file outputs: <FILE_PREFIX>.bim, <FILE_PREFIX>.fam and <FILE_PREFIX>.bed.
      If not set, output will be FreqSum (Default). Note that freqSum format, described
      at https://rarecoal-docs.readthedocs.io/en/latest/rarecoal-tools.html#vcf2freqsum,
      is useful for testing your pipeline, since it's output to standard out"
    outputBinding:
      glob: $(inputs.plink_out)
  - id: vcf
    type:
      - 'null'
      - File
    doc: output VCF format to stdout
    outputBinding:
      glob: $(inputs.vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequencetools:1.6.0.0--hebebf5b_0
