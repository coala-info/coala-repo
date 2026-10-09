# lambda-align2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| lambda-align2_mkindexn | PASS |  |
| lambda-align2_mkindexp | PASS |  |
| lambda-align2_searchn | PASS |  |
| lambda-align2_searchp | PASS |  |

## lambda-align2_mkindexp

### Tool Description
Create an index for protein searches.

### Metadata
- **Docker Image**: biocontainers/lambda-align2:v2.0.0-6-deb_cv1
- **Homepage**: http://seqan.github.io/lambda/
- **Package**: https://anaconda.org/channels/bioconda/packages/lambda-align2/overview
- **Validation**: PASS

### Original Help Text
```text
lambda2 mkindexp - the Local Aligner for Massive Biological DatA
================================================================

SYNOPSIS
    lambda2 mkindexp [OPTIONS] -d DATABASE.fasta [-i INDEX.lambda]

DESCRIPTION
    Lambda is a local aligner optimized for many query sequences and searches
    in protein space. It is compatible to BLAST, but much faster than BLAST
    and many other comparable tools.

    Detailed information is available in the wiki:
    <https://github.com/seqan/lambda/wiki>

    This is the indexer_binary for creating lambda-compatible databases.

OPTIONS
    -h, --help
          Display the help message.
    -hh, --full-help
          Display the help message with advanced options.
    --version
          Display version information.
    --copyright
          Display long copyright information.
    -v, --verbosity INTEGER
          Display more/less diagnostic output during operation: 0 [only
          errors]; 1 [default]; 2 [+run-time, options and statistics]. In
          range [0..2]. Default: 1.

  Input Options:
    -d, --database INPUT_FILE
          Database sequences. Valid filetypes are: .sam[.*], .raw[.*],
          .gbk[.*], .frn[.*], .fq[.*], .fna[.*], .ffn[.*], .fastq[.*],
          .fasta[.*], .faa[.*], .fa[.*], .embl[.*], and .bam, where * is any
          of the following extensions: gz, bz2, and bgzf for transparent
          (de)compression.
    -m, --acc-tax-map INPUT_FILE
          An NCBI or UniProt accession-to-taxid mapping file. Download from
          ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid/ or
          ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/idmapping/
          . Valid filetypes are: .dat[.*] and .accession2taxid[.*], where * is
          any of the following extensions: gz, bz2, and bgzf for transparent
          (de)compression.
    -x, --tax-dump-dir INPUT_DIRECTORY
          A directory that contains nodes.dmp and names.dmp; unzipped from
          ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz

  Output Options:
    -i, --index OUTPUT_DIRECTORY
          The output directory for the index files (defaults to
          "DATABASE.lambda"). Valid filetype is: .lambda.
    --db-index-type STRING
          Suffix array or full-text minute space. One of fm and bifm. Default:
          fm.
    --truncate-ids BOOL
          Truncate IDs at first whitespace. This saves a lot of space and is
          irrelevant for all LAMBDA output formats other than BLAST Pairwise
          (.m0). One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: on.

  Alphabets and Translation:
    -a, --input-alphabet STRING
          Alphabet of the database sequences (specify to override
          auto-detection); if input is Dna, it will be translated. One of
          auto, dna5, and aminoacid. Default: auto.
    -g, --genetic-code INTEGER
          The translation table to use if input is Dna. See
          https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi?mode=c for
          ids (default is generic). Default: 1.
    -r, --alphabet-reduction STRING
          Alphabet Reduction for seeding phase. One of none and murphy10.
          Default: murphy10.

  Algorithm:
    --algorithm STRING
          Algorithm for SA construction (also used for FM; see Memory
          Requirements below!). One of mergesort, quicksortbuckets, quicksort,
          radixsort, and skew7ext. Default: radixsort.
    -t, --threads INTEGER
          number of threads to run concurrently (ignored if a == skew7ext). In
          range [1..200]. Default: 20.
    --tmp-dir OUTPUT_DIRECTORY
          temporary directory used by skew, defaults to working directory.
          Default: /data.

REMARKS
    Please see the wiki (<https://github.com/seqan/lambda/wiki>) for more
    information on which indexes to chose and which algorithms to pick.

    Note that the indexes created are binary and not compatible between
    different CPU endiannesses. Also the on-disk format is still subject to
    change between Lambda versions.

VERSION
    Last update: Jun  8 2019
    lambda2 mkindexp version: 2.0.0
    SeqAn version: 2.4.0

LEGAL
    lambda2 mkindexp Copyright: 2013-2019 Hannes Hauswedell, released under the GNU AGPL v3 (or later); 2016-2019 Knut Reinert and Freie Universität Berlin, released under the 3-clause-BSDL
    SeqAn Copyright: 2006-2015 Knut Reinert, FU-Berlin; released under the 3-clause BSDL.
    In your academic works please cite: Hauswedell et al (2014); doi: 10.1093/bioinformatics/btu439
    For full copyright and/or warranty information see --copyright.
```

## lambda-align2_mkindexn

### Tool Description
Create an index for nucleotide searches.

### Metadata
- **Docker Image**: biocontainers/lambda-align2:v2.0.0-6-deb_cv1
- **Homepage**: http://seqan.github.io/lambda/
- **Package**: https://anaconda.org/channels/bioconda/packages/lambda-align2/overview
- **Validation**: PASS

### Original Help Text
```text
lambda2 mkindexn - the Local Aligner for Massive Biological DatA
================================================================

SYNOPSIS
    lambda2 mkindexn [OPTIONS] -d DATABASE.fasta [-i INDEX.lambda]

DESCRIPTION
    Lambda is a local aligner optimized for many query sequences and searches
    in protein space. It is compatible to BLAST, but much faster than BLAST
    and many other comparable tools.

    Detailed information is available in the wiki:
    <https://github.com/seqan/lambda/wiki>

    This is the indexer_binary for creating lambda-compatible databases.

OPTIONS
    -h, --help
          Display the help message.
    -hh, --full-help
          Display the help message with advanced options.
    --version
          Display version information.
    --copyright
          Display long copyright information.
    -v, --verbosity INTEGER
          Display more/less diagnostic output during operation: 0 [only
          errors]; 1 [default]; 2 [+run-time, options and statistics]. In
          range [0..2]. Default: 1.

  Input Options:
    -d, --database INPUT_FILE
          Database sequences. Valid filetypes are: .sam[.*], .raw[.*],
          .gbk[.*], .frn[.*], .fq[.*], .fna[.*], .ffn[.*], .fastq[.*],
          .fasta[.*], .faa[.*], .fa[.*], .embl[.*], and .bam, where * is any
          of the following extensions: gz, bz2, and bgzf for transparent
          (de)compression.
    -m, --acc-tax-map INPUT_FILE
          An NCBI or UniProt accession-to-taxid mapping file. Download from
          ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid/ or
          ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/idmapping/
          . Valid filetypes are: .dat[.*] and .accession2taxid[.*], where * is
          any of the following extensions: gz, bz2, and bgzf for transparent
          (de)compression.
    -x, --tax-dump-dir INPUT_DIRECTORY
          A directory that contains nodes.dmp and names.dmp; unzipped from
          ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz

  Output Options:
    -i, --index OUTPUT_DIRECTORY
          The output directory for the index files (defaults to
          "DATABASE.lambda"). Valid filetype is: .lambda.
    --db-index-type STRING
          Suffix array or full-text minute space. One of fm and bifm. Default:
          fm.
    --truncate-ids BOOL
          Truncate IDs at first whitespace. This saves a lot of space and is
          irrelevant for all LAMBDA output formats other than BLAST Pairwise
          (.m0). One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: on.

  Algorithm:
    --algorithm STRING
          Algorithm for SA construction (also used for FM; see Memory
          Requirements below!). One of mergesort, quicksortbuckets, quicksort,
          radixsort, and skew7ext. Default: radixsort.
    -t, --threads INTEGER
          number of threads to run concurrently (ignored if a == skew7ext). In
          range [1..200]. Default: 20.
    --tmp-dir OUTPUT_DIRECTORY
          temporary directory used by skew, defaults to working directory.
          Default: /data.

REMARKS
    Please see the wiki (<https://github.com/seqan/lambda/wiki>) for more
    information on which indexes to chose and which algorithms to pick.

    Note that the indexes created are binary and not compatible between
    different CPU endiannesses. Also the on-disk format is still subject to
    change between Lambda versions.

VERSION
    Last update: Jun  8 2019
    lambda2 mkindexn version: 2.0.0
    SeqAn version: 2.4.0

LEGAL
    lambda2 mkindexn Copyright: 2013-2019 Hannes Hauswedell, released under the GNU AGPL v3 (or later); 2016-2019 Knut Reinert and Freie Universität Berlin, released under the 3-clause-BSDL
    SeqAn Copyright: 2006-2015 Knut Reinert, FU-Berlin; released under the 3-clause BSDL.
    In your academic works please cite: Hauswedell et al (2014); doi: 10.1093/bioinformatics/btu439
    For full copyright and/or warranty information see --copyright.
```

## lambda-align2_searchp

### Tool Description
Perform a protein search (BLASTP, BLASTX, TBLASTN, TBLASTX).

### Metadata
- **Docker Image**: biocontainers/lambda-align2:v2.0.0-6-deb_cv1
- **Homepage**: http://seqan.github.io/lambda/
- **Package**: https://anaconda.org/channels/bioconda/packages/lambda-align2/overview
- **Validation**: PASS

### Original Help Text
```text
lambda2 searchp - the Local Aligner for Massive Biological DatA
===============================================================

SYNOPSIS
    lambda2 searchp [OPTIONS] -q QUERY.fasta -i INDEX.lambda [-o output.m8]

DESCRIPTION
    Lambda is a local aligner optimized for many query sequences and searches
    in protein space. It is compatible to BLAST, but much faster than BLAST
    and many other comparable tools.

    Detailed information is available in the wiki:
    <https://github.com/seqan/lambda/wiki>

OPTIONS
    -h, --help
          Display the help message.
    -hh, --full-help
          Display the help message with advanced options.
    --version
          Display version information.
    --copyright
          Display long copyright information.
    -v, --verbosity INTEGER
          Display more/less diagnostic output during operation: 0 [only
          errors]; 1 [default]; 2 [+run-time, options and statistics]. In
          range [0..2]. Default: 1.

  Input Options:
    -q, --query INPUT_FILE
          Query sequences. Valid filetypes are: .sam[.*], .raw[.*], .gbk[.*],
          .frn[.*], .fq[.*], .fna[.*], .ffn[.*], .fastq[.*], .fasta[.*],
          .faa[.*], .fa[.*], .embl[.*], and .bam, where * is any of the
          following extensions: gz, bz2, and bgzf for transparent
          (de)compression.
    -a, --input-alphabet STRING
          Alphabet of the query sequences (specify to override
          auto-detection). Dna sequences will be translated. One of auto,
          dna5, and aminoacid. Default: auto.
    -g, --genetic-code INTEGER
          The translation table to use if input is Dna. See
          https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi?mode=c for
          ids. Default is to use the same table that was used for the index or
          1/CANONICAL if the index was not translated. Default: 0.
    -i, --index INPUT_DIRECTORY
          The database index (created by the 'lambda mkindexp' command). Valid
          filetype is: .lambda.

  Output Options:
    -o, --output OUTPUT_FILE
          File to hold reports on hits (.m* are blastall -m* formats; .m8 is
          tab-seperated, .m9 is tab-seperated with with comments, .m0 is
          pairwise format). Valid filetypes are: .sam[.*], .m9[.*], .m8[.*],
          .m0[.*], and .bam, where * is any of the following extensions: gz,
          bz2, and bgzf for transparent (de)compression. Default: output.m8.
    --output-columns STRING
          Print specified column combination and/or order (.m8 and .m9 outputs
          only); call -oc help for more details. Default: std.
    --percent-identity INTEGER
          Output only matches above this threshold (checked before e-value
          check). In range [0..100]. Default: 0.
    -e, --e-value DOUBLE
          Output only matches that score below this threshold. In range
          [0..100]. Default: 1e-04.
    -n, --num-matches INTEGER
          Print at most this number of matches per query. In range [1..10000].
          Default: 256.
    --sam-with-refheader BOOL
          BAM files require all subject names to be written to the header. For
          SAM this is not required, so Lambda does not automatically do it to
          save space (especially for protein database this is a lot!). If you
          still want them with SAM, e.g. for better BAM compatibility, use
          this option. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: off.
    --sam-bam-seq STRING
          For BLASTX and TBLASTX the matching protein sequence is
          "untranslated" and positions retransformed to the original sequence.
          For BLASTP and TBLASTN there is no DNA sequence so a "*" is written
          to the SEQ column. The matching protein sequence can be written as
          an optional tag, see --sam-bam-tags. If set to uniq than the
          sequence is omitted iff it is identical to the previous match's
          subsequence. One of always, uniq, and never. Default: uniq.
    --sam-bam-tags STRING
          Write the specified optional columns to the SAM/BAM file. Call
          --sam-bam-tags help for more details. Default: AS NM ae ai qf.
    --sam-bam-clip STRING
          Whether to hard-clip or soft-clip the regions beyond the local
          match. Soft-clipping retains the full sequence in the output file,
          but obviously uses more space. One of hard and soft. Default: hard.

  General Options:
    -t, --threads INTEGER
          number of threads to run concurrently. In range [1..200]. Default:
          20.

  Seeding / Filtration:
    --adaptive-seeding BOOL
          Grow the seed if it has too many hits (low complexity filter). One
          of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO. Default: on.
    --seed-length INTEGER
          Length of the seeds. In range [3..50]. Default: 10.
    --seed-offset INTEGER
          Offset for seeding (if unset = seed-length/2). In range [1..50].
          Default: 5.
    --seed-delta INTEGER
          maximum seed distance. In range [0..1]. Default: 1.
    --seed-delta-increases-length BOOL
          Seed delta increases the min. seed length (for affected seeds). One
          of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO. Default: off.
    --seed-half-exact BOOL
          Allow errors only in second half of seed. One of 1, ON, TRUE, T,
          YES, 0, OFF, FALSE, F, and NO. Default: on.

  Miscellaneous Heuristics:
    --pre-scoring INTEGER
          evaluate score of a region NUM times the size of the seed before
          extension (0 -> no pre-scoring, 1 -> evaluate seed, n-> area around
          seed, as well; default = 1 if no reduction is used). In range
          [1..10]. Default: 2.
    --pre-scoring-threshold DOUBLE
          minimum average score per position in pre-scoring region. In range
          [0..20]. Default: 2.
    --filter-putative-duplicates BOOL
          filter hits that will likely duplicate a match already found. One of
          1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO. Default: on.
    --filter-putative-abundant BOOL
          If the maximum number of matches per query are found already, stop
          searching if the remaining realm looks unfeasible. One of 1, ON,
          TRUE, T, YES, 0, OFF, FALSE, F, and NO. Default: on.
    --merge-putative-siblings BOOL
          Merge seed from one region, stop searching if the remaining realm
          looks unfeasable. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and
          NO. Default: on.

  Scoring:
    -s, --scoring-scheme INTEGER
          use '45' for Blosum45; '62' for Blosum62 (default); '80' for
          Blosum80. Default: 62.
    --score-gap INTEGER
          Score per gap character. In range [-1000..1000]. Default: -1.
    --score-gap-open INTEGER
          Additional cost for opening gap. In range [-1000..1000]. Default:
          -11.

  Extension:
    -x, --x-drop INTEGER
          Stop Banded extension if score x below the maximum seen (-1 means no
          xdrop). In range [-1..1000]. Default: 30.
    -b, --band INTEGER
          Size of the DP-band used in extension (-3 means log2 of query
          length; -2 means sqrt of query length; -1 means full dp; n means
          band of size 2n+1) In range [-3..1000]. Default: -3.
    -m, --extension-mode STRING
          Choice of extension algorithms. One of auto, xdrop, fullSerial, and
          fullSIMD. Default: auto.

TUNING
    Tuning the seeding parameters and (de)activating alphabet reduction has a
    strong influence on both speed and sensitivity. We recommend the following
    alternative profiles for protein searches:

    fast (high similarity): --seed-delta-increases-length on

    sensitive (lower similarity): --seed-offset 3

    For further information see the wiki:
    <https://github.com/seqan/lambda/wiki>

VERSION
    Last update: Jun  8 2019
    lambda2 searchp version: 2.0.0
    SeqAn version: 2.4.0

LEGAL
    lambda2 searchp Copyright: 2013-2019 Hannes Hauswedell, released under the GNU AGPL v3 (or later); 2016-2019 Knut Reinert and Freie Universität Berlin, released under the 3-clause-BSDL
    SeqAn Copyright: 2006-2015 Knut Reinert, FU-Berlin; released under the 3-clause BSDL.
    In your academic works please cite: Hauswedell et al (2014); doi: 10.1093/bioinformatics/btu439
    For full copyright and/or warranty information see --copyright.
```

## lambda-align2_searchn

### Tool Description
Perform a nucleotide search (BLASTN, MEGABLAST).

### Metadata
- **Docker Image**: biocontainers/lambda-align2:v2.0.0-6-deb_cv1
- **Homepage**: http://seqan.github.io/lambda/
- **Package**: https://anaconda.org/channels/bioconda/packages/lambda-align2/overview
- **Validation**: PASS

### Original Help Text
```text
lambda2 searchn - the Local Aligner for Massive Biological DatA
===============================================================

SYNOPSIS
    lambda2 searchn [OPTIONS] -q QUERY.fasta -i INDEX.lambda [-o output.m8]

DESCRIPTION
    Lambda is a local aligner optimized for many query sequences and searches
    in protein space. It is compatible to BLAST, but much faster than BLAST
    and many other comparable tools.

    Detailed information is available in the wiki:
    <https://github.com/seqan/lambda/wiki>

OPTIONS
    -h, --help
          Display the help message.
    -hh, --full-help
          Display the help message with advanced options.
    --version
          Display version information.
    --copyright
          Display long copyright information.
    -v, --verbosity INTEGER
          Display more/less diagnostic output during operation: 0 [only
          errors]; 1 [default]; 2 [+run-time, options and statistics]. In
          range [0..2]. Default: 1.

  Input Options:
    -q, --query INPUT_FILE
          Query sequences. Valid filetypes are: .sam[.*], .raw[.*], .gbk[.*],
          .frn[.*], .fq[.*], .fna[.*], .ffn[.*], .fastq[.*], .fasta[.*],
          .faa[.*], .fa[.*], .embl[.*], and .bam, where * is any of the
          following extensions: gz, bz2, and bgzf for transparent
          (de)compression.
    -i, --index INPUT_DIRECTORY
          The database index (created by the 'lambda mkindexn' command). Valid
          filetype is: .lambda.

  Output Options:
    -o, --output OUTPUT_FILE
          File to hold reports on hits (.m* are blastall -m* formats; .m8 is
          tab-seperated, .m9 is tab-seperated with with comments, .m0 is
          pairwise format). Valid filetypes are: .sam[.*], .m9[.*], .m8[.*],
          .m0[.*], and .bam, where * is any of the following extensions: gz,
          bz2, and bgzf for transparent (de)compression. Default: output.m8.
    --output-columns STRING
          Print specified column combination and/or order (.m8 and .m9 outputs
          only); call -oc help for more details. Default: std.
    --percent-identity INTEGER
          Output only matches above this threshold (checked before e-value
          check). In range [0..100]. Default: 0.
    -e, --e-value DOUBLE
          Output only matches that score below this threshold. In range
          [0..100]. Default: 1e-04.
    -n, --num-matches INTEGER
          Print at most this number of matches per query. In range [1..10000].
          Default: 256.
    --sam-with-refheader BOOL
          BAM files require all subject names to be written to the header. For
          SAM this is not required, so Lambda does not automatically do it to
          save space (especially for protein database this is a lot!). If you
          still want them with SAM, e.g. for better BAM compatibility, use
          this option. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: off.
    --sam-bam-seq STRING
          Write matching DNA subsequence into SAM/BAM file. If set to uniq
          than the sequence is omitted iff it is identical to the previous
          match's subsequence. One of always, uniq, and never. Default: uniq.
    --sam-bam-tags STRING
          Write the specified optional columns to the SAM/BAM file. Call
          --sam-bam-tags help for more details. Default: AS NM ae ai qf.
    --sam-bam-clip STRING
          Whether to hard-clip or soft-clip the regions beyond the local
          match. Soft-clipping retains the full sequence in the output file,
          but obviously uses more space. One of hard and soft. Default: hard.

  General Options:
    -t, --threads INTEGER
          number of threads to run concurrently. In range [1..200]. Default:
          20.

  Seeding / Filtration:
    --adaptive-seeding BOOL
          Grow the seed if it has too many hits (low complexity filter). One
          of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO. Default: off.
    --seed-length INTEGER
          Length of the seeds. In range [3..50]. Default: 14.
    --seed-offset INTEGER
          Offset for seeding (if unset = seed-length/2). In range [1..50].
          Default: 7.
    --seed-delta INTEGER
          maximum seed distance. In range [0..1]. Default: 1.
    --seed-delta-increases-length BOOL
          Seed delta increases the min. seed length (for affected seeds). One
          of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO. Default: off.
    --seed-half-exact BOOL
          Allow errors only in second half of seed. One of 1, ON, TRUE, T,
          YES, 0, OFF, FALSE, F, and NO. Default: on.

  Miscellaneous Heuristics:
    --pre-scoring INTEGER
          evaluate score of a region NUM times the size of the seed before
          extension (0 -> no pre-scoring, 1 -> evaluate seed, n-> area around
          seed, as well; default = 1 if no reduction is used). In range
          [1..10]. Default: 2.
    --pre-scoring-threshold DOUBLE
          minimum average score per position in pre-scoring region. In range
          [0..20]. Default: 2.
    --filter-putative-duplicates BOOL
          filter hits that will likely duplicate a match already found. One of
          1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO. Default: on.
    --filter-putative-abundant BOOL
          If the maximum number of matches per query are found already, stop
          searching if the remaining realm looks unfeasible. One of 1, ON,
          TRUE, T, YES, 0, OFF, FALSE, F, and NO. Default: on.
    --merge-putative-siblings BOOL
          Merge seed from one region, stop searching if the remaining realm
          looks unfeasable. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and
          NO. Default: on.

  Scoring:
    --score-gap INTEGER
          Score per gap character. In range [-1000..1000]. Default: -2.
    --score-gap-open INTEGER
          Additional cost for opening gap. In range [-1000..1000]. Default:
          -5.
    --score-match INTEGER
          Match score [only BLASTN]) In range [-1000..1000]. Default: 2.
    --score-mismatch INTEGER
          Mismatch score [only BLASTN] In range [-1000..1000]. Default: -3.

  Extension:
    -x, --x-drop INTEGER
          Stop Banded extension if score x below the maximum seen (-1 means no
          xdrop). In range [-1..1000]. Default: 30.
    -b, --band INTEGER
          Size of the DP-band used in extension (-3 means log2 of query
          length; -2 means sqrt of query length; -1 means full dp; n means
          band of size 2n+1) In range [-3..1000]. Default: -3.
    -m, --extension-mode STRING
          Choice of extension algorithms. One of auto, xdrop, fullSerial, and
          fullSIMD. Default: auto.

TUNING
    Tuning the seeding parameters and (de)activating alphabet reduction has a
    strong influence on both speed and sensitivity. We recommend the following
    alternative profiles for protein searches:

    fast (high similarity): --seed-delta-increases-length on

    sensitive (lower similarity): --seed-offset 3

    For further information see the wiki:
    <https://github.com/seqan/lambda/wiki>

VERSION
    Last update: Jun  8 2019
    lambda2 searchn version: 2.0.0
    SeqAn version: 2.4.0

LEGAL
    lambda2 searchn Copyright: 2013-2019 Hannes Hauswedell, released under the GNU AGPL v3 (or later); 2016-2019 Knut Reinert and Freie Universität Berlin, released under the 3-clause-BSDL
    SeqAn Copyright: 2006-2015 Knut Reinert, FU-Berlin; released under the 3-clause BSDL.
    In your academic works please cite: Hauswedell et al (2014); doi: 10.1093/bioinformatics/btu439
    For full copyright and/or warranty information see --copyright.
```

