# poseidon-xerxes CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| poseidon-xerxes_admixpops | PASS |  |
| poseidon-xerxes_fstats | PASS |  |
| poseidon-xerxes_ras | PASS |  |

## poseidon-xerxes_fstats

### Tool Description
Compute f-statistics on groups and invidiuals within and across Poseidon packages

### Metadata
- **Docker Image**: quay.io/biocontainers/poseidon-xerxes:1.0.1.1--hf48d1a7_0
- **Homepage**: https://poseidon-framework.github.io/#/
- **Package**: https://anaconda.org/channels/bioconda/packages/poseidon-xerxes/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: xerxes fstats (-d|--baseDir DIR) [-j|--jackknife ARG] 
                     [-e|--excludeChroms ARG] 
                     (--stat ARG | --statConfig ARG | --statFile ARG) 
                     [--noTransitions] [-f|--tableOutFile ARG] 
                     [--blockTableFile ARG]

  Compute f-statistics on groups and invidiuals within and across Poseidon
  packages

Available options:
  -h,--help                Show this help text
  -d,--baseDir DIR         A base directory to search for Poseidon packages.
  -j,--jackknife ARG       Jackknife setting. If given an integer number, this
                           defines the block size in SNPs. Set to "CHR" if you
                           want jackknife blocks defined as entire chromosomes.
                           The default is at 5000 SNPs
  -e,--excludeChroms ARG   List of chromosome names to exclude chromosomes,
                           given as comma-separated list. Defaults to X, Y, MT,
                           chrX, chrY, chrMT, 23,24,90
  --stat ARG               Specify a summary statistic to be computed. Can be
                           given multiple times. Possible options are: F4(a, b,
                           c, d), F3(a, b, c), F3star(a, b, c), F2(a, b), PWM(a,
                           b), FST(a, b), Het(a) and some more special options
                           described at
                           https://poseidon-framework.github.io/#/xerxes?id=fstats-command.
                           Valid entities used in the statistics are group names
                           as specified in the *.fam, *.ind or *.janno failes,
                           individual names using the syntax "<Ind_name>", so
                           enclosing them in angular brackets, and entire
                           packages like "*Package1*" using the Poseidon package
                           title. You can mix entity types, like in
                           "F4(<Ind1>,Group2,*Pac*,<Ind4>)". Group or individual
                           names are separated by commas, and a comma can be
                           followed by any number of spaces.
  --statConfig ARG         Specify a yaml file for the Fstatistics and group
                           configurations
  --statFile ARG           Specify a file with F-Statistics specified similarly
                           as specified for option --stat. One line per
                           statistics, and no new-line at the end
  --maxSnps ARG            Stop after a maximum nr of snps has been processed.
                           Useful for short test runs
  --noTransitions          Skip transition SNPs and use only transversions
  -f,--tableOutFile ARG    a file to which results are written as tab-separated
                           file
  --blockTableFile ARG     a file to which the per-Block results are written as
                           tab-separated file
xerxes v1.0.1.1 for poseidon v2.5.0, v2.6.0, v2.7.0, v2.7.1
https://poseidon-framework.github.io
```

## poseidon-xerxes_ras

### Tool Description
Compute RAS statistics on groups and individuals within and across Poseidon packages

### Metadata
- **Docker Image**: quay.io/biocontainers/poseidon-xerxes:1.0.1.1--hf48d1a7_0
- **Homepage**: https://poseidon-framework.github.io/#/
- **Package**: https://anaconda.org/channels/bioconda/packages/poseidon-xerxes/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: xerxes ras (-d|--baseDir DIR) [-j|--jackknife ARG] 
                  [-e|--excludeChroms ARG] --popConfigFile ARG 
                  (--minAC ARG | --minFreq ARG | --noMinFreq) 
                  (--maxAC ARG | --maxFreq ARG | --noMaxFreq) 
                  [-m|--maxMissingness ARG] [--blockTableFile ARG] 
                  [--f4TableOutFile ARG] [--noTransitions] [--bedFile ARG]

  Compute RAS statistics on groups and individuals within and across Poseidon
  packages

Available options:
  -h,--help                Show this help text
  -d,--baseDir DIR         A base directory to search for Poseidon packages.
  -j,--jackknife ARG       Jackknife setting. If given an integer number, this
                           defines the block size in SNPs. Set to "CHR" if you
                           want jackknife blocks defined as entire chromosomes.
                           The default is at 5000 SNPs
  -e,--excludeChroms ARG   List of chromosome names to exclude chromosomes,
                           given as comma-separated list. Defaults to X, Y, MT,
                           chrX, chrY, chrMT, 23,24,90
  --popConfigFile ARG      a file containing the population configuration
  --minAC ARG              define a minimal allele-count cutoff for the RAS
                           statistics.
  --minFreq ARG            define a minimal allele-frequency cutoff for the RAS
                           statistics.
  --noMinFreq              switch off the minimum allele frequency filter
  --maxAC ARG              define a maximal allele-count cutoff for the RAS
                           statistics.
  --maxFreq ARG            define a maximal allele-frequency cutoff for the RAS
                           statistics.
  --noMaxFreq              switch off the maximum allele frequency filter. This
                           cam help mimic Outgroup-F3
  -m,--maxMissingness ARG  define a maximal missingness for the right
                           populations in the RAS statistics. (default: 0.1)
  --blockTableFile ARG     a file to which the per-Block results are written as
                           tab-separated file
  --f4TableOutFile ARG     a file to which F4 computations are written as
                           tab-separated file
  --maxSnps ARG            Stop after a maximum nr of snps has been processed.
                           Useful for short test runs
  --noTransitions          Skip transition SNPs and use only transversions
  --bedFile ARG            An optional bed file that gives sites to be included
                           in the analysis.
xerxes v1.0.1.1 for poseidon v2.5.0, v2.6.0, v2.7.0, v2.7.1
https://poseidon-framework.github.io
```

## poseidon-xerxes_admixpops

### Tool Description
Generate individuals with randomized genotype profiles based on admixture proportions (experimental)

### Metadata
- **Docker Image**: quay.io/biocontainers/poseidon-xerxes:1.0.1.1--hf48d1a7_0
- **Homepage**: https://poseidon-framework.github.io/#/
- **Package**: https://anaconda.org/channels/bioconda/packages/poseidon-xerxes/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: xerxes admixpops ((-d|--baseDir DIR) | 
                          ((-p|--genoOne FILE) | --inFormat FORMAT
                            --genoFile FILE --snpFile FILE --indFile FILE) 
                          [--snpSet SET]) [-a|--admixString ARG] 
                        [--admixFile ARG] 
                        [--marginalizeMissing | --inChunks [--chunkSize ARG]] 
                        [--outFormat FORMAT] (-o|--outPackagePath DIR) 
                        [-n|--outPackageName STRING] [--outPlinkPopName MODE] 
                        [--onlyLatest]

  Generate individuals with randomized genotype profiles based on admixture
  proportions (experimental)

Available options:
  -h,--help                Show this help text
  -d,--baseDir DIR         A base directory to search for Poseidon packages.
  -p,--genoOne FILE        One of the input genotype data files. Expects .bed,
                           .bim or .fam for PLINK and .geno, .snp or .ind for
                           EIGENSTRAT. The other files must be in the same
                           directory and must have the same base name.
  --inFormat FORMAT        The format of the input genotype data: EIGENSTRAT or
                           PLINK. Only necessary for data input with --genoFile
                           + --snpFile + --indFile.
  --genoFile FILE          Path to the input geno file.
  --snpFile FILE           Path to the input snp file.
  --indFile FILE           Path to the input ind file.
  --snpSet SET             The snpSet of the package: 1240K, HumanOrigins or
                           Other. Only relevant for data input with -p|--genoOne
                           or --genoFile + --snpFile + --indFile, because the
                           packages in a -d|--baseDir already have this
                           information in their respective POSEIDON.yml files.
                           (default: Other)
  -a,--admixString ARG     Artificial individual to generate. Each setup is a
                           string of the form
                           "[id:group](population1=10+population2=30+...)".
                           Multiple setups can be listed separated by ;. id and
                           group are simple strings. The population fractions
                           must be simple integers and sum to 100.
  --admixFile ARG          A file with admixStrings. Works just as -a, but
                           multiple values can be given separated by newline. -a
                           and --admixFile can be combined.
  --marginalizeMissing     ignore missing SNPs in the per-population genotype
                           frequency calculation (except all individuals have
                           missing information for a given SNP)
  --inChunks               construct the artificial individuals by sampling
                           contiguous stretches of SNPs ('chunks') from random
                           individuals in the source populations
  --chunkSize ARG          The number of SNPs in one chunks (default: 5000)
  --outFormat FORMAT       The format of the output genotype data: EIGENSTRAT or
                           PLINK. (default: PLINK)
  -o,--outPackagePath DIR  Path to the output package directory.
  -n,--outPackageName STRING
                           The output package name. This is optional: If no name
                           is provided, then the package name defaults to the
                           basename of the (mandatory) --outPackagePath
                           argument. (default: Nothing)
  --outPlinkPopName MODE   Where to write the population/group name into the FAM
                           file in Plink-format. Three options are possible:
                           asFamily (default) | asPhenotype | asBoth. See also
                           --inPlinkPopName.
  --onlyLatest             Consider only the latest versions of packages, or the
                           groups and individuals within the latest versions of
                           packages, respectively.
xerxes v1.0.1.1 for poseidon v2.5.0, v2.6.0, v2.7.0, v2.7.1
https://poseidon-framework.github.io
```
