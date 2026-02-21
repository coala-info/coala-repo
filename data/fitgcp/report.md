# fitgcp CWL Generation Report

## fitgcp

### Tool Description
Fits mixtures of probability distributions to genome coverage profiles using an EM-like iterative algorithm. The script uses a SAM file as input and parses the mapping information and creates a Genome Coverage Profile (GCP).

### Metadata
- **Docker Image**: biocontainers/fitgcp:v0.0.20150429-2-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fitgcp/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: 
fitgcp [options] NAME

Help on python script fitGCP.py

Fits mixtures of probability distributions to genome coverage profiles using an
EM-like iterative algorithm.

The script uses a SAM file as input and parses the mapping information and 
creates a Genome Coverage Profile (GCP). The GCP is written to a file, such that
this step can be skipped the next time.
The user provides a mixture model that is fitted to the GCP. Furthermore, the 
user may specify initial parameters for each model. 

As output, the script generates a text file containing the final set of fit 
parameters and additional information about the fitting process. A log file
contains the the current set of parameters in each step of the iteration. If 
requested, a plot of the GCP and the fitted distributions can be created.

PARAMETER:

NAME: Name of SAM file to analyze.


Options:
  -h, --help            show this help message and exit
  -d DIST, --distributions=DIST
                        Distributions to fit. z->zero; n: nbinom (MOM); N:
                        nbinom (MLE); p:binom; t: tail. Default: zn
  -i STEPS, --iterations=STEPS
                        Maximum number of iterations. Default: 50
  -t THR, --threshold=THR
                        Set the convergence threshold for the iteration. Stop
                        if the change between two iterations is less than THR.
                        Default: 0.01
  -c CUTOFF, --cutoff=CUTOFF
                        Specifies a coverage cutoff quantile such that only
                        coverage values below this quantile are considered.
                        Default: 0.95
  -p, --plot            Create a plot of the fitted mixture model. Default:
                        False
  -m MEAN, --means=MEAN
                        Specifies the initial values for the mean of each
                        Poisson or Negative Binomial distribution. Usage: -m
                        12.4 -m 16.1 will specify the means for the first two
                        non-zero/tail distributions. The default is calculated
                        from the data.
  -a ALPHA, --alpha=ALPHA
                        Specifies the initial values for the proportion alpha
                        of each distribution. Usage: For three distributions
                        -a 0.3 -a 0.3 specifies the proportions 0.3, 0.3 and
                        0.4. The default is equal proportions for all
                        distributions.
  -l, --log             Enable logging. Default: False
  --view                Only view the GCP. Do not fit any distribution.
                        Respects cutoff (-c). Default: False
```


## Metadata
- **Skill**: generated
