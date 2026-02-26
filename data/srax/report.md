# srax CWL Generation Report

## srax_sraX

### Tool Description
sraX is designed to read assembled sequence files in FASTA format and systematically detect the presence of antimicrobial resistance genes (ARGs). The complete resistome analysis is effectively accomplished by running a single command. Under default parameters, only a mandatory folder enclosing the selected genome FASTA files is required. In addition, the following default data repositories & software dependences are preferred: CARD database (ARG repository), DIAMOND (sequence aligner), MUSCLE (multiple-sequence aligner, required for SNP detection) and R environment (visualization plots).

### Metadata
- **Docker Image**: quay.io/biocontainers/srax:1.5--pl5321h05cac1d_4
- **Homepage**: https://github.com/lgpdevtools/sraX
- **Package**: https://anaconda.org/channels/bioconda/packages/srax/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/srax/overview
- **Total Downloads**: 6.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lgpdevtools/sraX
- **Stars**: N/A
### Original Help Text
```text
For running 'sraX', it's mandatory to provide, at least, a directory containing the genome(s) that you want to analyze.
sraX execution is stopped and the resistome analysis is aborted now.

  sraX v1.5 | by Leonardo G. Panunzi <lgpanunzi@gmail.com>
  Licensed under the GNU GPL <https://www.gnu.org/licenses/gpl.txt>
  http://github.com/lgpdevtools/srax

  USAGE:

  sraX -i [input folder_name (with genome file(s))] [options]  

  SYNOPSIS:

  sraX is designed to read assembled sequence files in FASTA format and systematically detect the
  presence of antimicrobial resistance genes (ARGs). The complete resistome analysis is effectively
  accomplished by running a single command. Under default parameters, only a mandatory folder
  enclosing the selected genome FASTA files is required. In addition, the following default data
  repositories & software dependences are preferred: CARD database (ARG repository), DIAMOND
  (sequence aligner), MUSCLE (multiple-sequence aligner, required for SNP detection) and R
  environment (visualization plots).

  sraX operates in four main stages:

  I) Sequence data acquisition: The CARD database is downloaded, while its metadata is further
  parsed for compiling a local antimicrobial resistance database (AMR DB).

  II) Sequence homology search: dblastx (DIAMOND blastx) or blastx (NCBI blastx) algorithms are
  employed for querying the genomes against the previously compiled AMR DB.

  III) SNP analysis: Reference (from AMR DB) and corresponding homolog (from assembled genomes)
  sequences are gathered into multiple-sequence alignments (MSA) for identifying the SNP positions.     

  IV) Output summary files and visualization: The R software is employed for producing specific
  plots that complement the resulting summary tables, which on the whole are visualized in HTML format
  files.

  --------------------
  - Running commands -
  --------------------

  Mandatory:
  ----------

  -i|input	Input directory [/path/to/input_dir] containing the input file(s), which
		must be in FASTA format and consisting of individual assembled genome sequences.

  Optional:
  ---------

  -o|output	Directory to store obtained results [/path/to/output_dir]. While not
		provided, the following default name will be taken:

		'input_directory'_'sraX'_'id'_'aln_cov'_'seqal'

		Example:
		--------
			Input directory: 'Test'
			Options: -id 85; -c 95; -p dblastx
			Output directory: 'Test_sraX_85_95_dblastx'

  -s|seqal	The preferred algorithm for aligning the assembled genome(s) to a locally
		compiled AMR DB. The possible choices are: 'dblastx' (DIAMOND blastx) or 'blastx'
		(NCBI blastx). In any case, the process is parallelized (up to 100 genome files are
		run simultaneously) for reducing computing times. [string] Default: dblastx

  -a|msa	The preferred algorithm for producing the alignment of clustered homologous
		sequences (multiple-sequence files). The possible choices are: 'muscle', 'clustalo'
		or 'mafft'. [string] Default: muscle
		Note: The accuracy and computing times are both dependent on the selected algorithm.

  -e|eval	Minimum evalue cut-off to filter false positives. [number] Default: 1e-05

  -id		Minimum identity cut-off to filter false positives. [number] Default: 85

  -c|aln_cov	Minimum length of the query which must align to the reference sequence.
		[number] Default: 60

  -db|dbsearch	The level of the ARG search, on account of the number and type of employed AMR DB.
		The possible choices are: 'basic' or 'ext'. The 'basic' option only applies 'CARD',
		while the 'ext' option utilizes as well the 'ARGminer' (compilation of multiple AMR
		DBs) and 'BACMET' (biocides and metal resistance) repositories. [string] Default:
		basic

		Note: In operational terms, the extensive search ('ext' option) takes much longer
		computing times. 

  -u|user_sq    Customary AMR DB provided by the user. The sequences must be in FASTA format.

  -t|threads	Number of threads when running sraX. [number] Default: 6

  -h|help	Displays this help information and exits.

  -v|version	Displays version information and exits.

  -d|debug	Verbose output (for debugging).



					'sraX' was last modified: 05th February 2020
```

