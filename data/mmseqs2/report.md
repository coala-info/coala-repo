# mmseqs2 CWL Generation Report

## mmseqs2_mmseqs

### Tool Description
MMseqs2 (Many against Many sequence searching) is an open-source software suite for very fast, parallelized protein sequence searches and clustering of huge protein sequence data sets.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
- **Homepage**: https://github.com/soedinglab/mmseqs2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mmseqs2/overview
- **Total Downloads**: 471.8K
- **Last updated**: 2025-07-27
- **GitHub**: https://github.com/soedinglab/mmseqs2
- **Stars**: N/A
### Original Help Text
```text
MMseqs2 (Many against Many sequence searching) is an open-source software suite for very fast, 
parallelized protein sequence searches and clustering of huge protein sequence data sets.

Please cite: M. Steinegger and J. Soding. MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, doi:10.1038/nbt.3988 (2017).

MMseqs2 Version: 18.8cc5c
© Martin Steinegger (martin.steinegger@snu.ac.kr)

usage: mmseqs <command> [<args>]

Easy workflows for plain text input/output
  easy-search       	Sensitive homology search
  easy-linsearch    	Fast, less sensitive homology search
  easy-cluster      	Slower, sensitive clustering
  easy-linclust     	Fast linear time cluster, less sensitive clustering
  easy-taxonomy     	Taxonomic classification
  easy-rbh          	Find reciprocal best hit

Main workflows for database input/output
  search            	Sensitive homology search
  linsearch         	Fast, less sensitive homology search
  map               	Map nearly identical sequences
  rbh               	Reciprocal best hit search
  linclust          	Fast, less sensitive clustering
  cluster           	Slower, sensitive clustering
  clusterupdate     	Update previous clustering with new sequences
  taxonomy          	Taxonomic classification

Input database creation
  databases         	List and download databases
  createdb          	Convert FASTA/Q file(s) to a sequence DB
  createindex       	Store precomputed index on disk to reduce search overhead
  createlinindex    	Create linsearch index
  convertmsa        	Convert Stockholm/PFAM MSA file to a MSA DB
  tsv2db            	Convert a TSV file to any DB
  tar2db            	Convert content of tar archives to any DB
  db2tar            	Archive contents of a DB to a tar archive
  msa2profile       	Convert a MSA DB to a profile DB

Handle databases on storage and memory
  compress          	Compress DB entries
  decompress        	Decompress DB entries
  rmdb              	Remove a DB
  mvdb              	Move a DB
  cpdb              	Copy a DB
  lndb              	Symlink a DB
  aliasdb           	Create relative symlink of DB to another name in the same folder
  unpackdb          	Unpack a DB into separate files
  touchdb           	Preload DB into memory (page cache)
  gpuserver         	Start a GPU server

Unite and intersect databases
  createsubdb       	Create a subset of a DB from list of DB keys
  concatdbs         	Concatenate two DBs, giving new IDs to entries from 2nd DB
  splitdb           	Split DB into subsets
  mergedbs          	Merge entries from multiple DBs
  subtractdbs       	Remove all entries from first DB occurring in second DB by key

Format conversion for downstream processing
  convertalis       	Convert alignment DB to BLAST-tab, SAM or custom format
  createtsv         	Convert result DB to tab-separated flat file
  convert2fasta     	Convert sequence DB to FASTA format
  result2flat       	Create flat file by adding FASTA headers to DB entries
  createseqfiledb   	Create a DB of unaligned FASTA entries
  taxonomyreport    	Create a taxonomy report in Kraken or Krona format

Sequence manipulation/transformation
  extractorfs       	Six-frame extraction of open reading frames
  extractframes     	Extract frames from a nucleotide sequence DB
  orftocontig       	Write ORF locations in alignment format
  reverseseq        	Reverse (without complement) sequences
  translatenucs     	Translate nucleotides to proteins
  translateaa       	Translate proteins to lexicographically lowest codons
  splitsequence     	Split sequences by length
  masksequence      	Soft mask sequence DB using tantan
  extractalignedregion	Extract aligned sequence region from query

Result manipulation 
  swapresults       	Transpose prefilter/alignment DB
  result2rbh        	Filter a merged result DB to retain only reciprocal best hits
  result2msa        	Compute MSA DB from a result DB
  result2dnamsa     	Compute MSA DB with out insertions in the query for DNA sequences
  result2stats      	Compute statistics for each entry in a DB
  filterresult      	Pairwise alignment result filter
  offsetalignment   	Offset alignment by ORF start position
  proteinaln2nucl   	Transform protein alignments to nucleotide alignments
  result2repseq     	Get representative sequences from result DB
  sortresult        	Sort a result DB in the same order as the prefilter or align module
  summarizealis     	Summarize alignment result to one row (uniq. cov., cov., avg. seq. id.)
  summarizeresult   	Extract annotations from alignment DB

Taxonomy assignment 
  createtaxdb       	Add taxonomic labels to sequence DB
  createbintaxonomy 	Create binary taxonomy from NCBI input
  createdmptaxonomy 	Create dmp files from binary taxonomy
  createbintaxmapping	Create binary taxonomy mapping from tabular taxonomy mapping
  addtaxonomy       	Add taxonomic labels to result DB
  taxonomyreport    	Create a taxonomy report in Kraken or Krona format
  filtertaxdb       	Filter taxonomy result database
  filtertaxseqdb    	Filter taxonomy sequence database
  aggregatetax      	Aggregate multiple taxon labels to a single label
  aggregatetaxweights	Aggregate multiple taxon labels to a single label
  lcaalign          	Efficient gapped alignment for lca computation
  lca               	Compute the lowest common ancestor
  majoritylca       	Compute the lowest common ancestor using majority voting

Multi-hit search    
  multihitdb        	Create sequence DB for multi hit searches
  multihitsearch    	Search with a grouped set of sequences against another grouped set
  besthitperset     	For each set of sequences compute the best element and update p-value
  combinepvalperset 	For each set compute the combined p-value
  mergeresultsbyset 	Merge results from multiple ORFs back to their respective contig

Prefiltering        
  prefilter         	Double consecutive diagonal k-mer search
  ungappedprefilter 	Optimal diagonal score search
  gappedprefilter   	Optimal Smith-Waterman-based prefiltering (slow)
  kmermatcher       	Find bottom-m-hashed k-mer matches within sequence DB
  kmersearch        	Find bottom-m-hashed k-mer matches between target and query DB

Alignment           
  align             	Optimal gapped local alignment
  alignall          	Within-result all-vs-all gapped local alignment
  transitivealign   	Transfer alignments via transitivity
  rescorediagonal   	Compute sequence identity for diagonal
  fwbw              	Forward Backward Alignment
  alignbykmer       	Heuristic gapped local k-mer based alignment

Clustering          
  pickconsensusrep  	Select new representatives for each cluster based on consensus
  clust             	Cluster result by Set-Cover/Connected-Component/Greedy-Incremental
  clusthash         	Hash-based clustering of equal length sequences
  mergeclusters     	Merge multiple cascaded clustering steps

Profile databases   
  result2profile    	Compute profile DB from a result DB
  msa2result        	Convert a MSA DB to a profile DB
  msa2profile       	Convert a MSA DB to a profile DB
  sequence2profile  	Turn sequence into profile by adding context specific pseudo counts
  profile2pssm      	Convert a profile DB to a tab-separated PSSM file
  profile2neff      	Convert a profile DB to a tab-separated list of Neff scores
  profile2consensus 	Extract consensus sequence DB from a profile DB
  profile2repseq    	Extract representative sequence DB from a profile DB
  convertprofiledb  	Convert a HH-suite HHM DB to a profile DB

Profile-profile databases
  tsv2exprofiledb   	Create a expandable profile db from TSV files
  convertca3m       	Convert a cA3M DB to a result DB
  expandaln         	Expand an alignment result based on another
  expand2profile    	Expand an alignment result based on another and create a profile

Utility modules to manipulate DBs
  setextendeddbtype 	Write an extended DB 
  view              	Print DB entries given in --id-list to stdout
  apply             	Execute given program on each DB entry
  filterdb          	DB filtering by given conditions
  swapdb            	Transpose DB with integer values in first column
  prefixid          	For each entry in a DB prepend the entry key to the entry itself
  suffixid          	For each entry in a DB append the entry key to the entry itself
  renamedbkeys      	Create a new DB with original keys renamed

Special-purpose utilities
  diffseqdbs        	Compute diff of two sequence DBs
  summarizetabs     	Extract annotations from HHblits BLAST-tab-formatted results
  gff2db            	Extract regions from a sequence database based on a GFF3 file
  maskbygff         	Mask out sequence regions in a sequence DB by features selected from a GFF3 file
  convertkb         	Convert UniProtKB data to a DB
  summarizeheaders  	Summarize FASTA headers of result DB
  nrtotaxmapping    	Create taxonomy mapping for NR database
  extractdomains    	Extract highest scoring alignment regions for each sequence from BLAST-tab file
  countkmer         	Count k-mers

Bash completion for modules and parameters can be installed by adding "source MMSEQS_HOME/util/bash-completion.sh" to your "$HOME/.bash_profile".
Include the location of the MMseqs2 binary in your "$PATH" environment variable.

Invalid Command: -help
Did you mean "mmseqs createlinindex"?
```

