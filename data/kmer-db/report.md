# kmer-db CWL Generation Report

## kmer-db_build

### Tool Description
Building a database

### Metadata
- **Docker Image**: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/kmer-db
- **Package**: https://anaconda.org/channels/bioconda/packages/kmer-db/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kmer-db/overview
- **Total Downloads**: 16.3K
- **Last updated**: 2025-07-30
- **GitHub**: https://github.com/refresh-bio/kmer-db
- **Stars**: N/A
### Original Help Text
```text
Kmer-db version 2.3.1 (20.12.2024)
S. Deorowicz, A. Gudys, M. Dlugosz, M. Kokot, and A. Danek (c) 2018

Analysis started at Wed Feb 25 07:44:18 2026

ERROR: Incorrect usage
See detailed instructions below

Building a database:
    kmer-db build [-k <kmer-length>] [-f <fraction>] [-multisample-fasta] [-extend] [-alphabet<alphabet_type>] [-preserve-strand] [-t <threads>] <samples> <database>
    kmer-db build -from-kmers [-f <fraction>] [-extend] [-t <threads>] <samples> <database>
    kmer-db build -from-minhash [-extend] [-t <threads>] <samples> <database>

Positional arguments:
    samples (input) - one of the following:
        a. FASTA file (fa, fna, fasta, fa.gz, fna.gz, fasta.gz) with one or multiple (-multisample-fasta) samples
        b. file with list of samples in one of the formats: 
            * FASTA genomes/reads (default),
            * KMC k-mers (-from-kmers),
            * minhashed k-mers (-from-minhash)
    database (output) - file with generated k-mer database,
Options: 
    -k <kmer_length> - length of k-mers (default: 18, maximum depends on the alphabet - 31 for default nt)
    -f <fraction> - fraction of all k-mers to be accepted by the minhash filter (default: 1)
    -multisample-fasta - each sequence in a FASTA file is treated as a separate sample
    -extend - extend the existing database with new samples
    -alphabet - alphabet:
        * nt (4 symbol nucleotide with indistinguishable T/U; default)
        * aa (20 symbol amino acid)
        * aa12_mmseqs (amino acid reduced to 12 symbols as in MMseqs: AST,C,DN,EQ,FY,G,H,IV,KR,LM,P,W
        * aa11_diamond (amino acid reduced to 11 symbols as in Diamond: KREDQN,C,G,H,ILV,M,F,Y,W,P,STA
        * aa6_dayhoff (amino acid reduced to 6 symbols as proposed by Dayhoff: STPAG,NDEQ,HRK,MILV,FYW,C
    -preserve-strand - preserve strand instead of taking canonical k-mers (allowed only in nt alphabet; default: off)
    -t <threads> - number of threads (default: number of available cores)
```


## kmer-db_all2all

### Tool Description
Counting common k-mers for all the samples in the database

### Metadata
- **Docker Image**: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/kmer-db
- **Package**: https://anaconda.org/channels/bioconda/packages/kmer-db/overview
- **Validation**: PASS

### Original Help Text
```text
Kmer-db version 2.3.1 (20.12.2024)
S. Deorowicz, A. Gudys, M. Dlugosz, M. Kokot, and A. Danek (c) 2018

Analysis started at Wed Feb 25 07:44:40 2026

ERROR: Incorrect usage
See detailed instructions below

Counting common k-mers for all the samples in the database:
    kmer-db all2all [-buffer <size_mb>] [-t <threads>] [-sparse [-min [<criterion>:]<value>]* [-max [<criterion>:]<value>]* ] <database> <common_table>
Positional arguments:
    database (input) - k-mer database file
    common_table (output) - comma-separated table with number of common k-mers
Options:
    -buffer <size_mb> - size of cache buffer in megabytes
                      (use L3 size for Intel CPUs and L2 for AMD to maximize performance; default: 8)
    -t <threads> - number of threads (default: number of available cores)
    -sparse - produce sparse matrix as output
    -min [<criterion>:]<value> - retains elements with <criterion> greater than or equal to <value> (see details below)
    -max [<criterion>:]<value> - retains elements with <criterion> lower than or equal to <value> (see details below)
<criterion> can be num-kmers (number of common k-mers) or one of the distance/similarity measures: jaccard, min, max, cosine, mash, ani, ani-shorder.
No <criterion> indicates num-kmers. Multiple filters can be combined.
```


## kmer-db_all2all-sp

### Tool Description
Counting common k-mers for all the samples in the database (sparse computation)

### Metadata
- **Docker Image**: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/kmer-db
- **Package**: https://anaconda.org/channels/bioconda/packages/kmer-db/overview
- **Validation**: PASS

### Original Help Text
```text
Kmer-db version 2.3.1 (20.12.2024)
S. Deorowicz, A. Gudys, M. Dlugosz, M. Kokot, and A. Danek (c) 2018

Analysis started at Wed Feb 25 07:44:59 2026

ERROR: Incorrect usage
See detailed instructions below

Counting common k-mers for all the samples in the database (sparse computation):
    kmer-db all2all-sp [-buffer <size_mb>] [-t <threads>] [-min [<criterion>:]<value>]* [-max [<criterion>:]<value>]* 
 <database> <common_table>

Positional arguments:
    database (input) - k-mer database file
    common_table (output) - comma-separated table with number of common k-mers
Options:
    -buffer <size_mb> - size of cache buffer in megabytes
                      (use L3 size for Intel CPUs and L2 for AMD to maximize performance; default: 8)
    -t <threads> - number of threads (default: number of available cores)
    -min [<criterion>:]<value> - retains elements with <criterion> greater than or equal to <value> (see details below)
    -max [<criterion>:]<value> - retains elements with <criterion> lower than or equal to <value> (see details below)
    -sample-rows [<criterion>:]<count> - retains <count> elements in every row using one of the strategies:
        (i) random selection (no <criterion>),
       (ii) the best elements with respect to <criterion>
<criterion> can be num-kmers (number of common k-mers) or one of the distance/similarity measures: jaccard, min, max, cosine, mash, ani, ani-shorder.
No <criterion> indicates num-kmers (filtering) or random elements selection (sampling). Multiple filters can be combined.
```


## kmer-db_all2all-parts

### Tool Description
Counting common k-mers for all the samples in the database parts (sparse computation)

### Metadata
- **Docker Image**: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/kmer-db
- **Package**: https://anaconda.org/channels/bioconda/packages/kmer-db/overview
- **Validation**: PASS

### Original Help Text
```text
Kmer-db version 2.3.1 (20.12.2024)
S. Deorowicz, A. Gudys, M. Dlugosz, M. Kokot, and A. Danek (c) 2018

Analysis started at Wed Feb 25 07:45:20 2026

ERROR: Incorrect usage
See detailed instructions below

Counting common k-mers for all the samples in the database parts (sparse computation):
    kmer-db all2all-parts [-buffer <size_mb>] [-t <threads>] [-min [<criterion>:]<value>]* [-max [<criterion>:]<value>]*  <db_list> <common_table>

Positional arguments:
    db_list (input) - file containing list of database file names
    common_table (output) - CSV table with number of common k-mers
Options:
    -buffer <size_mb> - size of cache buffer in megabytes
                      (use L3 size for Intel CPUs and L2 for AMD to maximize performance; default: 8)
    -t <threads> - number of threads (default: number of available cores)
    -min [<criterion>:]<value> - retains elements with <criterion> greater than or equal to <value> (see details below)
    -max [<criterion>:]<value> - retains elements with <criterion> lower than or equal to <value> (see details below)
    -sample-rows [<criterion>:]<count> - retains <count> elements in every row using one of the strategies:
        (i) random selection (no <criterion>),
       (ii) the best elements with respect to <criterion>
<criterion> can be num-kmers (number of common k-mers) or one of the distance/similarity measures: jaccard, min, max, cosine, mash, ani, ani-shorder.
No <criterion> indicates num-kmers (filtering) or random elements selection (sampling). Multiple filters can be combined.
```


## kmer-db_new2all

### Tool Description
Counting common kmers between set of new samples and all the samples in the database

### Metadata
- **Docker Image**: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/kmer-db
- **Package**: https://anaconda.org/channels/bioconda/packages/kmer-db/overview
- **Validation**: PASS

### Original Help Text
```text
Kmer-db version 2.3.1 (20.12.2024)
S. Deorowicz, A. Gudys, M. Dlugosz, M. Kokot, and A. Danek (c) 2018

Analysis started at Wed Feb 25 07:45:40 2026

ERROR: Incorrect usage
See detailed instructions below

Counting common kmers between set of new samples and all the samples in the database:
    kmer-db new2all [-multisample-fasta | -from-kmers | -from-minhash] [-sparse [-min [<criterion>:]<value>]* [-max [<criterion>:]<value>]* ]  [-t <threads>] <database> <samples> <common_table>

Positional arguments:
    database (input) - k-mer database file
    samples (input) - one of the following : 
        a. FASTA file (fa, fna, fasta, fa.gz, fna.gz, fasta.gz) with one or multiple (-multisample-fasta) samples
        b. file with list of samples in one of the formats: 
            * FASTA genomes/reads (default),
            * KMC k-mers (-from-kmers),
            * minhashed k-mers (-from-minhash)
    common_table (output) - CSV table with number of common k-mers
Options:
    -multisample-fasta - each sequence in a FASTA file is treated as a separate sample
    -t <threads> - number of threads (default: number of available cores)
    -sparse - outputs a sparse matrix
    -min [<criterion>:]<value> - retains elements with <criterion> greater than or equal to <value> (see details below)
    -max [<criterion>:]<value> - retains elements with <criterion> lower than or equal to <value> (see details below)
<criterion> can be num-kmers (number of common k-mers) or one of the distance/similarity measures: jaccard, min, max, cosine, mash, ani, ani-shorder.
No <criterion> indicates num-kmers. Multiple filters can be combined.
```


## kmer-db_one2all

### Tool Description
Counting common kmers between single sample and all the samples in the database

### Metadata
- **Docker Image**: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/kmer-db
- **Package**: https://anaconda.org/channels/bioconda/packages/kmer-db/overview
- **Validation**: PASS

### Original Help Text
```text
Kmer-db version 2.3.1 (20.12.2024)
S. Deorowicz, A. Gudys, M. Dlugosz, M. Kokot, and A. Danek (c) 2018

Analysis started at Wed Feb 25 07:46:02 2026

ERROR: Incorrect usage
See detailed instructions below

Counting common kmers between single sample and all the samples in the database:
    kmer-db one2all [-from-kmers | -from-minhash] <database> <sample> <common_table>

Positional arguments:
    database (input) - k-mer database file.
    sample (input) - query sample in one of the supported formats:
                     FASTA genomes/reads (default), KMC k-mers (-from-kmers), or minhashed k-mers (-from-minhash), 
    common_table (output) - CSV table with number of common k-mers.
```


## kmer-db_distance

### Tool Description
Calculating similarities/distances on the basis of common k-mers

### Metadata
- **Docker Image**: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/kmer-db
- **Package**: https://anaconda.org/channels/bioconda/packages/kmer-db/overview
- **Validation**: PASS

### Original Help Text
```text
Kmer-db version 2.3.1 (20.12.2024)
S. Deorowicz, A. Gudys, M. Dlugosz, M. Kokot, and A. Danek (c) 2018

Analysis started at Wed Feb 25 07:46:22 2026

ERROR: Incorrect usage
See detailed instructions below

Calculating similarities/distances on the basis of common k-mers:
    kmer-db distance <measure> [-sparse [-min[<criterion>:]<value>]* [-max [<criterion>:]<value>]* ] <common_table> <output_table>

Positional arguments:
    measure - name of the similarity/distance measure to be calculated, one of the following:
               jaccard, min, max, cosine, mash, ani, ani-shorter.
    common_table (input) - CSV table with a number of common k-mers
    output_table (output) - CSV table with calculated distances
Options:
    -phylip-out - store output distance matrix in a Phylip format
    -sparse - outputs a sparse matrix (only for dense input matrices - sparse input always produce sparse output)
    -min [<criterion>:]<value> - retains elements with <criterion> greater than or equal to <value> (see details below)
    -max [<criterion>:]<value> - retains elements with <criterion> lower than or equal to <value> (see details below)
<criterion> can be num-kmers (number of common k-mers) or one of the distance/similarity measures: jaccard, min, max, cosine, mash, ani, ani-shorder.
If no criterion is specified, measure argument is used by default. Multiple filters can be combined.
```


## kmer-db_minhash

### Tool Description
Storing minhashed k-mers

### Metadata
- **Docker Image**: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/kmer-db
- **Package**: https://anaconda.org/channels/bioconda/packages/kmer-db/overview
- **Validation**: PASS

### Original Help Text
```text
Kmer-db version 2.3.1 (20.12.2024)
S. Deorowicz, A. Gudys, M. Dlugosz, M. Kokot, and A. Danek (c) 2018

Storing minhashed k-mers:
    kmer-db minhash [-f <fraction> ] [-k <kmer_length>] [-multisample-fasta] [-alphabet<alphabet_type>] [-preserve-strand] <samples>
    kmer-db minhash -from-kmers [-f <fraction>] <samples>

Positional arguments:
    samples (input) - one of the following : 
        a. FASTA file (fa, fna, fasta, fa.gz, fna.gz, fasta.gz) with one or multiple (-multisample-fasta) samples
        b. file with list of samples in one of the formats: 
            * FASTA genomes/reads (default),
            * KMC k-mers (-from-kmers),

Options:
    -f <fraction> - fraction of all k-mers to be accepted by the minhash filter (default: 0.01)
    -k <kmer_length> - length of k-mers (default: 18, maximum: 30)
    -multisample-fasta - each sequence in a FASTA file is treated as a separate sample

    -alphabet - alphabet:
        * nt (4 symbol nucleotide with indistinguishable T/U; default)
        * aa (20 symbol amino acid)
        * aa12_mmseqs (amino acid reduced to 12 symbols as in MMseqs: AST,C,DN,EQ,FY,G,H,IV,KR,LM,P,W
        * aa11_diamond (amino acid reduced to 11 symbols as in Diamond: KREDQN,C,G,H,ILV,M,F,Y,W,P,STA
        * aa6_dayhoff (amino acid reduced to 6 symbols as proposed by Dayhoff: STPAG,NDEQ,HRK,MILV,FYW,C
    -preserve-strand - preserve strand instead of taking canonical k-mers (allowed only in nt alphabet; default: off)

For each sample from the list, a binary file with *.minhash* extension containing filtered k-mers is created
```


## Metadata
- **Skill**: generated
