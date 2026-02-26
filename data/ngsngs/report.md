# ngsngs CWL Generation Report

## ngsngs

### Tool Description
Next Generation Simulator for Next Generator Sequencing Data

### Metadata
- **Docker Image**: quay.io/biocontainers/ngsngs:0.9.2--hce60e53_0
- **Homepage**: https://github.com/rahenriksen/ngsngs
- **Package**: https://anaconda.org/channels/bioconda/packages/ngsngs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ngsngs/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rahenriksen/ngsngs
- **Stars**: N/A
### Original Help Text
```text
Next Generation Simulator for Next Generator Sequencing Data version 0.9.0 

Usage
./ngsngs [options] -i <input_reference.fa> -r/-c <Number of reads or depth of coverage> -l/-lf/-ld <fixed length, length file or length distribution> -seq <SE/PE> -f <output format> -o <output name prefix>

Example 
./ngsngs -i Test_Examples/Mycobacterium_leprae.fa.gz -r 100000 -t 2 -s 1 -lf Test_Examples/Size_dist_sampling.txt -seq SE -m b,0.024,0.36,0.68,0.0097 -q1 Test_Examples/AccFreqL150R1.txt -f bam -o MycoBactBamSEOut

./ngsngs -i Test_Examples/Mycobacterium_leprae.fa.gz -c 3 -t 2 -s 1 -l 100 -seq PE -ne -a1 AGATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATTCGATCTCGTATGCCGTCTTCTGCTTG -a2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATTT -q1 Test_Examples/AccFreqL150R1.txt -q2 Test_Examples/AccFreqL150R2.txt -f fq -o MycoBactFqPEOut

./ngsngs -i Test_Examples/Mycobacterium_leprae.fa.gz -r 100000 -t 1 -s 1 -ld Pois,78 -seq SE -mf Test_Examples/MisincorpFile.txt -f fa -o MycoBactFaSEOut

./ngsngs -i Test_Examples/Mycobacterium_leprae.fa.gz -r 100000 -t 1 -s 1 -lf Test_Examples/Size_dist_sampling.txt -ll 50 -seq SE -qs 40 -f fq -o MycoBactFqQsLlSEOut

./ngsngs -i Test_Examples/hg19MSub.fa -r 1000 -t 1 -s 100 -l 150 -seq SE -ne -vcf Test_Examples/ChrMtSubDeletionDiploid.vcf -id 0 -q1 Test_Examples/AccFreqL150R1.txt -chr MT -DumpVCF DeltionInfo -f fq -o MtDeletionOut 

-h   | --help: 			 Print help page.

-v   | --version: 			 Print NGSNGS version, git commit and htslib library.

----- Required ----- 

	-i   | --input: 		 Reference file in fasta format (.fa,.fasta) to sample reads.

Sequence reads: 

	-r   | --reads: 		 Number of reads to simulate, conflicts with -c option.
	-c   | --coverage: 		 Depth of Coverage to simulate, conflics with -r option.

Fragment Length: 

	-l   | --length: 		 Fixed length of simulated fragments, conflicts with -lf & -ld option.
	-lf  | --lengthfile: 		 CDF of a length distribution, conflicts with -l & -ld option.
	-ld  | --lengthdist: 		 Discrete or continuous probability distributions, given their Probability density function, conflicts with -l & -lf option.
		<Uni,Min,Max> 		 Uniform distribution from a closed interval given a minimum and maximum positive integer, e.g. Uni,40,180.
		<Norm,Mean,Variance> 	 Normal Distribution, given a mean and variance, e.g. Norm,80,30.
		<LogNorm,Mean,Variance>  Log-normal Distribution, given a mean and variance, e.g. LogNorm,4,1.
		<Pois,Rate> 		 Poisson distribution, given a rate, e.g. Pois,165.
		<Exp,Rate> 		 Exponential distribution, given a rate, e.g. Exp,0.025.
		<Gam,Shape,Scale> 	 Gamma distribution, given a shape and scale, e.g. Gam,20,2.

Output characteristics: 

	-seq | --sequencing: 		 Simulate single-end or paired-end reads.
		 <SE>	 single-end 
 		 <PE>	 paired-end.
	-f   | --format: 		 File format of the simulated output reads.
		 Nucletide sequence w. different compression levels. 
		 <fa||fasta> 
		 <fa.gz||fasta.gz>	
		 Nucletide sequence with corresponding quality score w. different compression levels. 
		 <fq||fastq> 
		 <fq.gz||fastq.gz>	
		 Sequence Alignment Map w. different compression levels. 
		 <sam||bam||cram>
	-o   | --output: 		 Prefix of output file name.

Format specific: 

	-q1  | --quality1: 		 Read Quality profile for single-end reads (SE) or first read pair (PE) for fastq or sequence alignment map formats.
	-q2  | --quality2: 		 Read Quality profile for for second read pair (PE) for fastq or sequence alignment map formats.
	-qs  | --qualityscore: 		 Fixed quality score, for both read pairs in fastq or sequence alignment map formats. It overwrites the quality profiles.

----- Optional ----- 

Genetic Variations: 

	-bcf | -vcf: 			 Variant Calling Format (.vcf) or binary format (.bcf)
	-id  | --indiv: 		 Integer value (0 - index) for the number of a specific individual defined in bcf header from -vcf/-bcf input file, default = -1 (no individual selected).
		 e.g -id 0		 First individual in the provided vcf file.
	-DumpVCF:			 The prefix of an internally generated fasta file, containing the sequences representing the haplotypes with the variations from the provided vcf file (-vcf|-bcf), for diploid individuals the fasta file contains two copies of the reference genome with the each allelic genotype.

Stochastic Variations: 

	-indel: 			 Input probabilities and lambda values for a geometric distribution randomly generating insertions and deletions of a random length.
		 <InsProb,DelProb,InsParam,DelParam> 	 
		 Insertions and deletions 	-indel 0.05,0.1,0.1,0.2 
		 Only Insertions 		-indel 0.05,0.0,0.1,0.0 
		 Only Deletions 		-indel 0.0,0.5,0.0,0.9 
	-DumpIndel: 		 The prefix of an internally generated txt file, containing the the read id, number of indels, the number of indel operations saving the position before and after and length of the indel, simulated read length before and after, see supplementary material for detailed example and description.

Postmortem damage (PMD) - Deamination: 

	-m   | --model: 		 Choice of deamination model.
		 <b,nv,Lambda,Delta_s,Delta_d>  || <briggs,nv,Lambda,Delta_s,Delta_d> 	 Parameters for the damage patterns using the Briggs model altered to suit modern day library preparation.
		 <b7,nv,Lambda,Delta_s,Delta_d> || <briggs07,nv,Lambda,Delta_s,Delta_d>  Parameters for the damage patterns using the Briggs model 2007.
		 nv: Nick rate per site. 
 		 Lambda: Geometric distribution parameter for overhang length.
 		 Delta_s: PMD rate in single-strand regions.
 		 Delta_d: PMD rate in double-strand regions.
		 e.g -m b,0.024,0.36,0.68,0.0097

	-dup | --duplicates: 		 Number of PCR duplicates, used in conjunction with briggs modern library prep -m <b,nv,Lambda,Delta_s,Delta_d>
		 <1,2,4> 		 Default = 1

Nucleotide Alterations: 

	-mf  | --mismatch: 		 Nucleotide substitution frequency file.
	-ne  | --noerror: 		 Disabling the sequencing error substitutions based on nucleotide qualities from the provided quality profiles -q1 and -q2.

Read Specific: 

	-na  | --noalign: 		 Using the SAM output as a sequence container without alignment information.
	-cl  | --cycle: 		 Read cycle length, the maximum length of sequence reads, if not provided the cycle length will be inferred from quality profiles (q1,q2).
	-ll  | --lowerlimit: 		 Lower fragment length limit, default = 30. The minimum fragment length for deamination is 30, so simulated fragments below will be fixed at 30.
	-bl  | --bufferlength: 		 Buffer length for generated sequence reads stored in the output files, default = 30000000.
	-chr | --chromosomes: 		 Specific chromosomes from input reference file to simulate from.

	-a1  | --adapter1: 		 Adapter sequence to add for simulated reads (SE) or first read pair (PE).
		 e.g. Illumina TruSeq Adapter 1: AGATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATTCGATCTCGTATGCCGTCTTCTGCTTG 

	-a2  | --adapter2: 		 Adapter sequence to add for second read pair (PE). 
		 e.g. Illumina TruSeq Adapter 2: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATTT 

	-p   | --poly: 			 Create Poly(X) tails for reads, containing adapters with lengths below the inferred readcycle length. 
 		 e.g -p G or -p A 

Simulation Specific: 

	-t   | --threads: 		 Number of sampling threads, default = 1.
	-t2  | --threads2: 		 Number of compression threads, default = 0.
	-s   | --seed: 			 Random seed, default = current calendar time (s).
	-rng | --rand: 			 Pseudo-random number generator, OS specific
		 <0,1,2,3> 
		 0 :  			 drand48_r, default for linux or unix, not available for MacOS.
		 1 :  			 std::uniform_int_distribution
		 2 :  			 rand_r
		 3 :  			 erand48, default for MacOS.
```

