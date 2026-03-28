# wisecondorx CWL Generation Report

## wisecondorx_convert

### Tool Description
Convert and filter a aligned reads to .npz

### Metadata
- **Docker Image**: quay.io/biocontainers/wisecondorx:1.2.9--pyhdfd78af_0
- **Homepage**: https://github.com/CenterForMedicalGeneticsGhent/wisecondorX
- **Package**: https://anaconda.org/channels/bioconda/packages/wisecondorx/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/wisecondorx/overview
- **Total Downloads**: 69.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CenterForMedicalGeneticsGhent/wisecondorX
- **Stars**: N/A
### Original Help Text
```text
usage: wisecondorx convert [-h] [-r REFERENCE] [--binsize BINSIZE] [--normdup]
                           infile outfile

Convert and filter a aligned reads to .npz

positional arguments:
  infile                aligned reads input for conversion
  outfile               Output .npz file

options:
  -h, --help            show this help message and exit
  -r REFERENCE, --reference REFERENCE
                        Fasta reference to be used during cram conversion
                        (default: None)
  --binsize BINSIZE     Bin size (bp) (default: 5000.0)
  --normdup             Do not remove duplicates (default: False)
```


## wisecondorx_newref

### Tool Description
Create a new reference using healthy reference samples

### Metadata
- **Docker Image**: quay.io/biocontainers/wisecondorx:1.2.9--pyhdfd78af_0
- **Homepage**: https://github.com/CenterForMedicalGeneticsGhent/wisecondorX
- **Package**: https://anaconda.org/channels/bioconda/packages/wisecondorx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: wisecondorx newref [-h] [--nipt] [--yfrac YFRAC]
                          [--plotyfrac PLOTYFRAC] [--refsize REFSIZE]
                          [--binsize BINSIZE] [--cpus CPUS]
                          infiles [infiles ...] outfile

Create a new reference using healthy reference samples

positional arguments:
  infiles               Path to all reference data files (e.g.
                        path/to/reference/*.npz)
  outfile               Path and filename for the reference output (e.g.
                        path/to/myref.npz)

options:
  -h, --help            show this help message and exit
  --nipt                Use flag for NIPT (e.g. path/to/reference/*.npz)
                        (default: False)
  --yfrac YFRAC         Use to manually set the y read fraction cutoff, which
                        defines gender (default: None)
  --plotyfrac PLOTYFRAC
                        Path to yfrac .png plot for --yfrac optimization (e.g.
                        path/to/plot.png); software will stop after plotting
                        after which --yfrac can be set manually (default:
                        None)
  --refsize REFSIZE     Amount of reference locations per target (default:
                        300)
  --binsize BINSIZE     Scale samples to this binsize, multiples of existing
                        binsize only (default: 100000.0)
  --cpus CPUS           Use multiple cores to find reference bins (default: 1)
```


## wisecondorx_gender

### Tool Description
Returns the gender of a .npz resulting from convert, based on a Gaussian mixture model trained during the newref phase

### Metadata
- **Docker Image**: quay.io/biocontainers/wisecondorx:1.2.9--pyhdfd78af_0
- **Homepage**: https://github.com/CenterForMedicalGeneticsGhent/wisecondorX
- **Package**: https://anaconda.org/channels/bioconda/packages/wisecondorx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: wisecondorx gender [-h] infile reference

Returns the gender of a .npz resulting from convert, based on a Gaussian
mixture model trained during the newref phase

positional arguments:
  infile      .npz input file
  reference   Reference .npz, as previously created with newref

options:
  -h, --help  show this help message and exit
```


## wisecondorx_predict

### Tool Description
Find copy number aberrations

### Metadata
- **Docker Image**: quay.io/biocontainers/wisecondorx:1.2.9--pyhdfd78af_0
- **Homepage**: https://github.com/CenterForMedicalGeneticsGhent/wisecondorX
- **Package**: https://anaconda.org/channels/bioconda/packages/wisecondorx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: wisecondorx predict [-h] [--minrefbins MINREFBINS]
                           [--maskrepeats MASKREPEATS] [--alpha ALPHA]
                           [--zscore ZSCORE] [--beta BETA]
                           [--blacklist BLACKLIST] [--gender {F,M}]
                           [--ylim YLIM] [--bed] [--plot] [--cairo]
                           [--add-plot-title] [--seed SEED]
                           infile reference outid

Find copy number aberrations

positional arguments:
  infile                .npz input file
  reference             Reference .npz, as previously created with newref
  outid                 Basename (w/o extension) of output files (paths are
                        allowed, e.g. path/to/ID_1)

options:
  -h, --help            show this help message and exit
  --minrefbins MINREFBINS
                        Minimum amount of sensible reference bins per target
                        bin. (default: 150)
  --maskrepeats MASKREPEATS
                        Regions with distances > mean + sd * 3 will be masked.
                        Number of masking cycles. (default: 5)
  --alpha ALPHA         p-value cut-off for calling a CBS breakpoint.
                        (default: 0.0001)
  --zscore ZSCORE       z-score cut-off for aberration calling. (default: 5)
  --beta BETA           When beta is given, --zscore is ignored and a ratio
                        cut-off is used to call aberrations. Beta is a number
                        between 0 (liberal) and 1 (conservative) and is
                        optimally close to the purity. (default: None)
  --blacklist BLACKLIST
                        Blacklist that masks regions in output, structure of
                        header-less file: chr...(/t)startpos(/t)endpos(/n)
                        (default: None)
  --gender {F,M}        Force WisecondorX to analyze this case as a male (M)
                        or a female (F) (default: None)
  --ylim YLIM           y-axis limits for plotting. e.g. [-2,2] (default: def)
  --bed                 Outputs tab-delimited .bed files, containing the most
                        important information (default: False)
  --plot                Outputs .png plots (default: False)
  --cairo               Uses cairo bitmap type for plotting. Might be
                        necessary for certain setups. (default: False)
  --add-plot-title      Add the output name as plot title (default: False)
  --seed SEED           Seed for segmentation algorithm (default: None)
```


## Metadata
- **Skill**: generated
