[View on GitHub](https://github.com/sanger-pathogens/circlator)

# Circlator

## A tool to circularize genome assemblies

# Circlator

A tool to circularize genome assemblies. The algorithm and benchmarks are described in the
[Genome Biology manuscript](http://www.genomebiology.com/2015/16/1/294).
Citation: "Circlator: automated circularization of genome assemblies using long sequencing reads", Hunt et al,
Genome Biology 2015 Dec 29;16(1):294. doi: 10.1186/s13059-015-0849-0.
PMID: [26714481](http://www.ncbi.nlm.nih.gov/pubmed/?term=26714481).

For how to use Circlator, please see the [Circlator wiki page](https://github.com/sanger-pathogens/circlator/wiki).

## Installation

### Using pip or from source

Circlator has the following dependencies, which need to be installed first (you will need SPAdes or Canu:

* [BWA](http://bio-bwa.sourceforge.net/) version >= 0.7.12
* [prodigal](http://prodigal.ornl.gov/) version >= 2.6
* [SAMtools](http://www.htslib.org/) (versions 0.1.9 to 1.3)
* [MUMmer](http://mummer.sourceforge.net/) version >= 3.23
* [Canu](https://github.com/marbl/canu) and/or [SPAdes](http://bioinf.spbau.ru/spades).
  SPAdes version 3.6.2 or higher is required, but
  3.7.1 is recommended (marginally gave the best results on NCTC data from the Circlator
  publication, tested on all SPAdes versions 3.6.2-3.9.0).

Note that you can use the environment variable $CIRCLATOR\_SPADES to specify the name of the SPAdes exectuable.
If this environment variable is set, then it is used by Circlator. Otherwise, Circlator will look for spades.py in your $PATH.

Once the dependencies are installed, install Circlator using pip3:

```
pip3 install circlator
```

Alternatively, you can download the
[latest release](https://github.com/sanger-pathogens/circlator/releases/latest)
from the github repository,
or clone the repository. Then run the tests:

```
python3 setup.py test
```

If the tests all pass, install:

```
python3 setup.py install
```

### Using Docker

Circlator can be run in a Docker container. First install Docker, then install circlator:

```
docker pull sangerpathogens/circlator
```

To use it you would use a command such as this (substituting in your directories), where your files are assumed to be stored in /home/ubuntu/data:

```
docker run --rm -it -v /home/ubuntu/data:/data sangerpathogens/circlator circlator all /data/assembly.fasta /data/reads /data/output_directory
```

### Verify the dependencies are installed

Check that Circlator can find the dependencies, and that the versions are high enough, by running

```
circlator progcheck
```

See the help for [progcheck](https://github.com/sanger-pathogens/circlator/wiki/Task%3A-progcheck) for more details.

## Usage

Please read the [Circlator wiki page](https://github.com/sanger-pathogens/circlator/wiki) for usage instructions.

## References

[BWA](http://arxiv.org/abs/1303.3997): Li, H et al. Aligning sequence reads, clone sequences and assembly contigs with BWA-MEM. arXiv:1303.3997.

[MUMmer](http://genomebiology.com/content/5/2/R12): Kurtz, S. et al. Versatile and open software for comparing large genomes. Genome Biol. 5, R12 (2004).

[Prodigal](http://www.biomedcentral.com/1471-2105/11/119): Hyatt, D. et al. Prodigal: prokaryotic gene recognition and translation initiation site identification. BMC Bioinformatics 11, 119 (2010).

[SAMtools](http://bioinformatics.oxfordjournals.org/content/25/16/2078.abstract): Li, H. et al. The Sequence Alignment/Map format and SAMtools. Bioinformatics 25, 2078–9 (2009).

[SPAdes](http://online.liebertpub.com/doi/abs/10.1089/cmb.2012.0021): Bankevich, A. et al. SPAdes: a new genome assembly algorithm and its applications to single-cell sequencing. J. Comput. Biol. 19, 455–77 (2012).

Circlator maintained by [sanger-pathogens](https://github.com/sanger-pathogens)

Published with [GitHub Pages](https://pages.github.com)