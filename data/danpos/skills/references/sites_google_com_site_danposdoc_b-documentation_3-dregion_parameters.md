Search this site

Embedded Files

Skip to main content

Skip to navigation

[DANPOS](/site/danposdoc/home)

* [Home](/site/danposdoc/home)
* [A. Tutorial](/site/danposdoc/a-tutorial)

  + [(1) Dpos](/site/danposdoc/a-tutorial/1-dpos)
  + [(2) Dpeak](/site/danposdoc/a-tutorial/2-dpeak)
  + [(3) Dregion](/site/danposdoc/a-tutorial/3-dregion)
  + [(4) Dtriple](/site/danposdoc/a-tutorial/4-dtriple)
  + [(5) Profile](/site/danposdoc/a-tutorial/5-profile)
  + [(6) stat](/site/danposdoc/a-tutorial/6-stat)
  + [(7) wiq](/site/danposdoc/a-tutorial/7-wiq)
  + [(8) wig2wiq](/site/danposdoc/a-tutorial/8-wig2wiq)
* [B. Documentation](/site/danposdoc/b-documentation)

  + [(1) Dpos](/site/danposdoc/b-documentation/1-dpos)

    - [Input files](/site/danposdoc/b-documentation/1-dpos/input-files)
    - [Output files](/site/danposdoc/b-documentation/1-dpos/output-files)
    - [parameters](/site/danposdoc/b-documentation/1-dpos/parameters)
  + [(2) dpeak](/site/danposdoc/b-documentation/2-dpeak)

    - [Input files](/site/danposdoc/b-documentation/2-dpeak/input-files)
    - [Output files](/site/danposdoc/b-documentation/2-dpeak/output-files)
    - [Parameters](/site/danposdoc/b-documentation/2-dpeak/parameters)
  + [(3) dregion](/site/danposdoc/b-documentation/3-dregion)

    - [Input files](/site/danposdoc/b-documentation/3-dregion/input-files)
    - [Output files](/site/danposdoc/b-documentation/3-dregion/output-files)
    - [Parameters](/site/danposdoc/b-documentation/3-dregion/parameters)
  + [(4) Dtriple](/site/danposdoc/b-documentation/4-dtriple)
  + [(5) Profile](/site/danposdoc/b-documentation/5-profile)

    - [Input files](/site/danposdoc/b-documentation/5-profile/input-files)
    - [Output files](/site/danposdoc/b-documentation/5-profile/output-files)
    - [Parameters](/site/danposdoc/b-documentation/5-profile/parameters)
  + [(6) stat](/site/danposdoc/b-documentation/6-stat)
  + [(7) WIQ](/site/danposdoc/b-documentation/7-wiq)

    - [Input files](/site/danposdoc/b-documentation/7-wiq/input-files)
    - [Output files](/site/danposdoc/b-documentation/7-wiq/output-files)
    - [parameters](/site/danposdoc/b-documentation/7-wiq/parameters)
  + [(8) Wig2Wiq](/site/danposdoc/b-documentation/8-wig2wiq)

    - [Input files](/site/danposdoc/b-documentation/8-wig2wiq/input-files)
    - [Output files](/site/danposdoc/b-documentation/8-wig2wiq/output-files)
    - [Parameters](/site/danposdoc/b-documentation/8-wig2wiq/parameters)
* [C. Install](/site/danposdoc/c-install)
* [D. Download](/site/danposdoc/d-download)
* [E. Help](/site/danposdoc/e-help)

[DANPOS](/site/danposdoc/home)

# Parameters

usage:

python danpos.py <command> <path> [optional arguments]

positional arguments:

* **command**
* set as 'dregion'.
* **path**
* The path to sequencing data. It could be:
* **(a)** a single file contain sequencing reads in .bed, .bam, .sam, .bowtie formats or containing reads density value in .wig format, e.g., /rawData/KnockOut/knockOut.bam. For more information about data Please format, see [https://sites.google.com/site/danposdoc/home/dpos/input-files](/site/danposdoc/b-documentation/1-dpos/input-files)

  + **(b)** a directory containing multiple files. The multiple files in the same directory will be recognized as replicates that belong to a single data set. e.g., a path /rawData/knockOut/ may contain two files KnockOutRep1.bam and knockOutRep2.bam, which means there are two replicates for the single data set.
  + **(c)** multiple paths. Different paths should be separated by ',', e.g., rawData/KnockOutA/,raw\_data/KnockOutB.bam, so danpos will analyze KnockOutA/ and KnockOutB.bam independently as two data sets.
  + **(d)** a pair of paths to be compare with each other. The two paths in each pair should be separated by ":", e.g., KnockOutA/:wildType.bam, so danpos will compare KnockOutA to wildType.bam Note: please DO NOT arrange the background data (always named as input data by biologist, e.g., IgG ChIP-Seq) in this way, see the parameter -b.
  + **(e)** multiple pairs of path. e.g.,KnockOutA/:wildType.bam,KnockOutB.bam:wildType.bam, so danpos will compare KnockOutA/ to wildType.bam and compare KnockOutB.bam to wildType.bam.

optional arguments:

* **-h, --help**  show help message and exit.

--------------------------

--- general parameters ---

--------------------------

* **-p , --pheight**  occupancy (reads density) P value cutoff for defining

  + individual protein binding region. Setting to a value 0 will disable this parameter and use the parameter -q as an instead (default: 1e-10)
  + **-q , --height** occupancy (reads density) cutoff for defining individual protein binding region. Setting to a value 0 will disable this parameter and use the parameter -p as an instead (default: 0)
* **-t , --testcut**  P value cutoff for defining region based on **difference in protein binding occupancy** between each pair of datasets. Set as 0 will disable this parameter, then regions will be defined solely based on **occupancy** cutoff (-p or -q), but a P value of difference will still be calculated at each region for each pair of data sets. (default: 0)
* **-o , --out**  a name for the output directory (default: result)
* **-f , --fdr**  set to 0 if need not to calculate FDR values (slow process), else set to 1. (default: 1)
* **-s , --save**  set to 0 if need not to save middle-stage files, otherwise set to 1 (default: 0)

  + **-b , --bg** The paths used to specify background data for experimental data. Background data is always called 'input', e.g., IgG ChIP-Seq data. Experimental data may comes from either the treatment or control experiment, e.g., the knockout sample or wild type sample. This parameter could be:
  + **(a)** a single background data set for all experimental data set, e.g. rawData/IgG/.
  + **(b)** Different background data sets for different experimental data sets. E.g., KnockOutA/:IgGA/,knockOutB/:IgGB.bam, Means IgGA/ contains the background data for knockOutA, and IgGB.bam is the background data for knockOutB.

--------------------------

--- region calling ---

--------------------------

* -rd , --region\_dis minimal tail-to-head distance between neighboring regions (bp), neighboring regions closer than -rd will be merged as one single region (default: 3000)
* -rw , --region\_width minimal width of each region (default: 40)
* -rf , --region\_reference A file containing a set of reference regions. When this parameter is specified, Dregion will not call regions, but simply assign values for the reference regions provided in this file. (default: None)

--------------------------

---occupancy processing---

--------------------------

* **-c , --count**  specify reads number, then reads number in each data set will be normalized to this value, e.g. 10000000. Or specify a number for each group, e.g. file1.bed:10000000,dir2/:20000000,dir3/:15000000, Do this only when you are clear about what you are doing, e.g. when you have spike-ins to measure the real reads count for each sample (default: None)
* **-a , --span** the span or step size in wiggle (.wig) file generated by Danpos (default: 10)
* **-z , --smooth\_width** the window size used to smooth the data before defining position, set to 0 if need not to smooth (default: 20)
* **-L , --exclude\_low\_percent** the percent of extremely low occupancy positions to be excluded in determining normalization factors, may be helpful to avoid the influence of background noise on normalization. MUST BE USED WITH CAUTIONS! (default: 0)
* **-H , --exclude\_high\_percent** the percent of extremely high occupancy positions to be excluded in determining normalization factors, may be helpful to avoid the influence of some highly clonal reads or repeat regions on normalization. MUST BE USED WITH CAUTIONS! (default: 0)
* **-l , --lmd**  lambda width for smoothing background data before background subtraction, ignore this when the parameter -b is not specified. (default: 300)
* **-n , --nor**  data normalization method, could be 'F','S' or 'N', representing normalizing by fold change, normalizing by sampling, or no normalization (default: F)
* **-N , --nor\_region\_file** A '.wig' format file to denote the regions that could be used to calculate normalization factors. Regions to be used and not used should be assigned a value 1 and 0 in this .wig file, respectively. MUST BE USED WITH CAUTIONS! (default: None)
* **--nonzero** set to 1 if want to normalize all base pairs with non-zero values to have the same average value between different data sets. This function will be useful when some data sets has significant clonal effect, E.g. one data set has non-zero value at 10 percent of base pairs and each non-zero vase pair has 8 fold clonal effects, whereas another data set has non-zero value at 40 percent of base pairs and each non-zero base pair has 2 fold clonal effects. MUST BE USED WITH CAUTIONS! (default: 0)

--------------------------

--- reads processing ---

--------------------------

Please ignore the parameters below if all data is the wiggle format occupancy data.

* **-m , --paired** set to 1 if the input data is mate-pair (paired-end) reads. (default: 0)

  + **-u , --clonalcut**  the cutoff for adjusting clonal signal, set as a P value larger than 0 and smaller than 1, e.g 1e-10, or set as a integer reads count, set as 0 if don't need to adjust clonal signal. (default: 0)
* **--frsz**  specify the average size of DNA fragments in the seuqnecing experiment. By default it is automatically detected by DANPOS. (default: None)
* **--mifrsz** minimal size of the DNA fragments, DANPOS will select a most probable value for --frsz within the range between --mifrsz and --mafrsz values. ignore this when '--frsz' has been specified. (default: 50)
* **--mafrsz** maximal size of the DNA fragments, DANPOS will select a most probable value for --frsz within the range between --mifrsz and --mafrsz values. ignore this when '--frsz' has been specified. (default: 300)
* **--extend**  specify the size that each fragment will be extended to, the size of each fragment will be adjusted to this size when reads data is converted to occupancy data. (default: 80)

Google Sites

Report abuse

Page details

Page updated

Google Sites

Report abuse