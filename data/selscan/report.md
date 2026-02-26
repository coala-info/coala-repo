# selscan CWL Generation Report

## selscan

### Tool Description
A program to calculate EHH-based scans for positive selection in genomes, implementing EHH, iHS, XP-EHH, and nSL.

### Metadata
- **Docker Image**: quay.io/biocontainers/selscan:1.2.0a--hb66fcc3_7
- **Homepage**: https://github.com/szpiech/selscan
- **Package**: https://anaconda.org/channels/bioconda/packages/selscan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/selscan/overview
- **Total Downloads**: 17.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/szpiech/selscan
- **Stars**: N/A
### Original Help Text
```text
selscan v1.2.0

selscan v1.2.0 -- a program to calculate EHH-based scans for positive selection in genomes.
Source code and binaries can be found at <https://www.github.com/szpiech/selscan>.

selscan currently implements EHH, iHS, XP-EHH, and nSL.

Citations:

ZA Szpiech and RD Hernandez (2014) MBE, 31: 2824-2827.
A Ferrer-Admetlla, et al. (2014) MBE, 31: 1275-1291.
PC Sabeti, et al. (2007) Nature, 449: 913–918.
BF Voight, et al. (2006) PLoS Biology, 4: e72.
PC Sabeti, et al. (2002) Nature, 419: 832–837.

To calculate EHH:

./selscan --ehh <locusID> --hap <haps> --map <mapfile> --out <outfile>

To calculate iHS:

./selscan --ihs --hap <haps> --map <mapfile> --out <outfile>

To calculate nSL:

./selscan --nsl --hap <haps> --map <mapfile> --out <outfile>
To calculate iHH12:

./selscan --ihh12 --hap <haps> --map <mapfile> --out <outfile>

To calculate XP-EHH:

./selscan --xpehh --hap <pop1 haps> --ref <pop2 haps> --map <mapfile> --out <outfile>

----------Command Line Arguments----------

--alt <bool>: Set this flag to calculate homozygosity based on the sum of the
	squared haplotype frequencies in the observed data instead of using
	binomial coefficients.
	Default: false

--cutoff <double>: The EHH decay cutoff.
	Default: 0.05

--ehh <string>: Calculate EHH of the '1' and '0' haplotypes at the specified
	locus. Output: <physical dist> <genetic dist> <'1' EHH> <'0' EHH>
	Default: __NO_LOCUS__

--ehh-win <int>: When calculating EHH, this is the length of the window in bp
	in each direction from the query locus.
	Default: 100000

--gap-scale <int>: Gap scale parameter in bp. If a gap is encountered between
	two snps > GAP_SCALE and < MAX_GAP, then the genetic distance is
	scaled by GAP_SCALE/GAP.
	Default: 20000

--hap <string>: A hapfile with one row per haplotype, and one column per
	variant. Variants should be coded 0/1
	Default: __hapfile1

--help <bool>: Prints this help dialog.
	Default: false

--ihh12 <bool>: Set this flag to calculate iHH12.
	Default: false

--ihs <bool>: Set this flag to calculate iHS.
	Default: false

--ihs-detail <bool>: Set this flag to write out left and right iHH scores for '1' and '0' in addition to iHS.
	Default: false

--keep-low-freq <bool>: Include low frequency variants in the construction of your haplotypes.
	Default: false

--maf <double>: If a site has a MAF below this value, the program will not use
	it as a core snp.
	Default: 0.05

--map <string>: A mapfile with one row per variant site.
	Formatted <chr#> <locusID> <genetic pos> <physical pos>.
	Default: __mapfile

--max-extend <int>: The maximum distance an EHH decay curve is allowed to extend from the core.
	Set <= 0 for no restriction.
	Default: 1000000

--max-extend-nsl <int>: The maximum distance an nSL haplotype is allowed to extend from the core.
	Set <= 0 for no restriction.
	Default: 100

--max-gap <int>: Maximum allowed gap in bp between two snps.
	Default: 200000

--nsl <bool>: Set this flag to calculate nSL.
	Default: false

--out <string>: The basename for all output files.
	Default: outfile

--pi <bool>: Set this flag to calculate mean pairwise sequence difference in a sliding window.
	Default: false

--pi-win <int>: Sliding window size in bp for calculating pi.
	Default: 100

--ref <string>: A hapfile with one row per haplotype, and one column per
	variant. Variants should be coded 0/1. This is the 'reference'
	population for XP-EHH calculations.  Ignored otherwise.
	Default: __hapfile2

--skip-low-freq <bool>: **This flag is now on by default. If you want to include low frequency variants
in the construction of your haplotypes please use the --keep-low-freq flag.
	Default: false

--threads <int>: The number of threads to spawn during the calculation.
	Partitions loci across threads.
	Default: 1

--tped <string>: A TPED file containing haplotype and map data.
	Variants should be coded 0/1
	Default: __hapfile1

--tped-ref <string>: A TPED file containing haplotype and map data.
	Variants should be coded 0/1. This is the 'reference'
	population for XP-EHH calculations and should contain the same number
	of loci as the query population. Ignored otherwise.
	Default: __hapfile2

--trunc-ok <bool>: If an EHH decay reaches the end of a sequence before reaching the cutoff,
	integrate the curve anyway (iHS and XPEHH only).
	Normal function is to disregard the score for that core.
	Default: false

--vcf <string>: A VCF file containing haplotype data.
	A map file must be specified with --map.
	Default: __hapfile1

--vcf-ref <string>: A VCF file containing haplotype and map data.
	Variants should be coded 0/1. This is the 'reference'
	population for XP-EHH calculations and should contain the same number
	of loci as the query population. Ignored otherwise.
	Default: __hapfile2

--xpehh <bool>: Set this flag to calculate XP-EHH.
	Default: false
```

