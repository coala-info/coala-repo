# shapeit CWL Generation Report

## shapeit

### Tool Description
Segmented Haplotype Estimation & Imputation Tool

### Metadata
- **Docker Image**: quay.io/biocontainers/shapeit:2.r837--h09b0a5c_1
- **Homepage**: https://github.com/odelaneau/shapeit4
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/shapeit/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/odelaneau/shapeit4
- **Stars**: N/A
### Original Help Text
```text
[33mS[0megmented [33mHAP[0mlotype [33mE[0mstimation & [33mI[0mmputation [33mT[0mool
  * Authors : Olivier Delaneau, Jared O'Connell, Jean-François Zagury, Jonathan Marchini
  * Contact : send an email to the OXSTATGEN mail list https://www.jiscmail.ac.uk/cgi-bin/webadmin?A0=OXSTATGEN
  * Webpage : https://mathgen.stats.ox.ac.uk/shapeit
  * Version : v2.r837

[33mBasic options[0m:
  -H [ --help ]                         Produce help message.
  --licence                             Produce licence description.
  --version                             Produce version number.
  --source                              Produce source file version details.
  --seed arg (=1771980220)              Seed of the random number generator.
  --aligned                             Ref allele is aligned on the reference 
                                        genome
  -T [ --thread ] arg (=1)              Number of thread used for phasing.
  -L [ --output-log ] arg (=shapeit_date_time_UUID.log)
                                        Log file containing a copy of the 
                                        screen output.

[33mSubsetting options[0m:
  --exclude-snp arg                     List of positions to exclude in 
                                        input/output files.
  --include-snp arg                     List of positions to include in 
                                        input/output files.
  --exclude-ind arg                     List of samples to exclude in 
                                        input/output files.
  --include-ind arg                     List of samples to include in 
                                        input/output files.
  --exclude-grp arg                     List of populations to exclude in input
                                        files. Works only on the reference 
                                        panel of haplotypes.
  --include-grp arg                     List of populations to include in input
                                        files. Works only on the reference 
                                        panel of haplotypes.
  --input-from arg (=0)                 First physical position to consider in 
                                        input files.
  --input-to arg (=1000000000)          Last physical position to consider in 
                                        input file.
  --output-from arg (=0)                First physical position to output.
  --output-to arg (=1000000000)         Last physical position to output.

[33mInput files options[0m:
  -P [ --input-ped ] arg                Unphased genotypes in PED/MAP format.
  --missing-code arg (=0)               Missing data character in PED/MAP 
                                        format.
  -B [ --input-bed ] arg                Unphased genotypes in BED/BIM/FAM 
                                        format.
  --noped                               No pedigree information taken into 
                                        account.
  --duohmm                              Phase pedigrees using the duoHMM 
                                        algorithm.
  -G [ --input-gen ] arg                Unphased genotypes in GEN/SAMPLE 
                                        format.
  --input-thr arg (=0.9)                Probability threshold used to call 
                                        genotypes in GEN file.
  -V [ --input-vcf ] arg                Unphased genotypes in VCF format.
  -M [ --input-map ] arg                Genetic map in HapMap format.
  -R [ --input-ref ] arg                Reference set of haplotypes in 
                                        HAPS/SAMPLE format.
  --input-init arg                      Phased haplotypes in HAPS/SAMPLE format
                                        used for initialisation.
  - [ --input-sex ] arg                 Sex of the samples.
  --missing-maf                         MAF based initialisation of missing 
                                        genotypes prior to phasing
  -X [ --chrX ]                         Unphased genotypes are from chromosome 
                                        X non autosomal region.

[33mMCMC options[0m:
  --burn arg (=7)                       Number of burn-in MCMC iterations.
  --prune arg (=8)                      Number of pruning MCMC iterations.
  --main arg (=20)                      Number of main MCMC iterations.
  --run arg (=1)                        Number of pruning stages
  --no-mcmc                             No MCMC iteration (just phase given the
                                        reference panel haplotypes).

[33mModel options[0m:
  -S [ --states ] arg (=100)            Number of hidden states used for 
                                        phasing (selected using Hamming 
                                        distance minimisation).
  --states-random arg (=0)              Number of hidden states used for 
                                        phasing (selected at random).
  --states-pmatch arg (=0)              Number of hidden states used for 
                                        phasing (selected using perfect match 
                                        maximisation).
  --states-cov arg (=0)                 Number of hidden states used for 
                                        phasing (selected using perfect match 
                                        that maximise coverage of the region).
  -W [ --window ] arg (=2)              Mean size of the windows in which 
                                        conditioning haplotypes are defined.
  --model-version1                      Use the graphical model to represent 
                                        the conditioning haplotypes (as in 
                                        SHAPEIT v1).
  --effective-size arg (=15000)         Effective size of the population.
  --rho arg (=0.0004)                   Constant recombination rate.
  --input-copy-states arg               To specify who to copy from

[33mOutput file options[0m:
  -O [ --output-max ] arg               Phased haplotypes in HAPS/SAMPLE 
                                        format.
  --output-graph arg                    Phased haplotype graphs in binary 
                                        format (v2.2).
```

