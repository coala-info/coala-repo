![GLIMPSE1](images/branding/glimpse_logo_300dpi.png)

# **G**enotype **L**ikelihoods **IM**putation and **P**ha**S**ing m**E**thod

#### Version 1

27/11/2022: This page describes the **GLIMPSE1** method. **GLIMPSE1** is recommended to the users who want to use the joint model, for imputation of >1x data and a moderate sized reference panels. For large reference panels and lower coverages, we recommend the use of the [**GLIMPSE2** method](https://github.com/odelaneau/GLIMPSE)

**GLIMPSE1** is a phasing and imputation method for large-scale low-coverage sequencing studies.

Main features of the method:

1. **Accurate imputed genotype calls.** Our method takes advantage of reference panels to produce high quality genotype calls.
2. **Accurate phasing.** GLIMPSE1 outputs accurate phased haplotypes for the low-coverage sequenced dataset.
3. **Low-coverage sequencing outperforms SNP arrays.**
   Imputation using low-coverage sequencing data is competitive to SNP array imputation.
   Results for [European](rsquare_eur.html) and [African-American](rsquare_asw.html) populations are interactively available on the website.- **A cost-effective paradigm.** GLIMPSE1 realises whole genome imputation from the HRC reference panel for less than 1$.
   - **An easy-to-use framework for diploid, haploid and mixed ploidy imputation.** Our method is able to perform imputation of samples with different ploidy without the need to split the data.

GLIMPSE1 is available under the [MIT licence](https://en.wikipedia.org/wiki/MIT_License) on the Github repository <https://github.com/odelaneau/GLIMPSE>.

If you use the GLIMPSE1 in your research work, please cite the following paper:

[Simone Rubinacci, Diogo Ribeiro, Robin Hofmeister, Olivier Delaneau. Efficient phasing and imputation of low-coverage sequencing data using large reference panels. Nature Genetics 53.1 (2021): 120-126.](https://www.nature.com/articles/s41588-020-00756-0)

GLIMPSE1 is developed by Simone Rubinacci and Olivier Delaneau at the University of Lausanne, Switzerland.

[![](images/lausanne_logo.jpg)](https://www.unil.ch/index.html)

[![](images/sib_logo.jpg)](https://www.sib.swiss/)

[![](images/snf.gif)](http://www.snf.ch/en/Pages/default.aspx)

### GLIMPSE1 tools

### GLIMPSE1 chunk

**Version 1.1.1**

Defines chunks where to run phasing and imputation.

[Documentation](commands.html#chunk)

### GLIMPSE1 phase

**Version 1.1.1**

Performs phasing and imputation refining genotype likelihoods.

[Documentation](commands.html#phase)

### GLIMPSE1 ligate

**Version 1.1.1**

Concatenates chunks ligating phased information.

[Documentation](commands.html#ligate)

### GLIMPSE1 sample

**Version 1.1.1**

Generates haplotype calls by sampling haplotypes.

[Documentation](commands.html#sample)

### Dashboard

[**21/05/2021: Version 1.1.1 is available on Github!**](https://github.com/odelaneau/GLIMPSE) An updated version of GLIMPSE1 is now available!

07/01/2021: The manuscript describing GLIMPSE1 is now published in **[Nature Genetics!](https://www.nature.com/articles/s41588-020-00756-0)**

[**07/10/2020: Version 1.1.0 is available on Github!**](https://github.com/odelaneau/GLIMPSE) An updated version of GLIMPSE1 designed for diploid/haploid/mixed ploidy imputation is now available!

07/10/2020: A tutorial for non-PAR chrX imputation is now available! Click [here](tutorial_chrX.html) to check it out!

07/10/2020: A tutorial for GRCh37/hg19 assembly is now available! Click [here](tutorial_hg19.html)!

[**15/04/2020: Version 1.0.0 is available on Github!**](https://github.com/odelaneau/GLIMPSE) Check our Github page to download version 1.0.0 and have a GLIMPSE1 of your data

**03/04/2020: A tutorial for GRCh38/hg38 build is now available.** Click [here](tutorial_b38.html) to start running GLIMPSE1.

Copyright © 2020 University of Lausanne | All Rights Reserved