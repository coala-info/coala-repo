# akt CWL Generation Report

## akt_pca

### Tool Description
Performs principal component analysis on a vcf/bcf

### Metadata
- **Docker Image**: quay.io/biocontainers/akt:0.3.3--h5ca1c30_7
- **Homepage**: https://github.com/Illumina/akt
- **Package**: https://anaconda.org/channels/bioconda/packages/akt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/akt/overview
- **Total Downloads**: 20.0K
- **Last updated**: 2025-10-08
- **GitHub**: https://github.com/Illumina/akt
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Performs principal component analysis on a vcf/bcf
Usage:
./akt pca input.bcf

Output options:
	 -o --output:			output vcf
	 -O --outputfmt:		output vcf format

Site filtering options:
	 -R --regions-file:		restrict to regions listed in a file
	 -r --regions:			chromosome region
	 -T --targets-file:		similar to -R but streams rather than index-jumps
	 -t --targets:		        similar to -r but streams rather than index-jumps
	    --force:			run pca without -R/-T/-F

Sample filtering options:
	 -S --samples-file:		list of samples, file
	 -s --samples:			list of samples

PCA options:
	 -W --weight:			VCF with weights for PCA
	 -N --npca:			first N principle components
	 -a --alg:			exact SVD (slow)
	 -C --covdef:			definition of SVD matrix: 0=(G-mu) 1=(G-mu)/sqrt(p(1-p)) 2=diag-G(2-G) default(1)
	 -e --extra:			extra vectors for Red SVD
	 -q --iterations                number of power iterations (default 10 is sufficient)
	 -F --svfile:			File containing singular values
	 -H --assume-homref:            Assume missing genotypes/sites are homozygous reference (useful for projecting a single sample)
```


## akt_kin

### Tool Description
Calculate kinship/IBD statistics from a multisample BCF/VCF

### Metadata
- **Docker Image**: quay.io/biocontainers/akt:0.3.3--h5ca1c30_7
- **Homepage**: https://github.com/Illumina/akt
- **Package**: https://anaconda.org/channels/bioconda/packages/akt/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
/usr/local/bin/akt: option requires an argument -- 'h'

About: Calculate kinship/IBD statistics from a multisample BCF/VCF
Usage: akt kin [options] <in.bcf>
Expects input.bcf to contain genotypes.

Kinship calculation options:
	 -k --minkin:			threshold for relatedness output (none)
	 -F --freq-file:                a file containing population allele frequencies to use in kinship calculation
	 -M --method:			type of estimator. 0:plink (default) 1:king-robust 2:genetic-relationship-matrix
	 -a --aftag:			allele frequency tag (default AF)
	 -@ --threads: 		        num threads

Site filtering options:
	 -R --regions-file:		restrict to regions listed in a file
	 -r --regions:			chromosome region
	 -T --targets-file:		similar to -R but streams rather than index-jumps
	 -t --targets:		        similar to -r but streams rather than index-jumps
	    --force:			run kin without -R/-T/-F

Sample filtering options:
	 -s --samples:			list of samples
	 -S --samples-file:		list of samples, file
```


## akt_relatives

### Tool Description
Derive a set of pedigrees from the akt kin output.

### Metadata
- **Docker Image**: quay.io/biocontainers/akt:0.3.3--h5ca1c30_7
- **Homepage**: https://github.com/Illumina/akt
- **Package**: https://anaconda.org/channels/bioconda/packages/akt/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Derive a set of pedigrees from the akt kin output.
Usage:
./akt unrelated ibdfile
	 -k --kmin:			threshold for relatedness (0.05)
	 -i --its:			number of iterations to find unrelated (10)
	 -g --graphout:		if present output pedigree graph files
	 -p --prefix:			output file prefix (out)
arrow types     : solid black	= parent-child
                : dotted black	= siblings
                : blue 		= second order
                : red		= duplicates
                : directed	= from parent to child
```


## akt_unrelated

### Tool Description
Print a list of unrelated individuals taking the output from akt kin as input.

### Metadata
- **Docker Image**: quay.io/biocontainers/akt:0.3.3--h5ca1c30_7
- **Homepage**: https://github.com/Illumina/akt
- **Package**: https://anaconda.org/channels/bioconda/packages/akt/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Print a list of unrelated individuals taking the output from akt kin as input.
Usage:
./akt unrelated ibdfile
	 -k --kmin:			threshold for relatedness (0.025)
	 -i --its:			number of iterations to find unrelated (10)
```


## akt_pedphase

### Tool Description
simple Mendel inheritance phasing of duos/trios

### Metadata
- **Docker Image**: quay.io/biocontainers/akt:0.3.3--h5ca1c30_7
- **Homepage**: https://github.com/Illumina/akt
- **Package**: https://anaconda.org/channels/bioconda/packages/akt/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

About:   akt pedphase - simple Mendel inheritance phasing of duos/trios
Usage:   ./akt pedphase input.vcf.gz -p pedigree.fam

Options:
    -p, --pedigree                 pedigree information in plink .fam format
    -o, --output-file <file>       output file name [stdout]
    -O, --output-type <b|u|z|v>    b: compressed BCF, u: uncompressed BCF, z: compressed VCF, v: uncompressed VCF [v]
    -@, --threads                  number of compression/decompression threads to use
    -x, --exclude-chromosome       leave these chromosomes unphased (unphased lines will still be in in output)  eg. -x chrM,chrY
```


## Metadata
- **Skill**: generated
