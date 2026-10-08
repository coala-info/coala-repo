# merlin CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| merlin_assoc | PASS |  |
| merlin_best | PASS |  |
| merlin_cfreq | PASS |  |
| merlin_deviates | PASS |  |
| merlin_error | PASS |  |
| merlin_extended | PASS |  |
| merlin_fastassoc | PASS |  |
| merlin_frequencies | PASS |  |
| merlin_hapmapConverter | PASS | MERLIN example HapMap.template and HapMap.genotypes: 99 SNPs and 90 individuals converted, genotypes of NA12003 match the HapMap file (missing N written as ./.). |
| merlin_ibd | PASS |  |
| merlin_infer | PASS |  |
| merlin_information | PASS |  |
| merlin_kinship | PASS |  |
| merlin_likelihood | PASS |  |
| merlin_matrices | PASS |  |
| merlin_minx | PASS | Galaxy tools-iuc X-chromosome pedigrees (x.*): minx --best gave valid X-linked haplotypes with male hemizygous alleles and no inheritance errors, while plain merlin flags BAD INHERITANCE on the same data. |
| merlin_minx-offline | PASS | same autosomal assoc.* data as merlin_offline (no suitable biallelic X data exists in the test sets): table matches merlin --fastAssoc. |
| merlin_model | PASS |  |
| merlin_npl | PASS |  |
| merlin_offline | PASS | Galaxy tools-iuc assoc.* data with genotypes inferred by merlin --infer: tabulated SNP association results match merlin --fastAssoc (SNP11 peak LOD 8.52, p 3.7e-10). |
| merlin_pairs | PASS |  |
| merlin_pedmerge | PASS | merged Galaxy tools-iuc basic2.* and assoc.* sets: all individuals and markers kept in the right columns (it also appends an end line to the pedigree file). |
| merlin_pedstats | PASS | Galaxy tools-iuc haplo.* data: counts match the pedigree file (9 individuals, 6 founders, 3 families, 3 females and 6 males); PDF, rewritten pedigree and marker tables were written. |
| merlin_pedwipe | PASS | Galaxy tools-iuc error.* data with the merlin --error list: exactly the 14 listed genotypes were set to 0/0 in wiped.ped. |
| merlin_qtl | PASS |  |
| merlin_regress | PASS | Galaxy tools-iuc assoc.* data, --randomSample model: LOD peaks of 3.9 on chromosome 4 near 56.5 cM, in the same region as merlin --vc (LOD 2.1). |
| merlin_sample | PASS |  |
| merlin_select | PASS |  |
| merlin_simulate | PASS |  |
| merlin_vc | PASS |  |

## merlin_information

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter information (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_likelihood

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter likelihood (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_model

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter model (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_ibd

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter ibd (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_kinship

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter kinship (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_matrices

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter matrices (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_extended

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter extended (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_select

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter select (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_npl

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter npl (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_pairs

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter pairs (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_qtl

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter qtl (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_deviates

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter deviates (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_vc

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter vc (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_infer

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter infer (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_assoc

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter assoc (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_fastassoc

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter fastassoc (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_best

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter best (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_sample

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter sample (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_cfreq

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter cfreq (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_frequencies

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter frequencies (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_simulate

### Tool Description
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []

WARNING - 
Problems encountered parsing command line:

Command line parameter simulate (#1) ignored
Command line parameter --help is undefined

FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_error

### Tool Description
MERLIN 1.1.2 --error: find unlikely genotypes; likely errors are listed in merlin.err

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]


The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --extended, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --noCoupleBits, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []


FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_minx

### Tool Description
MERLIN 1.1.2 with chromosome X support: linkage analysis, IBD and haplotype estimation, error detection and association analysis for X-linked pedigree data.

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis
Modifications: CHROMOSOME-X 

References for this version of Merlin:

   Abecasis et al (2002) Nat Gen 30:97-101        [original citation]
   Fingerlin et al (2004) AJHG 74:432-43          [case selection for association studies]
   Abecasis and Wigginton (2005) AJHG 77:754-67   [ld modeling, parametric analyses]
   Fingerlin et al (2006) Gen Epidemiol 30:384-96 [sex-specific maps]
   Chen and Abecasis (2007) AJHG 81:913-26        [qtl association analysis, qtl simulation]


The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Data Analysis Options
         General : --error, --information, --likelihood, --model [param.tbl]
      IBD States : --ibd, --kinship, --matrices, --select
     NPL Linkage : --npl, --pairs, --qtl, --deviates, --exp
      VC Linkage : --vc, --useCovariates, --ascertainment, --unlinked [0.00]
     Association : --infer, --assoc, --fastAssoc, --filter, --custom [cov.tbl]
     Haplotyping : --best, --sample, --all, --founders, --horizontal
   Recombination : --zero, --one, --two, --three, --singlepoint
       Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     LD Clusters : --clusters [], --distance, --rsq, --cfreq
          Limits : --bits [24], --megabytes, --minutes
     Performance : --trim, --swap, --smallSwap
          Output : --quiet, --markerNames, --frequencies, --perFamily, --pdf,
                   --tabulate, --prefix [merlin]
      Simulation : --simulate, --reruns, --save, --trait []


FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_regress

### Tool Description
MERLIN regression: multipoint regression-based linkage analysis of quantitative traits in pedigrees.

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN 1.1.2 - (c) 2000-2003 Goncalo Abecasis

The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
            Missing Value Code :         -99.999 (-xname)
                      Map File :      merlin.map (-mname)
             Trait Models File :      models.tbl (-tname)
            Allele Frequencies : ALL INDIVIDUALS (-f[a|e|f|m|file])
                   Random Seed :          123456 (-r9999)

Regression Analysis Options
          User Model : --mean [0.00], --variance [1.00], --heritability [0.50],
                       --testRetest [1.00]
    Automatic Models : --randomSample, --useCovariates, --sexAsCovariate,
                       --inverseNormal
              Errors : --perAllele [0.00], --perGenotype [0.00], --fit
       Recombination : --zero, --one, --two, --three, --singlepoint
           Positions : --steps, --maxStep, --minStep, --grid, --start, --stop
     Marker Clusters : --clusters [], --distance, --rsq
   Basic Performance : --bits [24], --megabytes, --minutes, --trim
         Performance : --noCoupleBits, --swap, --cache []
              Output : --prefix [merlin], --pdf, --tabulate, --quiet,
                       --markerNames
              Others : --simulate, --reruns, --rankFamilies, --unrestriced


FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_offline

### Tool Description
MERLIN offline association analysis using genotypes inferred earlier with merlin --infer.

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN -- Offline Association Analysis
          (c) 2006-2007 Goncalo Abecasis


The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
                      Map File :      merlin.map (-mname)
                Frequency File :     merlin.freq (-fname)

Additional Options
   Inferred Genotypes : --datinfer [merlin-infer.dat],
                        --pedinfer [merlin-infer.ped]
     Analysis Options : --inverseNormal, --useCovariates, --filter,
                        --custom [covars.tbl]
         Output Files : --prefix [merlin], --pdf, --tabulate


FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_minx-offline

### Tool Description
MERLIN offline association analysis for the X chromosome (minx-offline).

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
MERLIN -- Offline Association Analysis
          (c) 2006-2007 Goncalo Abecasis


The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
                      Map File :      merlin.map (-mname)
                Frequency File :     merlin.freq (-fname)

Additional Options
   Inferred Genotypes : --datinfer [merlin-infer.dat],
                        --pedinfer [merlin-infer.ped]
     Analysis Options : --inverseNormal, --useCovariates, --filter,
                        --custom [covars.tbl]
         Output Files : --prefix [merlin], --pdf, --tabulate


FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_pedstats

### Tool Description
Pedigree Statistics: summarise pedigree structure, phenotypes, genotypes and Mendelian consistency.

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/pedstats
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
Pedigree Statistics - 0.6.10
(c) 1999-2006 Goncalo Abecasis, 2002-2006 Jan Wigginton

The following parameters are in effect:
                 Pedigree File :    pedstats.ped (-pname)
                     Data File :    pedstats.dat (-dname)
                      IBD File :    pedstats.ibd (-iname)
                Adobe PDF File :    pedstats.pdf (-aname)
            Missing Value Code :         -99.999 (-xname)

Additional Options
    Pedigree File : --ignoreMendelianErrors, --chromosomeX, --trim
   Hardy-Weinberg : --hardyWeinberg, --showAll, --cutoff [0.05]
        HW Sample : --checkFounders, --checkAll, --checkUnrelated
           Output : --pairs, --rewritePedigree, --markerTables, --verbose
         Grouping : --bySex, --byFamily
     Age Checking : --age [], --birth []
      Generations : --minGap [13.00], --maxGap [70.00], --sibGap [30.00]
      PDF Options : --pdf, --familyPDF, --traitPDF, --affPDF, --markerPDF
           Filter : --minGenos, --minPhenos, --minCovariates, --affectedFor []


FATAL ERROR - 
The datafile pedstats.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_pedwipe

### Tool Description
PedWipe: automatically wipe out genotypes listed in a MERLIN error file from a pedigree file.

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
PedWipe - (c) 2000 Goncalo Abecasis
Automatically wipe out genotypes from a pedigree file


The following parameters are in effect:
                     Data File :      merlin.dat (-dname)
                 Pedigree File :      merlin.ped (-pname)
                   Errors File :      merlin.err (-ename)
                  Show Tallies :             OFF (-t[+|-])


FATAL ERROR - 
The datafile merlin.dat cannot be opened

Common causes for this problem are:
  * You might not have used the correct options to specify input file names,
    please check the program documentation for information on how to do this

  * The file doesn't exist or the filename might have been misspelt

  * The file exists but it is being used by another program which you will need
    to close before continuing

  * The file is larger than 2GB and you haven't compiled this application with
    large file support.
```

## merlin_pedmerge

### Tool Description
PedMerge: merge a set of paired pedigree and data files into a single composite pedigree.

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
PedMerge - Pedigree Merge (c) 1999 Goncalo Abecasis

Usage: pedmerge input1 input2 ... output

This program will try to merge a set of paired pedigree (.ped)
and data (.dat) files into a single composite pedigree.

For example:

    > pedmerge a b c

Will create the files c.dat and c.ped including all the phenotype
data and individuals in a.dat, a.ped, b.dat and b.ped.

WARNING: pedmerge will overwrite output files without checking
```

## merlin_hapmapConverter

### Tool Description
hapmapConverter: convert genotype files downloaded from the HapMap website into MERLIN format.

### Metadata
- **Docker Image**: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
- **Homepage**: http://csg.sph.umich.edu/abecasis/merlin
- **Package**: https://anaconda.org/channels/bioconda/packages/merlin/overview
- **Validation**: PASS

### Original Help Text
```text
hapmapConverter -- (c) 2004-2007 Goncalo Abecasis

This program converts genotype files downloaded from the HapMap website
into MERLIN format. Sample pedigree template and genotype files are 
included in the MERLIN examples subdirectory


The following parameters are in effect:
             Pedigree Template :                 (-tname)
                 Genotype File :                 (-gname)
               Output Map File :         mapfile (-mname)
              Output Data File :         datfile (-dname)
          Output Pedigree File :         pedfile (-pname)
               Use Coriell Ids :             OFF (-c[+|-])


FATAL ERROR - 
Opening template file
```

## Metadata
- **Skill**: generated
