# diamond CWL Generation Report

## diamond_makedb

### Tool Description
Build a DIAMOND database from a FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Total Downloads**: 1.9M
- **Last updated**: 2026-03-07
- **GitHub**: https://github.com/bbuchfink/diamond
- **Stars**: N/A
### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--in                     input reference file in FASTA format/input DAA files for merge-daa
--taxonmap               protein accession to taxid mapping file
--taxonnodes             taxonomy nodes.dmp from NCBI
--taxonnames             taxonomy names.dmp from NCBI
--file-buffer-size       file buffer size in bytes (default=67108864)
--no-unlink              Do not unlink temporary files.
--ignore-warnings        Ignore warnings
--no-parse-seqids        Print raw seqids without parsing

diamond v2.1.24.178 (C) Max Planck Society for the Advancement of Science, Benjamin J. Buchfink, University of Tuebingen
Documentation, support and updates available at http://www.diamondsearch.org
Please cite: http://dx.doi.org/10.1038/s41592-021-01101-x Nature Methods (2021)

Error: Missing parameter: database file (--db/-d)
```


## diamond_blastp

### Tool Description
DIAMOND is a sequence aligner for protein and translated DNA searches, designed for high performance analysis of big sequence data.

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--out                    output file
--header                 Use header lines in tabular output format (0/simple/verbose).
--comp-based-stats       composition based statistics mode (0-4)
--masking                masking algorithm (none, seg, tantan=default)
--soft-masking           soft masking (none=default, seg, tantan)
--gapopen                gap open penalty
--gapextend              gap extension penalty
--matrix                 score matrix for protein alignment (default=BLOSUM62)
--custom-matrix          file containing custom scoring matrix
--evalue                 maximum e-value to report alignments (default=0.001)
--motif-masking          softmask abundant motifs (0/1)
--approx-id              minimum approx. identity% to report an alignment/to cluster sequences
--ext                    Extension mode (banded-fast/banded-slow/full)
--max-target-seqs        maximum number of target sequences to report alignments for (default=25)
--top                    report alignments within this percentage range of top alignment score (overrides --max-target-seqs)
--faster                 enable faster mode
--fast                   enable fast mode
--mid-sensitive          enable mid-sensitive mode
--linclust-20            enable mode for linear search at 20% identity
--shapes-6x10            enable mode using 30 seed shapes of weight 10
--shapes-30x10           enable mode using 30 seed shapes of weight 10
--sensitive              enable sensitive mode)
--more-sensitive         enable more sensitive mode
--very-sensitive         enable very sensitive mode
--ultra-sensitive        enable ultra sensitive mode
--shapes                 number of seed shapes (default=all available)
--query                  input query file
--strand                 query strands to search (both/minus/plus)
--un                     file for unaligned queries
--al                     file or aligned queries
--unfmt                  format of unaligned query file (fasta/fastq)
--alfmt                  format of aligned query file (fasta/fastq)
--unal                   report unaligned queries (0=no, 1=yes)
--max-hsps               maximum number of HSPs per target sequence to report for each query (default=1)
--range-culling          restrict hit culling to overlapping query ranges
--compress               compression for output files (0=none, 1=gzip, zstd)
--min-score              minimum bit score to report alignments (overrides e-value setting)
--id                     minimum identity% to report an alignment
--query-cover            minimum query cover% to report an alignment
--subject-cover          minimum subject cover% to report an alignment
--swipe                  exhaustive alignment against all database sequences
--iterate                iterated search with increasing sensitivity
--global-ranking         number of targets for global ranking
--block-size             sequence block size in billions of letters (default=2.0)
--index-chunks           number of chunks for index processing (default=4)
--frameshift             frame shift penalty (default=disabled)
--long-reads             short for --range-culling --top 10 -F 15
--query-gencode          genetic code to use to translate query (see user manual)
--salltitles             include full subject titles in DAA file
--sallseqid              include all subject ids in DAA file
--no-self-hits           suppress reporting of identical self hits
--taxonlist              restrict search to list of taxon ids (comma-separated)
--taxon-exclude          exclude list of taxon ids (comma-separated)
--seqidlist              filter the database by list of accessions
--skip-missing-seqids    ignore accessions missing in the database
--outfmt                 output format
	0   = BLAST pairwise
	5   = BLAST XML
	6   = BLAST tabular
	100 = DIAMOND alignment archive (DAA)
	101 = SAM
	102 = Taxonomic classification
	103 = PAF
	104 = JSON (flat)

	Values 6 and 104 may be followed by a space-separated list of these keywords:

	             qseqid means Query Seq - id
	               qlen means Query sequence length
	             sseqid means Subject Seq - id
	          sallseqid means All subject Seq - id(s), separated by a ';'
	               slen means Subject sequence length
	             qstart means Start of alignment in query
	               qend means End of alignment in query
	             sstart means Start of alignment in subject
	               send means End of alignment in subject
	               qseq means Aligned part of query sequence
	               sseq means Aligned part of subject sequence
	             evalue means Expect value
	           bitscore means Bit score
	              score means Raw score
	             length means Alignment length
	             pident means Percentage of identical matches
	             nident means Number of identical matches
	           mismatch means Number of mismatches
	           positive means Number of positive - scoring matches
	            gapopen means Number of gap openings
	               gaps means Total number of gaps
	               ppos means Percentage of positive - scoring matches
	             qframe means Query frame
	               btop means Blast traceback operations (BTOP)
	            staxids means Unique Subject Taxonomy ID(s), separated by a ';' (in numerical order)
	          sscinames means Unique Subject Scientific Name(s), separated by a ';'
	         sskingdoms means Unique Subject Super Kingdom(s), separated by a ';'
	             stitle means Subject Title
	         salltitles means All Subject Title(s), separated by a '<>'
	            qcovhsp means Query coverage per HSP
	             qtitle means Query title
	          full_sseq means Subject sequence
	              qqual means Query quality values for the aligned part of the query
	               qnum means Query ordinal id
	               snum means Subject ordinal id
	            scovhsp means Subject coverage per HSP
	         full_qqual means Query quality values
	          full_qseq means Query sequence
	        qseq_gapped means Aligned part of query sequence (with gaps)
	        sseq_gapped means Aligned part of subject sequence (with gaps)
	            qstrand means Query strand
	              cigar means CIGAR string
	          skingdoms means Unique Subject Kingdom(s), separated by a ';'
	           sphylums means Unique Subject Phylum(s), separated by a ';'
	     full_qseq_mate means Query sequence of the mate
	    qseq_translated means Aligned part of query sequence (translated)
	             hspnum means Number of HSP within the subject
	normalized_bitscore means Bitscore normalized by maximum self alignment score
	  normalized_nident means Number of identical matches normalized by maximum length
	      approx_pident means Approximate percentage of identical matches
	 corrected_bitscore means Bit score corrected for edge effects
	          slineages means Unique Subject Lineage(s), separated by a '<>'
	      ssuperkingdom means Unique subject superkingdom(s), separated by a ';'
	     scellular_root means Unique subject cellular root(s), separated by a ';'
	    sacellular_root means Unique subject acellular root(s), separated by a ';'
	            sdomain means Unique subject domain(s), separated by a ';'
	             srealm means Unique subject realm(s), separated by a ';'
	           skingdom means Unique subject kingdom(s), separated by a ';'
	        ssubkingdom means Unique subject subkingdom(s), separated by a ';'
	       ssuperphylum means Unique subject superphylum(s), separated by a ';'
	            sphylum means Unique subject phylum(s), separated by a ';'
	         ssubphylum means Unique subject subphylum(s), separated by a ';'
	        ssuperclass means Unique subject superclass(s), separated by a ';'
	             sclass means Unique subject class(s), separated by a ';'
	          ssubclass means Unique subject subclass(s), separated by a ';'
	        sinfraclass means Unique subject infraclass(s), separated by a ';'
	            scohort means Unique subject cohort(s), separated by a ';'
	         ssubcohort means Unique subject subcohort(s), separated by a ';'
	        ssuperorder means Unique subject superorder(s), separated by a ';'
	             sorder means Unique subject order(s), separated by a ';'
	          ssuborder means Unique subject suborder(s), separated by a ';'
	        sinfraorder means Unique subject infraorder(s), separated by a ';'
	         sparvorder means Unique subject parvorder(s), separated by a ';'
	       ssuperfamily means Unique subject superfamily(s), separated by a ';'
	            sfamily means Unique subject family(s), separated by a ';'
	         ssubfamily means Unique subject subfamily(s), separated by a ';'
	             stribe means Unique subject tribe(s), separated by a ';'
	          ssubtribe means Unique subject subtribe(s), separated by a ';'
	             sgenus means Unique subject genus(s), separated by a ';'
	          ssubgenus means Unique subject subgenus(s), separated by a ';'
	           ssection means Unique subject section(s), separated by a ';'
	        ssubsection means Unique subject subsection(s), separated by a ';'
	            sseries means Unique subject series(s), separated by a ';'
	     sspecies_group means Unique subject species group(s), separated by a ';'
	  sspecies_subgroup means Unique subject species subgroup(s), separated by a ';'
	           sspecies means Unique subject species(s), separated by a ';'
	        ssubspecies means Unique subject subspecies(s), separated by a ';'
	          svarietas means Unique subject varietas(s), separated by a ';'
	             sforma means Unique subject forma(s), separated by a ';'
	            sstrain means Unique subject strain(s), separated by a ';'
	           sbiotype means Unique subject biotype(s), separated by a ';'
	             sclade means Unique subject clade(s), separated by a ';'
	   sforma_specialis means Unique subject forma specialis(s), separated by a ';'
	          sgenotype means Unique subject genotype(s), separated by a ';'
	           sisolate means Unique subject isolate(s), separated by a ';'
	             smorph means Unique subject morph(s), separated by a ';'
	        spathogroup means Unique subject pathogroup(s), separated by a ';'
	         sserogroup means Unique subject serogroup(s), separated by a ';'
	          sserotype means Unique subject serotype(s), separated by a ';'
	        ssubvariety means Unique subject subvariety(s), separated by a ';'

	Default: qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore

--qnum-offset            offset added to query ordinal id (qnum field)
--snum-offset            offset added to subject ordinal id (snum field)
--include-lineage        Include lineage in the taxonomic classification format
--file-buffer-size       file buffer size in bytes (default=67108864)
--no-unlink              Do not unlink temporary files.
--ignore-warnings        Ignore warnings
--no-parse-seqids        Print raw seqids without parsing
--parallel-tmpdir        directory for temporary files used by multiprocessing
--bin                    number of query bins for seed search
--ext-chunk-size         chunk size for adaptive ranking (default=auto)
--no-ranking             disable ranking heuristic
--dbsize                 effective database size (in letters)
--no-auto-append         disable auto appending of DAA and DMND file extensions
--tantan-minMaskProb     minimum repeat probability for masking (default=0.9)
--oid-output             Output OIDs instead of accessions (clustering)
--swipe-task-size        task size for DP parallelism (100000000)
--anchored-swipe         Enable anchored SWIPE extension
--query-match-distance-thresholdMatrix adjust threshold
--length-ratio-threshold Matrix adjust threshold
--cbs-angle              Matrix adjust threshold
--linclust-banded-ext    Use banded instead of full matrix DP for linear searches
--linclust-chunk-size    Chunk size for linclust in parallel mode (default=10G)
--hit-membuf             Buffer intermediate hits in memory
--algo                   Seed search algorithm (0=double-indexed/1=query-indexed/ctg=contiguous-seed)
--min-orf                ignore translated sequences without an open reading frame of at least this length
--min-query-len          filter query sequences shorter than this length
--load-threads           number of CPU threads for file I/O
--minichunk              Mini chunk size for file I/O
--seed-cut               cutoff for seed complexity
--freq-masking           mask seeds based on frequency
--freq-sd                number of standard deviations for ignoring frequent seeds
--sketch-size            Subsample seeds based on minimizer sketch of the given size
--tile-size              Loop tiling size (default=1024)
--id2                    minimum number of identities for stage 1 hit
--linsearch              only consider seed hits against longest target for identical seeds
--lin-stage1             only consider seed hits against longest query for identical seeds
--lin-combo              only consider seed hits against the longest of query and target for identical seeds
--xdrop                  xdrop for ungapped alignment
--ungapped-evalue        E-value threshold for ungapped filter (auto)
--ungapped-evalue-short  E-value threshold for ungapped filter (short reads) (auto)
--short-query-ungapped-bitscoreBit score threshold for ungapped alignments for short queries
--gapped-filter-evalue   E-value threshold for gapped filter (auto)
--band                   band for dynamic programming computation
--shape-mask             seed shapes
--multiprocessing        enable distributed-memory parallel processing
--mp-init                initialize multiprocessing run
--mp-recover             enable continuation of interrupted multiprocessing run
--mp-query-chunk         process only a single query chunk as specified
--culling-overlap        minimum range overlap with higher scoring hit to delete a hit (default=50%)
--taxon-k                maximum number of targets to report per species
--range-cover            percentage of query range to be covered for range culling (default=50%)
--xml-blord-format       Use gnl|BL_ORD_ID| style format in XML output
--sam-query-len          add the query length to the SAM format (tag ZQ)
--stop-match-score       Set the match score of stop codons against each other.
--target-indexed         Enable target-indexed mode
--daa                    DIAMOND alignment archive (DAA) file
--window                 window size for local hit search
--ungapped-score         minimum alignment score to continue local extension
--hit-band               band for hit verification
--hit-score              minimum score to keep a tentative alignment
--gapped-xdrop           xdrop for gapped alignment in bits
--rank-ratio2            include subjects within this ratio of last hit (stage 2)
--rank-ratio             include subjects within this ratio of last hit
--lambda                 lambda parameter for custom matrix
--K                      K parameter for custom matrix

diamond v2.1.24.178 (C) Max Planck Society for the Advancement of Science, Benjamin J. Buchfink, University of Tuebingen
Documentation, support and updates available at http://www.diamondsearch.org
Please cite: http://dx.doi.org/10.1038/s41592-021-01101-x Nature Methods (2021)

Error: Missing parameter: database file (--db/-d)
```


## diamond_blastx

### Tool Description
DIAMOND is a sequence aligner for protein and translated DNA searches, designed for high performance analysis of big sequence data.

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--out                    output file
--header                 Use header lines in tabular output format (0/simple/verbose).
--comp-based-stats       composition based statistics mode (0-4)
--masking                masking algorithm (none, seg, tantan=default)
--soft-masking           soft masking (none=default, seg, tantan)
--gapopen                gap open penalty
--gapextend              gap extension penalty
--matrix                 score matrix for protein alignment (default=BLOSUM62)
--custom-matrix          file containing custom scoring matrix
--evalue                 maximum e-value to report alignments (default=0.001)
--motif-masking          softmask abundant motifs (0/1)
--approx-id              minimum approx. identity% to report an alignment/to cluster sequences
--ext                    Extension mode (banded-fast/banded-slow/full)
--max-target-seqs        maximum number of target sequences to report alignments for (default=25)
--top                    report alignments within this percentage range of top alignment score (overrides --max-target-seqs)
--faster                 enable faster mode
--fast                   enable fast mode
--mid-sensitive          enable mid-sensitive mode
--linclust-20            enable mode for linear search at 20% identity
--shapes-6x10            enable mode using 30 seed shapes of weight 10
--shapes-30x10           enable mode using 30 seed shapes of weight 10
--sensitive              enable sensitive mode)
--more-sensitive         enable more sensitive mode
--very-sensitive         enable very sensitive mode
--ultra-sensitive        enable ultra sensitive mode
--shapes                 number of seed shapes (default=all available)
--query                  input query file
--strand                 query strands to search (both/minus/plus)
--un                     file for unaligned queries
--al                     file or aligned queries
--unfmt                  format of unaligned query file (fasta/fastq)
--alfmt                  format of aligned query file (fasta/fastq)
--unal                   report unaligned queries (0=no, 1=yes)
--max-hsps               maximum number of HSPs per target sequence to report for each query (default=1)
--range-culling          restrict hit culling to overlapping query ranges
--compress               compression for output files (0=none, 1=gzip, zstd)
--min-score              minimum bit score to report alignments (overrides e-value setting)
--id                     minimum identity% to report an alignment
--query-cover            minimum query cover% to report an alignment
--subject-cover          minimum subject cover% to report an alignment
--swipe                  exhaustive alignment against all database sequences
--iterate                iterated search with increasing sensitivity
--global-ranking         number of targets for global ranking
--block-size             sequence block size in billions of letters (default=2.0)
--index-chunks           number of chunks for index processing (default=4)
--frameshift             frame shift penalty (default=disabled)
--long-reads             short for --range-culling --top 10 -F 15
--query-gencode          genetic code to use to translate query (see user manual)
--salltitles             include full subject titles in DAA file
--sallseqid              include all subject ids in DAA file
--no-self-hits           suppress reporting of identical self hits
--taxonlist              restrict search to list of taxon ids (comma-separated)
--taxon-exclude          exclude list of taxon ids (comma-separated)
--seqidlist              filter the database by list of accessions
--skip-missing-seqids    ignore accessions missing in the database
--outfmt                 output format
	0   = BLAST pairwise
	5   = BLAST XML
	6   = BLAST tabular
	100 = DIAMOND alignment archive (DAA)
	101 = SAM
	102 = Taxonomic classification
	103 = PAF
	104 = JSON (flat)

	Values 6 and 104 may be followed by a space-separated list of these keywords:

	             qseqid means Query Seq - id
	               qlen means Query sequence length
	             sseqid means Subject Seq - id
	          sallseqid means All subject Seq - id(s), separated by a ';'
	               slen means Subject sequence length
	             qstart means Start of alignment in query
	               qend means End of alignment in query
	             sstart means Start of alignment in subject
	               send means End of alignment in subject
	               qseq means Aligned part of query sequence
	               sseq means Aligned part of subject sequence
	             evalue means Expect value
	           bitscore means Bit score
	              score means Raw score
	             length means Alignment length
	             pident means Percentage of identical matches
	             nident means Number of identical matches
	           mismatch means Number of mismatches
	           positive means Number of positive - scoring matches
	            gapopen means Number of gap openings
	               gaps means Total number of gaps
	               ppos means Percentage of positive - scoring matches
	             qframe means Query frame
	               btop means Blast traceback operations (BTOP)
	            staxids means Unique Subject Taxonomy ID(s), separated by a ';' (in numerical order)
	          sscinames means Unique Subject Scientific Name(s), separated by a ';'
	         sskingdoms means Unique Subject Super Kingdom(s), separated by a ';'
	             stitle means Subject Title
	         salltitles means All Subject Title(s), separated by a '<>'
	            qcovhsp means Query coverage per HSP
	             qtitle means Query title
	          full_sseq means Subject sequence
	              qqual means Query quality values for the aligned part of the query
	               qnum means Query ordinal id
	               snum means Subject ordinal id
	            scovhsp means Subject coverage per HSP
	         full_qqual means Query quality values
	          full_qseq means Query sequence
	        qseq_gapped means Aligned part of query sequence (with gaps)
	        sseq_gapped means Aligned part of subject sequence (with gaps)
	            qstrand means Query strand
	              cigar means CIGAR string
	          skingdoms means Unique Subject Kingdom(s), separated by a ';'
	           sphylums means Unique Subject Phylum(s), separated by a ';'
	     full_qseq_mate means Query sequence of the mate
	    qseq_translated means Aligned part of query sequence (translated)
	             hspnum means Number of HSP within the subject
	normalized_bitscore means Bitscore normalized by maximum self alignment score
	  normalized_nident means Number of identical matches normalized by maximum length
	      approx_pident means Approximate percentage of identical matches
	 corrected_bitscore means Bit score corrected for edge effects
	          slineages means Unique Subject Lineage(s), separated by a '<>'
	      ssuperkingdom means Unique subject superkingdom(s), separated by a ';'
	     scellular_root means Unique subject cellular root(s), separated by a ';'
	    sacellular_root means Unique subject acellular root(s), separated by a ';'
	            sdomain means Unique subject domain(s), separated by a ';'
	             srealm means Unique subject realm(s), separated by a ';'
	           skingdom means Unique subject kingdom(s), separated by a ';'
	        ssubkingdom means Unique subject subkingdom(s), separated by a ';'
	       ssuperphylum means Unique subject superphylum(s), separated by a ';'
	            sphylum means Unique subject phylum(s), separated by a ';'
	         ssubphylum means Unique subject subphylum(s), separated by a ';'
	        ssuperclass means Unique subject superclass(s), separated by a ';'
	             sclass means Unique subject class(s), separated by a ';'
	          ssubclass means Unique subject subclass(s), separated by a ';'
	        sinfraclass means Unique subject infraclass(s), separated by a ';'
	            scohort means Unique subject cohort(s), separated by a ';'
	         ssubcohort means Unique subject subcohort(s), separated by a ';'
	        ssuperorder means Unique subject superorder(s), separated by a ';'
	             sorder means Unique subject order(s), separated by a ';'
	          ssuborder means Unique subject suborder(s), separated by a ';'
	        sinfraorder means Unique subject infraorder(s), separated by a ';'
	         sparvorder means Unique subject parvorder(s), separated by a ';'
	       ssuperfamily means Unique subject superfamily(s), separated by a ';'
	            sfamily means Unique subject family(s), separated by a ';'
	         ssubfamily means Unique subject subfamily(s), separated by a ';'
	             stribe means Unique subject tribe(s), separated by a ';'
	          ssubtribe means Unique subject subtribe(s), separated by a ';'
	             sgenus means Unique subject genus(s), separated by a ';'
	          ssubgenus means Unique subject subgenus(s), separated by a ';'
	           ssection means Unique subject section(s), separated by a ';'
	        ssubsection means Unique subject subsection(s), separated by a ';'
	            sseries means Unique subject series(s), separated by a ';'
	     sspecies_group means Unique subject species group(s), separated by a ';'
	  sspecies_subgroup means Unique subject species subgroup(s), separated by a ';'
	           sspecies means Unique subject species(s), separated by a ';'
	        ssubspecies means Unique subject subspecies(s), separated by a ';'
	          svarietas means Unique subject varietas(s), separated by a ';'
	             sforma means Unique subject forma(s), separated by a ';'
	            sstrain means Unique subject strain(s), separated by a ';'
	           sbiotype means Unique subject biotype(s), separated by a ';'
	             sclade means Unique subject clade(s), separated by a ';'
	   sforma_specialis means Unique subject forma specialis(s), separated by a ';'
	          sgenotype means Unique subject genotype(s), separated by a ';'
	           sisolate means Unique subject isolate(s), separated by a ';'
	             smorph means Unique subject morph(s), separated by a ';'
	        spathogroup means Unique subject pathogroup(s), separated by a ';'
	         sserogroup means Unique subject serogroup(s), separated by a ';'
	          sserotype means Unique subject serotype(s), separated by a ';'
	        ssubvariety means Unique subject subvariety(s), separated by a ';'

	Default: qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore

--qnum-offset            offset added to query ordinal id (qnum field)
--snum-offset            offset added to subject ordinal id (snum field)
--include-lineage        Include lineage in the taxonomic classification format
--file-buffer-size       file buffer size in bytes (default=67108864)
--no-unlink              Do not unlink temporary files.
--ignore-warnings        Ignore warnings
--no-parse-seqids        Print raw seqids without parsing
--parallel-tmpdir        directory for temporary files used by multiprocessing
--bin                    number of query bins for seed search
--ext-chunk-size         chunk size for adaptive ranking (default=auto)
--no-ranking             disable ranking heuristic
--dbsize                 effective database size (in letters)
--no-auto-append         disable auto appending of DAA and DMND file extensions
--tantan-minMaskProb     minimum repeat probability for masking (default=0.9)
--oid-output             Output OIDs instead of accessions (clustering)
--swipe-task-size        task size for DP parallelism (100000000)
--anchored-swipe         Enable anchored SWIPE extension
--query-match-distance-thresholdMatrix adjust threshold
--length-ratio-threshold Matrix adjust threshold
--cbs-angle              Matrix adjust threshold
--linclust-banded-ext    Use banded instead of full matrix DP for linear searches
--linclust-chunk-size    Chunk size for linclust in parallel mode (default=10G)
--hit-membuf             Buffer intermediate hits in memory
--algo                   Seed search algorithm (0=double-indexed/1=query-indexed/ctg=contiguous-seed)
--min-orf                ignore translated sequences without an open reading frame of at least this length
--min-query-len          filter query sequences shorter than this length
--load-threads           number of CPU threads for file I/O
--minichunk              Mini chunk size for file I/O
--seed-cut               cutoff for seed complexity
--freq-masking           mask seeds based on frequency
--freq-sd                number of standard deviations for ignoring frequent seeds
--sketch-size            Subsample seeds based on minimizer sketch of the given size
--tile-size              Loop tiling size (default=1024)
--id2                    minimum number of identities for stage 1 hit
--linsearch              only consider seed hits against longest target for identical seeds
--lin-stage1             only consider seed hits against longest query for identical seeds
--lin-combo              only consider seed hits against the longest of query and target for identical seeds
--xdrop                  xdrop for ungapped alignment
--ungapped-evalue        E-value threshold for ungapped filter (auto)
--ungapped-evalue-short  E-value threshold for ungapped filter (short reads) (auto)
--short-query-ungapped-bitscoreBit score threshold for ungapped alignments for short queries
--gapped-filter-evalue   E-value threshold for gapped filter (auto)
--band                   band for dynamic programming computation
--shape-mask             seed shapes
--multiprocessing        enable distributed-memory parallel processing
--mp-init                initialize multiprocessing run
--mp-recover             enable continuation of interrupted multiprocessing run
--mp-query-chunk         process only a single query chunk as specified
--culling-overlap        minimum range overlap with higher scoring hit to delete a hit (default=50%)
--taxon-k                maximum number of targets to report per species
--range-cover            percentage of query range to be covered for range culling (default=50%)
--xml-blord-format       Use gnl|BL_ORD_ID| style format in XML output
--sam-query-len          add the query length to the SAM format (tag ZQ)
--stop-match-score       Set the match score of stop codons against each other.
--target-indexed         Enable target-indexed mode
--daa                    DIAMOND alignment archive (DAA) file
--window                 window size for local hit search
--ungapped-score         minimum alignment score to continue local extension
--hit-band               band for hit verification
--hit-score              minimum score to keep a tentative alignment
--gapped-xdrop           xdrop for gapped alignment in bits
--rank-ratio2            include subjects within this ratio of last hit (stage 2)
--rank-ratio             include subjects within this ratio of last hit
--lambda                 lambda parameter for custom matrix
--K                      K parameter for custom matrix

diamond v2.1.24.178 (C) Max Planck Society for the Advancement of Science, Benjamin J. Buchfink, University of Tuebingen
Documentation, support and updates available at http://www.diamondsearch.org
Please cite: http://dx.doi.org/10.1038/s41592-021-01101-x Nature Methods (2021)

Error: Missing parameter: database file (--db/-d)
```


## diamond_cluster

### Tool Description
Clustering sequences using the DIAMOND algorithm

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--out                    output file
--header                 Use header lines in tabular output format (0/simple/verbose).
--comp-based-stats       composition based statistics mode (0-4)
--masking                masking algorithm (none, seg, tantan=default)
--soft-masking           soft masking (none=default, seg, tantan)
--gapopen                gap open penalty
--gapextend              gap extension penalty
--matrix                 score matrix for protein alignment (default=BLOSUM62)
--custom-matrix          file containing custom scoring matrix
--evalue                 maximum e-value to report alignments (default=0.001)
--motif-masking          softmask abundant motifs (0/1)
--approx-id              minimum approx. identity% to report an alignment/to cluster sequences
--ext                    Extension mode (banded-fast/banded-slow/full)
--cluster-steps          Clustering steps
--kmer-ranking           Rank sequences based on kmer frequency in linear stage
--round-coverage         Per-round coverage cutoffs for cascaded clustering
--round-approx-id        Per-round approx-id cutoffs for cascaded clustering
--aln-out                Output file for clustering alignments
--memory-limit           Memory limit in GB (default = 16G)
--member-cover           Minimum coverage% of the cluster member sequence (default=80.0)
--mutual-cover           Minimum mutual coverage% of the cluster member and representative sequence
--connected-component-depthDepth to cluster connected components
--no-reassign            Do not reassign to closest representative
--file-buffer-size       file buffer size in bytes (default=67108864)
--no-unlink              Do not unlink temporary files.
--ignore-warnings        Ignore warnings
--no-parse-seqids        Print raw seqids without parsing
--parallel-tmpdir        directory for temporary files used by multiprocessing
--bin                    number of query bins for seed search
--ext-chunk-size         chunk size for adaptive ranking (default=auto)
--no-ranking             disable ranking heuristic
--dbsize                 effective database size (in letters)
--no-auto-append         disable auto appending of DAA and DMND file extensions
--tantan-minMaskProb     minimum repeat probability for masking (default=0.9)
--oid-output             Output OIDs instead of accessions (clustering)
--swipe-task-size        task size for DP parallelism (100000000)
--anchored-swipe         Enable anchored SWIPE extension
--query-match-distance-thresholdMatrix adjust threshold
--length-ratio-threshold Matrix adjust threshold
--cbs-angle              Matrix adjust threshold
--linclust-banded-ext    Use banded instead of full matrix DP for linear searches
--linclust-chunk-size    Chunk size for linclust in parallel mode (default=10G)
--hit-membuf             Buffer intermediate hits in memory

diamond v2.1.24.178 (C) Max Planck Society for the Advancement of Science, Benjamin J. Buchfink, University of Tuebingen
Documentation, support and updates available at http://www.diamondsearch.org
Please cite: http://dx.doi.org/10.1038/s41592-021-01101-x Nature Methods (2021)

Error: Missing parameter: --db/-d
```


## diamond_linclust

### Tool Description
Clustering of protein sequences using the DIAMOND linclust algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--out                    output file
--header                 Use header lines in tabular output format (0/simple/verbose).
--comp-based-stats       composition based statistics mode (0-4)
--masking                masking algorithm (none, seg, tantan=default)
--soft-masking           soft masking (none=default, seg, tantan)
--gapopen                gap open penalty
--gapextend              gap extension penalty
--matrix                 score matrix for protein alignment (default=BLOSUM62)
--custom-matrix          file containing custom scoring matrix
--evalue                 maximum e-value to report alignments (default=0.001)
--motif-masking          softmask abundant motifs (0/1)
--approx-id              minimum approx. identity% to report an alignment/to cluster sequences
--ext                    Extension mode (banded-fast/banded-slow/full)
--cluster-steps          Clustering steps
--kmer-ranking           Rank sequences based on kmer frequency in linear stage
--round-coverage         Per-round coverage cutoffs for cascaded clustering
--round-approx-id        Per-round approx-id cutoffs for cascaded clustering
--aln-out                Output file for clustering alignments
--memory-limit           Memory limit in GB (default = 16G)
--member-cover           Minimum coverage% of the cluster member sequence (default=80.0)
--mutual-cover           Minimum mutual coverage% of the cluster member and representative sequence
--connected-component-depthDepth to cluster connected components
--no-reassign            Do not reassign to closest representative
--file-buffer-size       file buffer size in bytes (default=67108864)
--no-unlink              Do not unlink temporary files.
--ignore-warnings        Ignore warnings
--no-parse-seqids        Print raw seqids without parsing
--parallel-tmpdir        directory for temporary files used by multiprocessing
--bin                    number of query bins for seed search
--ext-chunk-size         chunk size for adaptive ranking (default=auto)
--no-ranking             disable ranking heuristic
--dbsize                 effective database size (in letters)
--no-auto-append         disable auto appending of DAA and DMND file extensions
--tantan-minMaskProb     minimum repeat probability for masking (default=0.9)
--oid-output             Output OIDs instead of accessions (clustering)
--swipe-task-size        task size for DP parallelism (100000000)
--anchored-swipe         Enable anchored SWIPE extension
--query-match-distance-thresholdMatrix adjust threshold
--length-ratio-threshold Matrix adjust threshold
--cbs-angle              Matrix adjust threshold
--linclust-banded-ext    Use banded instead of full matrix DP for linear searches
--linclust-chunk-size    Chunk size for linclust in parallel mode (default=10G)
--hit-membuf             Buffer intermediate hits in memory

diamond v2.1.24.178 (C) Max Planck Society for the Advancement of Science, Benjamin J. Buchfink, University of Tuebingen
Documentation, support and updates available at http://www.diamondsearch.org
Please cite: http://dx.doi.org/10.1038/s41592-021-01101-x Nature Methods (2021)

Error: Missing parameter: --db/-d
```


## diamond_realign

### Tool Description
Realign sequences using the DIAMOND engine

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--out                    output file
--header                 Use header lines in tabular output format (0/simple/verbose).
--comp-based-stats       composition based statistics mode (0-4)
--masking                masking algorithm (none, seg, tantan=default)
--soft-masking           soft masking (none=default, seg, tantan)
--outfmt                 output format
	0   = BLAST pairwise
	5   = BLAST XML
	6   = BLAST tabular
	100 = DIAMOND alignment archive (DAA)
	101 = SAM
	102 = Taxonomic classification
	103 = PAF
	104 = JSON (flat)

	Values 6 and 104 may be followed by a space-separated list of these keywords:

	             qseqid means Query Seq - id
	               qlen means Query sequence length
	             sseqid means Subject Seq - id
	          sallseqid means All subject Seq - id(s), separated by a ';'
	               slen means Subject sequence length
	             qstart means Start of alignment in query
	               qend means End of alignment in query
	             sstart means Start of alignment in subject
	               send means End of alignment in subject
	               qseq means Aligned part of query sequence
	               sseq means Aligned part of subject sequence
	             evalue means Expect value
	           bitscore means Bit score
	              score means Raw score
	             length means Alignment length
	             pident means Percentage of identical matches
	             nident means Number of identical matches
	           mismatch means Number of mismatches
	           positive means Number of positive - scoring matches
	            gapopen means Number of gap openings
	               gaps means Total number of gaps
	               ppos means Percentage of positive - scoring matches
	             qframe means Query frame
	               btop means Blast traceback operations (BTOP)
	            staxids means Unique Subject Taxonomy ID(s), separated by a ';' (in numerical order)
	          sscinames means Unique Subject Scientific Name(s), separated by a ';'
	         sskingdoms means Unique Subject Super Kingdom(s), separated by a ';'
	             stitle means Subject Title
	         salltitles means All Subject Title(s), separated by a '<>'
	            qcovhsp means Query coverage per HSP
	             qtitle means Query title
	          full_sseq means Subject sequence
	              qqual means Query quality values for the aligned part of the query
	               qnum means Query ordinal id
	               snum means Subject ordinal id
	            scovhsp means Subject coverage per HSP
	         full_qqual means Query quality values
	          full_qseq means Query sequence
	        qseq_gapped means Aligned part of query sequence (with gaps)
	        sseq_gapped means Aligned part of subject sequence (with gaps)
	            qstrand means Query strand
	              cigar means CIGAR string
	          skingdoms means Unique Subject Kingdom(s), separated by a ';'
	           sphylums means Unique Subject Phylum(s), separated by a ';'
	     full_qseq_mate means Query sequence of the mate
	    qseq_translated means Aligned part of query sequence (translated)
	             hspnum means Number of HSP within the subject
	normalized_bitscore means Bitscore normalized by maximum self alignment score
	  normalized_nident means Number of identical matches normalized by maximum length
	      approx_pident means Approximate percentage of identical matches
	 corrected_bitscore means Bit score corrected for edge effects
	          slineages means Unique Subject Lineage(s), separated by a '<>'
	      ssuperkingdom means Unique subject superkingdom(s), separated by a ';'
	     scellular_root means Unique subject cellular root(s), separated by a ';'
	    sacellular_root means Unique subject acellular root(s), separated by a ';'
	            sdomain means Unique subject domain(s), separated by a ';'
	             srealm means Unique subject realm(s), separated by a ';'
	           skingdom means Unique subject kingdom(s), separated by a ';'
	        ssubkingdom means Unique subject subkingdom(s), separated by a ';'
	       ssuperphylum means Unique subject superphylum(s), separated by a ';'
	            sphylum means Unique subject phylum(s), separated by a ';'
	         ssubphylum means Unique subject subphylum(s), separated by a ';'
	        ssuperclass means Unique subject superclass(s), separated by a ';'
	             sclass means Unique subject class(s), separated by a ';'
	          ssubclass means Unique subject subclass(s), separated by a ';'
	        sinfraclass means Unique subject infraclass(s), separated by a ';'
	            scohort means Unique subject cohort(s), separated by a ';'
	         ssubcohort means Unique subject subcohort(s), separated by a ';'
	        ssuperorder means Unique subject superorder(s), separated by a ';'
	             sorder means Unique subject order(s), separated by a ';'
	          ssuborder means Unique subject suborder(s), separated by a ';'
	        sinfraorder means Unique subject infraorder(s), separated by a ';'
	         sparvorder means Unique subject parvorder(s), separated by a ';'
	       ssuperfamily means Unique subject superfamily(s), separated by a ';'
	            sfamily means Unique subject family(s), separated by a ';'
	         ssubfamily means Unique subject subfamily(s), separated by a ';'
	             stribe means Unique subject tribe(s), separated by a ';'
	          ssubtribe means Unique subject subtribe(s), separated by a ';'
	             sgenus means Unique subject genus(s), separated by a ';'
	          ssubgenus means Unique subject subgenus(s), separated by a ';'
	           ssection means Unique subject section(s), separated by a ';'
	        ssubsection means Unique subject subsection(s), separated by a ';'
	            sseries means Unique subject series(s), separated by a ';'
	     sspecies_group means Unique subject species group(s), separated by a ';'
	  sspecies_subgroup means Unique subject species subgroup(s), separated by a ';'
	           sspecies means Unique subject species(s), separated by a ';'
	        ssubspecies means Unique subject subspecies(s), separated by a ';'
	          svarietas means Unique subject varietas(s), separated by a ';'
	             sforma means Unique subject forma(s), separated by a ';'
	            sstrain means Unique subject strain(s), separated by a ';'
	           sbiotype means Unique subject biotype(s), separated by a ';'
	             sclade means Unique subject clade(s), separated by a ';'
	   sforma_specialis means Unique subject forma specialis(s), separated by a ';'
	          sgenotype means Unique subject genotype(s), separated by a ';'
	           sisolate means Unique subject isolate(s), separated by a ';'
	             smorph means Unique subject morph(s), separated by a ';'
	        spathogroup means Unique subject pathogroup(s), separated by a ';'
	         sserogroup means Unique subject serogroup(s), separated by a ';'
	          sserotype means Unique subject serotype(s), separated by a ';'
	        ssubvariety means Unique subject subvariety(s), separated by a ';'

	Default: qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore

--qnum-offset            offset added to query ordinal id (qnum field)
--snum-offset            offset added to subject ordinal id (snum field)
--memory-limit           Memory limit in GB (default = 16G)
--clusters               Clustering input file mapping sequences to representatives

diamond v2.1.24.178 (C) Max Planck Society for the Advancement of Science, Benjamin J. Buchfink, University of Tuebingen
Documentation, support and updates available at http://www.diamondsearch.org
Please cite: http://dx.doi.org/10.1038/s41592-021-01101-x Nature Methods (2021)

Error: Missing parameter: --db/-d
```


## diamond_recluster

### Tool Description
Recluster sequences using the DIAMOND algorithm

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--out                    output file
--header                 Use header lines in tabular output format (0/simple/verbose).
--comp-based-stats       composition based statistics mode (0-4)
--masking                masking algorithm (none, seg, tantan=default)
--soft-masking           soft masking (none=default, seg, tantan)
--gapopen                gap open penalty
--gapextend              gap extension penalty
--matrix                 score matrix for protein alignment (default=BLOSUM62)
--custom-matrix          file containing custom scoring matrix
--evalue                 maximum e-value to report alignments (default=0.001)
--motif-masking          softmask abundant motifs (0/1)
--approx-id              minimum approx. identity% to report an alignment/to cluster sequences
--ext                    Extension mode (banded-fast/banded-slow/full)
--cluster-steps          Clustering steps
--kmer-ranking           Rank sequences based on kmer frequency in linear stage
--round-coverage         Per-round coverage cutoffs for cascaded clustering
--round-approx-id        Per-round approx-id cutoffs for cascaded clustering
--aln-out                Output file for clustering alignments
--memory-limit           Memory limit in GB (default = 16G)
--member-cover           Minimum coverage% of the cluster member sequence (default=80.0)
--mutual-cover           Minimum mutual coverage% of the cluster member and representative sequence
--connected-component-depthDepth to cluster connected components
--no-reassign            Do not reassign to closest representative
--clusters               Clustering input file mapping sequences to representatives
--parallel-tmpdir        directory for temporary files used by multiprocessing
--bin                    number of query bins for seed search
--ext-chunk-size         chunk size for adaptive ranking (default=auto)
--no-ranking             disable ranking heuristic
--dbsize                 effective database size (in letters)
--no-auto-append         disable auto appending of DAA and DMND file extensions
--tantan-minMaskProb     minimum repeat probability for masking (default=0.9)
--oid-output             Output OIDs instead of accessions (clustering)
--swipe-task-size        task size for DP parallelism (100000000)
--anchored-swipe         Enable anchored SWIPE extension
--query-match-distance-thresholdMatrix adjust threshold
--length-ratio-threshold Matrix adjust threshold
--cbs-angle              Matrix adjust threshold
--linclust-banded-ext    Use banded instead of full matrix DP for linear searches
--linclust-chunk-size    Chunk size for linclust in parallel mode (default=10G)
--hit-membuf             Buffer intermediate hits in memory

diamond v2.1.24.178 (C) Max Planck Society for the Advancement of Science, Benjamin J. Buchfink, University of Tuebingen
Documentation, support and updates available at http://www.diamondsearch.org
Please cite: http://dx.doi.org/10.1038/s41592-021-01101-x Nature Methods (2021)

Error: Missing parameter: --db/-d
```


## diamond_reassign

### Tool Description
Reassign sequences to closest representatives in clustering

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--out                    output file
--header                 Use header lines in tabular output format (0/simple/verbose).
--comp-based-stats       composition based statistics mode (0-4)
--masking                masking algorithm (none, seg, tantan=default)
--soft-masking           soft masking (none=default, seg, tantan)
--gapopen                gap open penalty
--gapextend              gap extension penalty
--matrix                 score matrix for protein alignment (default=BLOSUM62)
--custom-matrix          file containing custom scoring matrix
--evalue                 maximum e-value to report alignments (default=0.001)
--motif-masking          softmask abundant motifs (0/1)
--approx-id              minimum approx. identity% to report an alignment/to cluster sequences
--ext                    Extension mode (banded-fast/banded-slow/full)
--memory-limit           Memory limit in GB (default = 16G)
--member-cover           Minimum coverage% of the cluster member sequence (default=80.0)
--mutual-cover           Minimum mutual coverage% of the cluster member and representative sequence
--connected-component-depthDepth to cluster connected components
--no-reassign            Do not reassign to closest representative
--clusters               Clustering input file mapping sequences to representatives
--file-buffer-size       file buffer size in bytes (default=67108864)
--no-unlink              Do not unlink temporary files.
--ignore-warnings        Ignore warnings
--no-parse-seqids        Print raw seqids without parsing
--parallel-tmpdir        directory for temporary files used by multiprocessing
--bin                    number of query bins for seed search
--ext-chunk-size         chunk size for adaptive ranking (default=auto)
--no-ranking             disable ranking heuristic
--dbsize                 effective database size (in letters)
--no-auto-append         disable auto appending of DAA and DMND file extensions
--tantan-minMaskProb     minimum repeat probability for masking (default=0.9)
--oid-output             Output OIDs instead of accessions (clustering)
--swipe-task-size        task size for DP parallelism (100000000)
--anchored-swipe         Enable anchored SWIPE extension
--query-match-distance-thresholdMatrix adjust threshold
--length-ratio-threshold Matrix adjust threshold
--cbs-angle              Matrix adjust threshold
--linclust-banded-ext    Use banded instead of full matrix DP for linear searches
--linclust-chunk-size    Chunk size for linclust in parallel mode (default=10G)
--hit-membuf             Buffer intermediate hits in memory

diamond v2.1.24.178 (C) Max Planck Society for the Advancement of Science, Benjamin J. Buchfink, University of Tuebingen
Documentation, support and updates available at http://www.diamondsearch.org
Please cite: http://dx.doi.org/10.1038/s41592-021-01101-x Nature Methods (2021)

Error: Missing parameter: --db/-d
```


## diamond_view

### Tool Description
View and convert DIAMOND alignment archive (DAA) files

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--out                    output file
--header                 Use header lines in tabular output format (0/simple/verbose).
--max-target-seqs        maximum number of target sequences to report alignments for (default=25)
--top                    report alignments within this percentage range of top alignment score (overrides --max-target-seqs)
--outfmt                 output format
	0   = BLAST pairwise
	5   = BLAST XML
	6   = BLAST tabular
	100 = DIAMOND alignment archive (DAA)
	101 = SAM
	102 = Taxonomic classification
	103 = PAF
	104 = JSON (flat)

	Values 6 and 104 may be followed by a space-separated list of these keywords:

	             qseqid means Query Seq - id
	               qlen means Query sequence length
	             sseqid means Subject Seq - id
	          sallseqid means All subject Seq - id(s), separated by a ';'
	               slen means Subject sequence length
	             qstart means Start of alignment in query
	               qend means End of alignment in query
	             sstart means Start of alignment in subject
	               send means End of alignment in subject
	               qseq means Aligned part of query sequence
	               sseq means Aligned part of subject sequence
	             evalue means Expect value
	           bitscore means Bit score
	              score means Raw score
	             length means Alignment length
	             pident means Percentage of identical matches
	             nident means Number of identical matches
	           mismatch means Number of mismatches
	           positive means Number of positive - scoring matches
	            gapopen means Number of gap openings
	               gaps means Total number of gaps
	               ppos means Percentage of positive - scoring matches
	             qframe means Query frame
	               btop means Blast traceback operations (BTOP)
	            staxids means Unique Subject Taxonomy ID(s), separated by a ';' (in numerical order)
	          sscinames means Unique Subject Scientific Name(s), separated by a ';'
	         sskingdoms means Unique Subject Super Kingdom(s), separated by a ';'
	             stitle means Subject Title
	         salltitles means All Subject Title(s), separated by a '<>'
	            qcovhsp means Query coverage per HSP
	             qtitle means Query title
	          full_sseq means Subject sequence
	              qqual means Query quality values for the aligned part of the query
	               qnum means Query ordinal id
	               snum means Subject ordinal id
	            scovhsp means Subject coverage per HSP
	         full_qqual means Query quality values
	          full_qseq means Query sequence
	        qseq_gapped means Aligned part of query sequence (with gaps)
	        sseq_gapped means Aligned part of subject sequence (with gaps)
	            qstrand means Query strand
	              cigar means CIGAR string
	          skingdoms means Unique Subject Kingdom(s), separated by a ';'
	           sphylums means Unique Subject Phylum(s), separated by a ';'
	     full_qseq_mate means Query sequence of the mate
	    qseq_translated means Aligned part of query sequence (translated)
	             hspnum means Number of HSP within the subject
	normalized_bitscore means Bitscore normalized by maximum self alignment score
	  normalized_nident means Number of identical matches normalized by maximum length
	      approx_pident means Approximate percentage of identical matches
	 corrected_bitscore means Bit score corrected for edge effects
	          slineages means Unique Subject Lineage(s), separated by a '<>'
	      ssuperkingdom means Unique subject superkingdom(s), separated by a ';'
	     scellular_root means Unique subject cellular root(s), separated by a ';'
	    sacellular_root means Unique subject acellular root(s), separated by a ';'
	            sdomain means Unique subject domain(s), separated by a ';'
	             srealm means Unique subject realm(s), separated by a ';'
	           skingdom means Unique subject kingdom(s), separated by a ';'
	        ssubkingdom means Unique subject subkingdom(s), separated by a ';'
	       ssuperphylum means Unique subject superphylum(s), separated by a ';'
	            sphylum means Unique subject phylum(s), separated by a ';'
	         ssubphylum means Unique subject subphylum(s), separated by a ';'
	        ssuperclass means Unique subject superclass(s), separated by a ';'
	             sclass means Unique subject class(s), separated by a ';'
	          ssubclass means Unique subject subclass(s), separated by a ';'
	        sinfraclass means Unique subject infraclass(s), separated by a ';'
	            scohort means Unique subject cohort(s), separated by a ';'
	         ssubcohort means Unique subject subcohort(s), separated by a ';'
	        ssuperorder means Unique subject superorder(s), separated by a ';'
	             sorder means Unique subject order(s), separated by a ';'
	          ssuborder means Unique subject suborder(s), separated by a ';'
	        sinfraorder means Unique subject infraorder(s), separated by a ';'
	         sparvorder means Unique subject parvorder(s), separated by a ';'
	       ssuperfamily means Unique subject superfamily(s), separated by a ';'
	            sfamily means Unique subject family(s), separated by a ';'
	         ssubfamily means Unique subject subfamily(s), separated by a ';'
	             stribe means Unique subject tribe(s), separated by a ';'
	          ssubtribe means Unique subject subtribe(s), separated by a ';'
	             sgenus means Unique subject genus(s), separated by a ';'
	          ssubgenus means Unique subject subgenus(s), separated by a ';'
	           ssection means Unique subject section(s), separated by a ';'
	        ssubsection means Unique subject subsection(s), separated by a ';'
	            sseries means Unique subject series(s), separated by a ';'
	     sspecies_group means Unique subject species group(s), separated by a ';'
	  sspecies_subgroup means Unique subject species subgroup(s), separated by a ';'
	           sspecies means Unique subject species(s), separated by a ';'
	        ssubspecies means Unique subject subspecies(s), separated by a ';'
	          svarietas means Unique subject varietas(s), separated by a ';'
	             sforma means Unique subject forma(s), separated by a ';'
	            sstrain means Unique subject strain(s), separated by a ';'
	           sbiotype means Unique subject biotype(s), separated by a ';'
	             sclade means Unique subject clade(s), separated by a ';'
	   sforma_specialis means Unique subject forma specialis(s), separated by a ';'
	          sgenotype means Unique subject genotype(s), separated by a ';'
	           sisolate means Unique subject isolate(s), separated by a ';'
	             smorph means Unique subject morph(s), separated by a ';'
	        spathogroup means Unique subject pathogroup(s), separated by a ';'
	         sserogroup means Unique subject serogroup(s), separated by a ';'
	          sserotype means Unique subject serotype(s), separated by a ';'
	        ssubvariety means Unique subject subvariety(s), separated by a ';'

	Default: qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore

--qnum-offset            offset added to query ordinal id (qnum field)
--snum-offset            offset added to subject ordinal id (snum field)
--daa                    DIAMOND alignment archive (DAA) file
--forwardonly            only show alignments of forward strand

diamond v2.1.24.178 (C) Max Planck Society for the Advancement of Science, Benjamin J. Buchfink, University of Tuebingen
Documentation, support and updates available at http://www.diamondsearch.org
Please cite: http://dx.doi.org/10.1038/s41592-021-01101-x Nature Methods (2021)

Error: The view command requires a DAA (option -a) input file.
```


## diamond_merge-daa

### Tool Description
Merge DAA files into a single file

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--out                    output file
--in                     input reference file in FASTA format/input DAA files for merge-daa

diamond v2.1.24.178 (C) Max Planck Society for the Advancement of Science, Benjamin J. Buchfink, University of Tuebingen
Documentation, support and updates available at http://www.diamondsearch.org
Please cite: http://dx.doi.org/10.1038/s41592-021-01101-x Nature Methods (2021)

Initializing... Error: Missing parameter: input files (--in)
```


## diamond_getseq

### Tool Description
Retrieve sequences from a DIAMOND database file.

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--out                    output file
--seq                    Space-separated list of sequence numbers to display.

Error: Missing parameter: --db/-d
```


## diamond_dbinfo

### Tool Description
Display information about a DIAMOND database file

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file

diamond v2.1.24.178 (C) Max Planck Society for the Advancement of Science, Benjamin J. Buchfink, University of Tuebingen
Documentation, support and updates available at http://www.diamondsearch.org
Please cite: http://dx.doi.org/10.1038/s41592-021-01101-x Nature Methods (2021)

Error: Missing parameter: database file (--db/-d)
```


## diamond_test

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
HitBuffer stress test
=====================
Threads = 20
  Mode: in-memory (membuf) ... PASSED (352000 hits, checksum ok)
  Mode: disk ... PASSED (352000 hits, checksum ok)
  Result: 2/2 passed
=====================
Queue Stress Test
=================
Hardware threads: 20

Test 1: Many producers (19), one consumer
  Items per producer: 300
  Total items: 5700
  Items sent: 5700
  Items received: 5700
  Expected checksum: 16242150
  Received checksum: 16242150
  Result: PASSED

Test 2: One producer, many consumers (19)
  Total items: 10000
  Items sent: 10000
  Items received: 10000
  Expected checksum: 49995000
  Received checksum: 49995000
  Result: PASSED

=================
Tests passed: 2/2
blastp (default)            [ [32mPassed[0;39m ]
blastp (multithreaded)      [ [32mPassed[0;39m ]
blastp (blocked)            [ [32mPassed[0;39m ]
blastp (more-sensitive)     [ [32mPassed[0;39m ]
blastp (very-sensitive)     [ [32mPassed[0;39m ]
blastp (ultra-sensitive)    [ [32mPassed[0;39m ]
blastp (max-hsps)           [ [32mPassed[0;39m ]
blastp (target-parallel)    [ [32mPassed[0;39m ]
blastp (query-indexed)      [ [32mPassed[0;39m ]
blastp (comp-based-stats 0) [ [32mPassed[0;39m ]
blastp (comp-based-stats 2) [ [32mPassed[0;39m ]
blastp (comp-based-stats 3) [ [32mPassed[0;39m ]
blastp (comp-based-stats 4) [ [32mPassed[0;39m ]
blastp (target seqs)        [ [32mPassed[0;39m ]
blastp (top)                [ [32mPassed[0;39m ]
blastp (evalue)             [ [32mPassed[0;39m ]
blastp (blosum50)           [ [32mPassed[0;39m ]
blastp (pairwise format)    [ [32mPassed[0;39m ]
blastp (XML format)         [ [32mPassed[0;39m ]
blastp (PAF format)         [ [32mPassed[0;39m ]

#Test cases passed: 20/20
diamond v2.1.24.178 (C) Max Planck Society for the Advancement of Science, Benjamin J. Buchfink, University of Tuebingen
Documentation, support and updates available at http://www.diamondsearch.org
Please cite: http://dx.doi.org/10.1038/s41592-021-01101-x Nature Methods (2021)
```


## diamond_makeidx

### Tool Description
Create an index for a DIAMOND database

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--faster                 enable faster mode
--fast                   enable fast mode
--mid-sensitive          enable mid-sensitive mode
--linclust-20            enable mode for linear search at 20% identity
--shapes-6x10            enable mode using 30 seed shapes of weight 10
--shapes-30x10           enable mode using 30 seed shapes of weight 10
--sensitive              enable sensitive mode)
--more-sensitive         enable more sensitive mode
--very-sensitive         enable very sensitive mode
--ultra-sensitive        enable ultra sensitive mode
--shapes                 number of seed shapes (default=all available)

diamond v2.1.24.178 (C) Max Planck Society for the Advancement of Science, Benjamin J. Buchfink, University of Tuebingen
Documentation, support and updates available at http://www.diamondsearch.org
Please cite: http://dx.doi.org/10.1038/s41592-021-01101-x Nature Methods (2021)

Error: Missing parameter: database file (--db/-d).
```


## diamond_greedy-vertex-cover

### Tool Description
Greedy vertex cover clustering using DIAMOND

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--out                    output file
--header                 Use header lines in tabular output format (0/simple/verbose).
--memory-limit           Memory limit in GB (default = 16G)
--member-cover           Minimum coverage% of the cluster member sequence (default=80.0)
--mutual-cover           Minimum mutual coverage% of the cluster member and representative sequence
--connected-component-depthDepth to cluster connected components
--no-reassign            Do not reassign to closest representative
--centroid-out           Output file for centroids
--edges                  Input file for greedy vertex cover
--edge-format            Edge format for greedy vertex cover (default/triplet)
--symmetric              Edges are symmetric

diamond v2.1.24.178 (C) Max Planck Society for the Advancement of Science, Benjamin J. Buchfink, University of Tuebingen
Documentation, support and updates available at http://www.diamondsearch.org
Please cite: http://dx.doi.org/10.1038/s41592-021-01101-x Nature Methods (2021)

Error: Missing parameter: --db/-d
```

