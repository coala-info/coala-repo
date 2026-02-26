# pynteny CWL Generation Report

## pynteny_search

### Tool Description
Query sequence database for HMM hits arranged in provided synteny structure.

### Metadata
- **Docker Image**: quay.io/biocontainers/pynteny:1.0.0--py310hec16e2b_0
- **Homepage**: http://github.com/robaina/Pynteny
- **Package**: https://anaconda.org/channels/bioconda/packages/pynteny/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pynteny/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/robaina/Pynteny
- **Stars**: N/A
### Original Help Text
```text
____              __
   / __ \__  ______  / /____  ____  __  __
  / /_/ / / / / __ \/ __/ _ \/ __ \/ / / /
 / ____/ /_/ / / / / /_/  __/ / / / /_/ /
/_/    \__, /_/ /_/\__/\___/_/ /_/\__, /
      /____/                     /____/

Synteny-based Hmmer searches made easy, v1.0.0
Semidán Robaina Estévez (srobaina@ull.edu.es), 2022
 

usage: pynteny search [-h] [args] 

Query sequence database for HMM hits arranged in provided synteny structure.

required arguments:
  -s , --synteny_struc 
                        string displaying hmm structure to search for, such as: 
                         
                        '>hmm_a n_ab <hmm_b n_bc hmm_c'
                         
                        where '>' indicates a hmm target located on the positive strand, 
                        '<' a target located on the negative strand, and n_ab cooresponds 
                        to the maximum number of genes separating matched genes a and b. 
                        Multiple hmms may be employed. 
                        No order symbol in a hmm indicates that results should be independent 
                        of strand location. 
  -i , --data           path to fasta file containing peptide database. 
                        Record labels must follow the format specified in docs 
                        (see section: General Usage). Pynteny build subcommand exports 
                        the generated database in the correct format

options:
  -h, --help            show this help message and exit
  -d , --hmm_dir        path to directory containing hmm (i.e, tigrfam or pfam) models. 
                        IMPORTANT: the directory must contain one hmm per file, and the file 
                        name must coincide with the hmm name that will be displayed in the synteny structure. 
                        The directory can contain more hmm models than used in the synteny structure. 
                        It may also be the path to a compressed (tar, tar.gz, tgz) directory. 
                        If not provided, hmm models (PGAP database) will be downloaded from the NCBI. 
                        (if not already downloaded)
  -o , --outdir         path to output directory
  -x , --prefix         prefix to be added to output files
  -p , --processes      maximum number of processes available to HMMER. Defaults to all but one.
  -a , --hmmsearch_args 
                        list of comma-separated additional arguments to hmmsearch for each input hmm. 
                        A single argument may be provided, in which case the same additional argument 
                        is employed in all hmms.
  -g, --gene_ids        use gene symbols in synteny structure instead of HMM names. 
                        If set, a path to the hmm database metadata file must be provided 
                        in argument '--hmm_meta'
  -u, --unordered       whether the HMMs should be arranged in the exact same order displayed 
                        in the synteny_structure or in  any order. If ordered, the filters will 
                        filter collinear rather than syntenic structures. 
                        If more than two HMMs are employed, the largest maximum distance among any 
                        pair is considered to run the search.
  -r, --reuse           reuse hmmsearch result table in following synteny searches. 
                        Do not delete hmmer_outputs subdirectory for this option to work.
  -m , --hmm_meta       path to hmm database metadata file
  -l , --log            path to log file. Log not written by default.
```


## pynteny_build

### Tool Description
Translate nucleotide assembly file and assign contig and gene location info to each identified ORF (using prodigal). Label predicted ORFs according to positional info and export a fasta file containing predicted and translated ORFs. Alternatively, extract peptide sequences from GenBank file containing ORF annotations and write labelled peptide sequences to a fasta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pynteny:1.0.0--py310hec16e2b_0
- **Homepage**: http://github.com/robaina/Pynteny
- **Package**: https://anaconda.org/channels/bioconda/packages/pynteny/overview
- **Validation**: PASS

### Original Help Text
```text
____              __
   / __ \__  ______  / /____  ____  __  __
  / /_/ / / / / __ \/ __/ _ \/ __ \/ / / /
 / ____/ /_/ / / / / /_/  __/ / / / /_/ /
/_/    \__, /_/ /_/\__/\___/_/ /_/\__, /
      /____/                     /____/

Synteny-based Hmmer searches made easy, v1.0.0
Semidán Robaina Estévez (srobaina@ull.edu.es), 2022
 

usage: pynteny build [-h] [args] 

Translate nucleotide assembly file and assign contig and gene location info 
to each identified ORF (using prodigal). Label predicted ORFs according to 
positional info and export a fasta file containing predicted and translated ORFs. 
Alternatively, extract peptide sequences from GenBank file containing ORF annotations 
and write labelled peptide sequences to a fasta file.

required arguments:
  -i , --data           path to assembly input nucleotide data or annotated GenBank file. 
                        It can be a single file or a directory of files (either of FASTA or GeneBank format). 
                        If a directory, file name can be prepended to the label of each translated peptide 
                        originally coming from that file by default (i.e., to track the genome of origin) 
                        with the flag '--prepend-filename.'

options:
  -h, --help            show this help message and exit
  -p, --prepend-filename
                        whether to prepend file name to peptide sequences when a directory 
                        with multiple fasta or genbank files is used as input.
  -o , --outfile        path to output (labelled peptide database) file. Defaults to 
                        file in directory of input data.
  -n , --processes      set maximum number of processes. Defaults to all but one.
  -l , --log            path to log file. Log not written by default.
```


## pynteny_parse

### Tool Description
Translate synteny structure with gene symbols into one with
HMM groups, according to provided HMM database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pynteny:1.0.0--py310hec16e2b_0
- **Homepage**: http://github.com/robaina/Pynteny
- **Package**: https://anaconda.org/channels/bioconda/packages/pynteny/overview
- **Validation**: PASS

### Original Help Text
```text
____              __
   / __ \__  ______  / /____  ____  __  __
  / /_/ / / / / __ \/ __/ _ \/ __ \/ / / /
 / ____/ /_/ / / / / /_/  __/ / / / /_/ /
/_/    \__, /_/ /_/\__/\___/_/ /_/\__, /
      /____/                     /____/

Synteny-based Hmmer searches made easy, v1.0.0
Semidán Robaina Estévez (srobaina@ull.edu.es), 2022
 

usage: pynteny parse [-h] [args] 

Translate synteny structure with gene symbols into one with
HMM groups, according to provided HMM database.

required arguments:
  -s , --synteny_struc 
                        synteny structure containing gene symbols instead of HMMs

options:
  -h, --help            show this help message and exit
  -m , --hmm_meta       path to hmm database metadata file. If already donwloaded with 
                        pynteny downloaded, hmm meta file is retrieved from default location.
  -l , --log            path to log file. Log not written by default.
```


## pynteny_download

### Tool Description
Download HMM database from NCBI.

### Metadata
- **Docker Image**: quay.io/biocontainers/pynteny:1.0.0--py310hec16e2b_0
- **Homepage**: http://github.com/robaina/Pynteny
- **Package**: https://anaconda.org/channels/bioconda/packages/pynteny/overview
- **Validation**: PASS

### Original Help Text
```text
____              __
   / __ \__  ______  / /____  ____  __  __
  / /_/ / / / / __ \/ __/ _ \/ __ \/ / / /
 / ____/ /_/ / / / / /_/  __/ / / / /_/ /
/_/    \__, /_/ /_/\__/\___/_/ /_/\__, /
      /____/                     /____/

Synteny-based Hmmer searches made easy, v1.0.0
Semidán Robaina Estévez (srobaina@ull.edu.es), 2022
 

usage: pynteny download [-h] [args] 

Download HMM database from NCBI.

required arguments:
  -o , --outdir   path to directory where to download HMM database. 
                  Note, if database is relocated after download, Pynteny won't be able to find it automatically, 
                  You can either: delete and download again in the new location or manually indicate database and 
                  meta file location in Pynteny search.

options:
  -h, --help      show this help message and exit
  -u, --unpack    unpack originally compressed database files
  -f, --force     force-download database again if already downloaded
  -l , --log      path to log file. Log not written by default.
```


## pynteny_cite

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pynteny:1.0.0--py310hec16e2b_0
- **Homepage**: http://github.com/robaina/Pynteny
- **Package**: https://anaconda.org/channels/bioconda/packages/pynteny/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
____              __
   / __ \__  ______  / /____  ____  __  __
  / /_/ / / / / __ \/ __/ _ \/ __ \/ / / /
 / ____/ /_/ / / / / /_/  __/ / / / /_/ /
/_/    \__, /_/ /_/\__/\___/_/ /_/\__, /
      /____/                     /____/

Synteny-based Hmmer searches made easy, v1.0.0
Semidán Robaina Estévez (srobaina@ull.edu.es), 2022
 

If you use this software, please cite it as below: 
Semidán Robaina Estévez (2022). Pynteny: synteny-aware hmm searches made easy(Version 1.0.0). Zenodo. https://doi.org/10.5281/zenodo.7048685
```

