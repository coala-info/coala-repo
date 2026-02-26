# merfin CWL Generation Report

## merfin_filter

### Tool Description
Predict the kmer consequences of variant calls <input.vcf> given the consensus sequence <seq.fasta> and lookup the k-mer multiplicity in the consensus sequence <seq.meryl> and in the reads <read.meryl>.

### Metadata
- **Docker Image**: quay.io/biocontainers/merfin:1.0--h9948957_3
- **Homepage**: https://github.com/arangrhie/merfin
- **Package**: https://anaconda.org/channels/bioconda/packages/merfin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/merfin/overview
- **Total Downloads**: 3.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/arangrhie/merfin
- **Stars**: N/A
### Original Help Text
```text
usage: merfin <report-type>            \
         -sequence <seq.fasta>     \
         -readmers <read.meryl>    \
         -peak     <haploid_peak>  \
         -prob     <lookup_table>  \
         -vcf      <input.vcf>     \
         -output   <output>        

  Predict the kmer consequences of variant calls <input.vcf> given the consensus sequence <seq.fasta>
  and lookup the k-mer multiplicity in the consensus sequence <seq.meryl> and in the reads <read.meryl>.

  Input -sequence and -vcf files can be FASTA or FASTQ; uncompressed, gz, bz2 or xz compressed

  Each readmers can be filtered by value.  More advanced filtering
  requires a new database to be constructed using meryl.
    -min     m     Ignore kmers with value below m
    -max     m     Ignore kmers with value above m
    -threads t     Multithreading for meryl lookup table construction, dump and hist.

  Memory usage can be limited, within reason, by sacrificing kmer lookup
  speed.  If the lookup table requires more memory than allowed, the program
  exits with an error.
    -memory  m     Don't use more than m GB memory for loading mers

  For k* based evaluation and polishing, -peak is required with optional -prob.
    -peak    m     Required input to hard set copy 1 and infer multiplicity to copy number (recommended).
    -prob    file  Optional input vector of probabilities. Adjust multiplicity to copy number
                   in case both -prob and -peak are provided, -prob takes higher priority
                   than -peak for multiplicity listed in the vector table.

  By default, <seq.fasta>.meryl will be generated unless -seqmers is provided.
    -seqmers seq.meryl  Optional input for pre-built sequence meryl db

  Exactly one report type must be specified.


  -filter
   Filter variants within distance k and their combinations by missing k-mers.
   Assumes the reference (-sequence) is from a different individual.
   Required: -sequence, -readmers, -vcf, and -output
   Optional: -comb <N>  set the max N of combinations of variants to be evaluated (default: 15)
             -nosplit   without this options combinations larger than N are split
             -debug     output a debug log, into <output>.THREAD_ID.debug.gz

   Output: <output>.filter.vcf : variants chosen.


  -polish
   Score each variant, or variants within distance k and their combinations by k*.
   Assumes the reference (-sequence) is from the same individual.

   Required: -sequence, -readmers, -peak, -vcf, and -output
   Optional: -comb <N>    set the max N of combinations of variants to be evaluated (default: 15)
             -nosplit     without this options combinations larger than N are split
             -prob <file> use probabilities to adjust multiplicity to copy number (recommended)
             -debug       output a debug log, into <output>.THREAD_ID.debug.gz

   Output: <output>.polish.vcf : variants chosen.
     use bcftools view -Oz <output>.polish.vcf and bcftools consensus -H 1 -f <seq.fata> to polish.
     first ALT in heterozygous alleles are usually better supported by avg. |k*|.


  -hist
   Generate a 0-centered k* histogram for sequences in <input.fasta>.
     Positive k* values are expected collapsed copies.
     Negative k* values are expected expanded  copies.
     Closer to 0 means the expected and found k-mers are well balenced, 1:1.

   Required: -sequence, -readmers, -peak, and -output.
   Optional: -prob <file>  use probabilities to adjust multiplicity to copy number (recommended)

   Output: k* <tab> frequency
           Reports QV at the end, in stderr.


  -dump
   Dump readK, asmK, and k* per bases (k-mers) in <input.fasta>.

   Required: -sequence, -readmers, -peak, and -output
   Optional: -skipMissing  skip the missing kmer sites to be printed
             -prob <file>  use probabilities to adjust multiplicity to copy number (recommended)

   Output: seqName <tab> seqPos <tab> readK <tab> asmK <tab> k*
      seqName    - name of the sequence this kmer is from
      seqPos     - start position (0-based) of the kmer in the sequence
      readK      - normalized read copies (read multiplicity / peak)
      asmK       - assembly copies as found in <seq.meryl>
      k*         - 0-centered k* value


  -completeness
   Compute kmer completeness using expected copy numbers for all kmers.

   Required: -seqmers (or -sequence), -readmers, -peak
   Optional: -prob <file>  use probabilities to adjust multiplicity to copy number (recommended)

   Output: total kmers in reads, number of kmers under the expected copy number, and completeness


  Optional output from -debug in -filter and -polish:
   <output>.THREAD_ID.debug.gz : some useful info for debugging.
      seqName <tab> varMerStart <tab> varMerEnd <tab> varMerSeq <tab> score <tab> path
      varMerID                - unique numbering, starting from 0
      varMerRange             - seqName:start-end. position (0-based) of the variant (s),
                                including sequences upstream and downstream of k-1 bp
      varMerSeq               - combination of variant sequence to evalute
      numMissings             - total number of missing kmers
      min k*                  - minimum of all |k*| for non-missing kmers. -1 when all kmers are missing.
      max k*                  - maximum of all |k*| for non-missing kmers. -1 when all kmers are missing.
      median k*               - median  of all |k*| for non-missing kmers. -1 when all kmers are missing.
      avg k*                  - average of all |k*| for non-missing kmers. -1 when all kmers are missing.
      avg ref-alt k*          - difference between reference and alternate average k*.
      delta kmer multiplicity - cumulative sum of kmer multiplicity variation.
                                positive values imply recovered kmers, while
                                negative values imply overrepresented kmers introduced.
      record                  - vcf record with <tab> replaced to <space>.
                                only non-reference alleles are printed with GT being 1/1.



Unknown option 'filter'.
Unknown option '--help'.
No haploid peak (-peak) supplied.
No report type (-filter, -polish, -hist, -dump, -completeness) supplied.
No read meryl database (-readmers) supplied.
```


## merfin_polish

### Tool Description
Predict the kmer consequences of variant calls <input.vcf> given the consensus sequence <seq.fasta> and lookup the k-mer multiplicity in the consensus sequence <seq.meryl> and in the reads <read.meryl>.

### Metadata
- **Docker Image**: quay.io/biocontainers/merfin:1.0--h9948957_3
- **Homepage**: https://github.com/arangrhie/merfin
- **Package**: https://anaconda.org/channels/bioconda/packages/merfin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: merfin <report-type>            \
         -sequence <seq.fasta>     \
         -readmers <read.meryl>    \
         -peak     <haploid_peak>  \
         -prob     <lookup_table>  \
         -vcf      <input.vcf>     \
         -output   <output>        

  Predict the kmer consequences of variant calls <input.vcf> given the consensus sequence <seq.fasta>
  and lookup the k-mer multiplicity in the consensus sequence <seq.meryl> and in the reads <read.meryl>.

  Input -sequence and -vcf files can be FASTA or FASTQ; uncompressed, gz, bz2 or xz compressed

  Each readmers can be filtered by value.  More advanced filtering
  requires a new database to be constructed using meryl.
    -min     m     Ignore kmers with value below m
    -max     m     Ignore kmers with value above m
    -threads t     Multithreading for meryl lookup table construction, dump and hist.

  Memory usage can be limited, within reason, by sacrificing kmer lookup
  speed.  If the lookup table requires more memory than allowed, the program
  exits with an error.
    -memory  m     Don't use more than m GB memory for loading mers

  For k* based evaluation and polishing, -peak is required with optional -prob.
    -peak    m     Required input to hard set copy 1 and infer multiplicity to copy number (recommended).
    -prob    file  Optional input vector of probabilities. Adjust multiplicity to copy number
                   in case both -prob and -peak are provided, -prob takes higher priority
                   than -peak for multiplicity listed in the vector table.

  By default, <seq.fasta>.meryl will be generated unless -seqmers is provided.
    -seqmers seq.meryl  Optional input for pre-built sequence meryl db

  Exactly one report type must be specified.


  -filter
   Filter variants within distance k and their combinations by missing k-mers.
   Assumes the reference (-sequence) is from a different individual.
   Required: -sequence, -readmers, -vcf, and -output
   Optional: -comb <N>  set the max N of combinations of variants to be evaluated (default: 15)
             -nosplit   without this options combinations larger than N are split
             -debug     output a debug log, into <output>.THREAD_ID.debug.gz

   Output: <output>.filter.vcf : variants chosen.


  -polish
   Score each variant, or variants within distance k and their combinations by k*.
   Assumes the reference (-sequence) is from the same individual.

   Required: -sequence, -readmers, -peak, -vcf, and -output
   Optional: -comb <N>    set the max N of combinations of variants to be evaluated (default: 15)
             -nosplit     without this options combinations larger than N are split
             -prob <file> use probabilities to adjust multiplicity to copy number (recommended)
             -debug       output a debug log, into <output>.THREAD_ID.debug.gz

   Output: <output>.polish.vcf : variants chosen.
     use bcftools view -Oz <output>.polish.vcf and bcftools consensus -H 1 -f <seq.fata> to polish.
     first ALT in heterozygous alleles are usually better supported by avg. |k*|.


  -hist
   Generate a 0-centered k* histogram for sequences in <input.fasta>.
     Positive k* values are expected collapsed copies.
     Negative k* values are expected expanded  copies.
     Closer to 0 means the expected and found k-mers are well balenced, 1:1.

   Required: -sequence, -readmers, -peak, and -output.
   Optional: -prob <file>  use probabilities to adjust multiplicity to copy number (recommended)

   Output: k* <tab> frequency
           Reports QV at the end, in stderr.


  -dump
   Dump readK, asmK, and k* per bases (k-mers) in <input.fasta>.

   Required: -sequence, -readmers, -peak, and -output
   Optional: -skipMissing  skip the missing kmer sites to be printed
             -prob <file>  use probabilities to adjust multiplicity to copy number (recommended)

   Output: seqName <tab> seqPos <tab> readK <tab> asmK <tab> k*
      seqName    - name of the sequence this kmer is from
      seqPos     - start position (0-based) of the kmer in the sequence
      readK      - normalized read copies (read multiplicity / peak)
      asmK       - assembly copies as found in <seq.meryl>
      k*         - 0-centered k* value


  -completeness
   Compute kmer completeness using expected copy numbers for all kmers.

   Required: -seqmers (or -sequence), -readmers, -peak
   Optional: -prob <file>  use probabilities to adjust multiplicity to copy number (recommended)

   Output: total kmers in reads, number of kmers under the expected copy number, and completeness


  Optional output from -debug in -filter and -polish:
   <output>.THREAD_ID.debug.gz : some useful info for debugging.
      seqName <tab> varMerStart <tab> varMerEnd <tab> varMerSeq <tab> score <tab> path
      varMerID                - unique numbering, starting from 0
      varMerRange             - seqName:start-end. position (0-based) of the variant (s),
                                including sequences upstream and downstream of k-1 bp
      varMerSeq               - combination of variant sequence to evalute
      numMissings             - total number of missing kmers
      min k*                  - minimum of all |k*| for non-missing kmers. -1 when all kmers are missing.
      max k*                  - maximum of all |k*| for non-missing kmers. -1 when all kmers are missing.
      median k*               - median  of all |k*| for non-missing kmers. -1 when all kmers are missing.
      avg k*                  - average of all |k*| for non-missing kmers. -1 when all kmers are missing.
      avg ref-alt k*          - difference between reference and alternate average k*.
      delta kmer multiplicity - cumulative sum of kmer multiplicity variation.
                                positive values imply recovered kmers, while
                                negative values imply overrepresented kmers introduced.
      record                  - vcf record with <tab> replaced to <space>.
                                only non-reference alleles are printed with GT being 1/1.



Unknown option 'polish'.
Unknown option '--help'.
No haploid peak (-peak) supplied.
No report type (-filter, -polish, -hist, -dump, -completeness) supplied.
No read meryl database (-readmers) supplied.
```


## merfin_hist

### Tool Description
Predict the kmer consequences of variant calls <input.vcf> given the consensus sequence <seq.fasta> and lookup the k-mer multiplicity in the consensus sequence <seq.meryl> and in the reads <read.meryl>.

### Metadata
- **Docker Image**: quay.io/biocontainers/merfin:1.0--h9948957_3
- **Homepage**: https://github.com/arangrhie/merfin
- **Package**: https://anaconda.org/channels/bioconda/packages/merfin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: merfin <report-type>            \
         -sequence <seq.fasta>     \
         -readmers <read.meryl>    \
         -peak     <haploid_peak>  \
         -prob     <lookup_table>  \
         -vcf      <input.vcf>     \
         -output   <output>        

  Predict the kmer consequences of variant calls <input.vcf> given the consensus sequence <seq.fasta>
  and lookup the k-mer multiplicity in the consensus sequence <seq.meryl> and in the reads <read.meryl>.

  Input -sequence and -vcf files can be FASTA or FASTQ; uncompressed, gz, bz2 or xz compressed

  Each readmers can be filtered by value.  More advanced filtering
  requires a new database to be constructed using meryl.
    -min     m     Ignore kmers with value below m
    -max     m     Ignore kmers with value above m
    -threads t     Multithreading for meryl lookup table construction, dump and hist.

  Memory usage can be limited, within reason, by sacrificing kmer lookup
  speed.  If the lookup table requires more memory than allowed, the program
  exits with an error.
    -memory  m     Don't use more than m GB memory for loading mers

  For k* based evaluation and polishing, -peak is required with optional -prob.
    -peak    m     Required input to hard set copy 1 and infer multiplicity to copy number (recommended).
    -prob    file  Optional input vector of probabilities. Adjust multiplicity to copy number
                   in case both -prob and -peak are provided, -prob takes higher priority
                   than -peak for multiplicity listed in the vector table.

  By default, <seq.fasta>.meryl will be generated unless -seqmers is provided.
    -seqmers seq.meryl  Optional input for pre-built sequence meryl db

  Exactly one report type must be specified.


  -filter
   Filter variants within distance k and their combinations by missing k-mers.
   Assumes the reference (-sequence) is from a different individual.
   Required: -sequence, -readmers, -vcf, and -output
   Optional: -comb <N>  set the max N of combinations of variants to be evaluated (default: 15)
             -nosplit   without this options combinations larger than N are split
             -debug     output a debug log, into <output>.THREAD_ID.debug.gz

   Output: <output>.filter.vcf : variants chosen.


  -polish
   Score each variant, or variants within distance k and their combinations by k*.
   Assumes the reference (-sequence) is from the same individual.

   Required: -sequence, -readmers, -peak, -vcf, and -output
   Optional: -comb <N>    set the max N of combinations of variants to be evaluated (default: 15)
             -nosplit     without this options combinations larger than N are split
             -prob <file> use probabilities to adjust multiplicity to copy number (recommended)
             -debug       output a debug log, into <output>.THREAD_ID.debug.gz

   Output: <output>.polish.vcf : variants chosen.
     use bcftools view -Oz <output>.polish.vcf and bcftools consensus -H 1 -f <seq.fata> to polish.
     first ALT in heterozygous alleles are usually better supported by avg. |k*|.


  -hist
   Generate a 0-centered k* histogram for sequences in <input.fasta>.
     Positive k* values are expected collapsed copies.
     Negative k* values are expected expanded  copies.
     Closer to 0 means the expected and found k-mers are well balenced, 1:1.

   Required: -sequence, -readmers, -peak, and -output.
   Optional: -prob <file>  use probabilities to adjust multiplicity to copy number (recommended)

   Output: k* <tab> frequency
           Reports QV at the end, in stderr.


  -dump
   Dump readK, asmK, and k* per bases (k-mers) in <input.fasta>.

   Required: -sequence, -readmers, -peak, and -output
   Optional: -skipMissing  skip the missing kmer sites to be printed
             -prob <file>  use probabilities to adjust multiplicity to copy number (recommended)

   Output: seqName <tab> seqPos <tab> readK <tab> asmK <tab> k*
      seqName    - name of the sequence this kmer is from
      seqPos     - start position (0-based) of the kmer in the sequence
      readK      - normalized read copies (read multiplicity / peak)
      asmK       - assembly copies as found in <seq.meryl>
      k*         - 0-centered k* value


  -completeness
   Compute kmer completeness using expected copy numbers for all kmers.

   Required: -seqmers (or -sequence), -readmers, -peak
   Optional: -prob <file>  use probabilities to adjust multiplicity to copy number (recommended)

   Output: total kmers in reads, number of kmers under the expected copy number, and completeness


  Optional output from -debug in -filter and -polish:
   <output>.THREAD_ID.debug.gz : some useful info for debugging.
      seqName <tab> varMerStart <tab> varMerEnd <tab> varMerSeq <tab> score <tab> path
      varMerID                - unique numbering, starting from 0
      varMerRange             - seqName:start-end. position (0-based) of the variant (s),
                                including sequences upstream and downstream of k-1 bp
      varMerSeq               - combination of variant sequence to evalute
      numMissings             - total number of missing kmers
      min k*                  - minimum of all |k*| for non-missing kmers. -1 when all kmers are missing.
      max k*                  - maximum of all |k*| for non-missing kmers. -1 when all kmers are missing.
      median k*               - median  of all |k*| for non-missing kmers. -1 when all kmers are missing.
      avg k*                  - average of all |k*| for non-missing kmers. -1 when all kmers are missing.
      avg ref-alt k*          - difference between reference and alternate average k*.
      delta kmer multiplicity - cumulative sum of kmer multiplicity variation.
                                positive values imply recovered kmers, while
                                negative values imply overrepresented kmers introduced.
      record                  - vcf record with <tab> replaced to <space>.
                                only non-reference alleles are printed with GT being 1/1.



Unknown option 'hist'.
Unknown option '--help'.
No haploid peak (-peak) supplied.
No report type (-filter, -polish, -hist, -dump, -completeness) supplied.
No read meryl database (-readmers) supplied.
```


## merfin_dump

### Tool Description
Predict the kmer consequences of variant calls <input.vcf> given the consensus sequence <seq.fasta> and lookup the k-mer multiplicity in the consensus sequence <seq.meryl> and in the reads <read.meryl>.

### Metadata
- **Docker Image**: quay.io/biocontainers/merfin:1.0--h9948957_3
- **Homepage**: https://github.com/arangrhie/merfin
- **Package**: https://anaconda.org/channels/bioconda/packages/merfin/overview
- **Validation**: PASS

### Original Help Text
```text
usage: merfin <report-type>            \
         -sequence <seq.fasta>     \
         -readmers <read.meryl>    \
         -peak     <haploid_peak>  \
         -prob     <lookup_table>  \
         -vcf      <input.vcf>     \
         -output   <output>        

  Predict the kmer consequences of variant calls <input.vcf> given the consensus sequence <seq.fasta>
  and lookup the k-mer multiplicity in the consensus sequence <seq.meryl> and in the reads <read.meryl>.

  Input -sequence and -vcf files can be FASTA or FASTQ; uncompressed, gz, bz2 or xz compressed

  Each readmers can be filtered by value.  More advanced filtering
  requires a new database to be constructed using meryl.
    -min     m     Ignore kmers with value below m
    -max     m     Ignore kmers with value above m
    -threads t     Multithreading for meryl lookup table construction, dump and hist.

  Memory usage can be limited, within reason, by sacrificing kmer lookup
  speed.  If the lookup table requires more memory than allowed, the program
  exits with an error.
    -memory  m     Don't use more than m GB memory for loading mers

  For k* based evaluation and polishing, -peak is required with optional -prob.
    -peak    m     Required input to hard set copy 1 and infer multiplicity to copy number (recommended).
    -prob    file  Optional input vector of probabilities. Adjust multiplicity to copy number
                   in case both -prob and -peak are provided, -prob takes higher priority
                   than -peak for multiplicity listed in the vector table.

  By default, <seq.fasta>.meryl will be generated unless -seqmers is provided.
    -seqmers seq.meryl  Optional input for pre-built sequence meryl db

  Exactly one report type must be specified.


  -filter
   Filter variants within distance k and their combinations by missing k-mers.
   Assumes the reference (-sequence) is from a different individual.
   Required: -sequence, -readmers, -vcf, and -output
   Optional: -comb <N>  set the max N of combinations of variants to be evaluated (default: 15)
             -nosplit   without this options combinations larger than N are split
             -debug     output a debug log, into <output>.THREAD_ID.debug.gz

   Output: <output>.filter.vcf : variants chosen.


  -polish
   Score each variant, or variants within distance k and their combinations by k*.
   Assumes the reference (-sequence) is from the same individual.

   Required: -sequence, -readmers, -peak, -vcf, and -output
   Optional: -comb <N>    set the max N of combinations of variants to be evaluated (default: 15)
             -nosplit     without this options combinations larger than N are split
             -prob <file> use probabilities to adjust multiplicity to copy number (recommended)
             -debug       output a debug log, into <output>.THREAD_ID.debug.gz

   Output: <output>.polish.vcf : variants chosen.
     use bcftools view -Oz <output>.polish.vcf and bcftools consensus -H 1 -f <seq.fata> to polish.
     first ALT in heterozygous alleles are usually better supported by avg. |k*|.


  -hist
   Generate a 0-centered k* histogram for sequences in <input.fasta>.
     Positive k* values are expected collapsed copies.
     Negative k* values are expected expanded  copies.
     Closer to 0 means the expected and found k-mers are well balenced, 1:1.

   Required: -sequence, -readmers, -peak, and -output.
   Optional: -prob <file>  use probabilities to adjust multiplicity to copy number (recommended)

   Output: k* <tab> frequency
           Reports QV at the end, in stderr.


  -dump
   Dump readK, asmK, and k* per bases (k-mers) in <input.fasta>.

   Required: -sequence, -readmers, -peak, and -output
   Optional: -skipMissing  skip the missing kmer sites to be printed
             -prob <file>  use probabilities to adjust multiplicity to copy number (recommended)

   Output: seqName <tab> seqPos <tab> readK <tab> asmK <tab> k*
      seqName    - name of the sequence this kmer is from
      seqPos     - start position (0-based) of the kmer in the sequence
      readK      - normalized read copies (read multiplicity / peak)
      asmK       - assembly copies as found in <seq.meryl>
      k*         - 0-centered k* value


  -completeness
   Compute kmer completeness using expected copy numbers for all kmers.

   Required: -seqmers (or -sequence), -readmers, -peak
   Optional: -prob <file>  use probabilities to adjust multiplicity to copy number (recommended)

   Output: total kmers in reads, number of kmers under the expected copy number, and completeness


  Optional output from -debug in -filter and -polish:
   <output>.THREAD_ID.debug.gz : some useful info for debugging.
      seqName <tab> varMerStart <tab> varMerEnd <tab> varMerSeq <tab> score <tab> path
      varMerID                - unique numbering, starting from 0
      varMerRange             - seqName:start-end. position (0-based) of the variant (s),
                                including sequences upstream and downstream of k-1 bp
      varMerSeq               - combination of variant sequence to evalute
      numMissings             - total number of missing kmers
      min k*                  - minimum of all |k*| for non-missing kmers. -1 when all kmers are missing.
      max k*                  - maximum of all |k*| for non-missing kmers. -1 when all kmers are missing.
      median k*               - median  of all |k*| for non-missing kmers. -1 when all kmers are missing.
      avg k*                  - average of all |k*| for non-missing kmers. -1 when all kmers are missing.
      avg ref-alt k*          - difference between reference and alternate average k*.
      delta kmer multiplicity - cumulative sum of kmer multiplicity variation.
                                positive values imply recovered kmers, while
                                negative values imply overrepresented kmers introduced.
      record                  - vcf record with <tab> replaced to <space>.
                                only non-reference alleles are printed with GT being 1/1.



Unknown option 'dump'.
Unknown option '--help'.
No haploid peak (-peak) supplied.
No report type (-filter, -polish, -hist, -dump, -completeness) supplied.
No read meryl database (-readmers) supplied.
```

