# sailfish CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| sailfish_index | PASS | index of the repo sarscov2 transcriptome; used by the quant test |
| sailfish_quant | PASS | 94 of 100 real read pairs assigned to the 11 sarscov2 transcripts, mostly orf1ab; reads must be uncompressed |

## sailfish_index

### Tool Description
Builds a Sailfish index

### Metadata
- **Docker Image**: quay.io/biocontainers/sailfish:0.10.1--1
- **Homepage**: https://github.com/kingsfordgroup/sailfish
- **Package**: https://anaconda.org/channels/bioconda/packages/sailfish/overview
- **Validation**: PASS

### Original Help Text
```text
index
==========
Builds a Sailfish index

Command Line Options:
  -v [ --version ]            print version string
  -h [ --help ]               produce help message
  -t [ --transcripts ] arg    Transcript fasta file(s).
  -k [ --kmerSize ] arg (=31) Kmer size.
  -o [ --out ] arg            Output stem [all files needed by Sailfish will be
                              of the form stem.*].
  -p [ --threads ] arg (=20)  The number of threads to use concurrently.
  -f [ --force ] 

Version Info: This is the most recent version of Sailfish
```

## sailfish_quant

### Tool Description
Perform quasi-mapping-based estimation of transcript abundance from RNA-seq reads

### Metadata
- **Docker Image**: quay.io/biocontainers/sailfish:0.10.1--1
- **Homepage**: https://github.com/kingsfordgroup/sailfish
- **Package**: https://anaconda.org/channels/bioconda/packages/sailfish/overview
- **Validation**: PASS

### Original Help Text
```text
Quant
                ==========
                Perform quasi-mapping-based estimation of
                transcript abundance from RNA-seq reads
                
sailfish quant options:


basic options:
  -v [ --version ]                    print version string
  -h [ --help ]                       produce help message
  -i [ --index ] arg                  Sailfish index
  -l [ --libType ] arg                Format string describing the library type
  -r [ --unmatedReads ] arg           List of files containing unmated reads of
                                      (e.g. single-end reads)
  -1 [ --mates1 ] arg                 File containing the #1 mates
  -2 [ --mates2 ] arg                 File containing the #2 mates
  -p [ --threads ] arg (=20)          The number of threads to use 
                                      concurrently.
  -o [ --output ] arg                 Output quantification file.
  -g [ --geneMap ] arg                File containing a mapping of transcripts 
                                      to genes.  If this file is provided 
                                      Sailfish will output both quant.sf and 
                                      quant.genes.sf files, where the latter 
                                      contains aggregated gene-level abundance 
                                      estimates.  The transcript to gene 
                                      mapping should be provided as either a 
                                      GTF file, or a in a simple tab-delimited 
                                      format where each line contains the name 
                                      of a transcript and the gene to which it 
                                      belongs separated by a tab.  The 
                                      extension of the file is used to 
                                      determine how the file should be parsed. 
                                      Files ending in '.gtf' or '.gff' are 
                                      assumed to be in GTF format; files with 
                                      any other extension are assumed to be in 
                                      the simple format.
  --biasCorrect                       Perform sequence-specific bias correction
  --gcBiasCorrect                     [experimental] Perform fragment GC bias 
                                      correction


advanced options:
  --auxDir arg (=aux)                 The sub-directory of the quantification 
                                      directory where auxiliary information 
                                      e.g. bootstraps, bias parameters, etc. 
                                      will be written.
  --dumpEq                            Dump the equivalence class counts that 
                                      were computed during quasi-mapping
  --gcSizeSamp arg (=1)               The value by which to down-sample 
                                      transcripts when representing the GC 
                                      content.  Larger values will reduce 
                                      memory usage, but may decrease the 
                                      fidelity of bias modeling results.
  --gcSpeedSamp arg (=1)              The value at which the fragment length 
                                      PMF is down-sampled when evaluating GC 
                                      fragment bias.  Larger values speed up 
                                      effective length correction, but may 
                                      decrease the fidelity of bias modeling 
                                      results.
  --strictIntersect                   Modifies how orphans are assigned.  When 
                                      this flag is set, if the intersection of 
                                      the quasi-mappings for the left and right
                                      is empty, then all mappings for the left 
                                      and all mappings for the right read are 
                                      reported as orphaned quasi-mappings
  --unsmoothedFLD                     Use the "un-smoothed" (i.e. traditional) 
                                      approach to effective length correction 
                                      by convolving the FLD with the 
                                      characteristic function over each 
                                      transcript
  --maxFragLen arg (=1000)            The maximum length of a fragment to 
                                      consider when building the empirical 
                                      fragment length distribution
  --txpAggregationKey arg (=gene_id)  When generating the gene-level estimates,
                                      use the provided key for aggregating 
                                      transcripts.  The default is the 
                                      "gene_id" field, but other fields (e.g. 
                                      "gene_name") might be useful depending on
                                      the specifics of the annotation being 
                                      used.  Note: this option only affects 
                                      aggregation when using a GTF annotation; 
                                      not an annotation in "simple" format.
  --ignoreLibCompat                   Disables strand-aware processing 
                                      completely.  All hits are considered 
                                      "valid".
  --enforceLibCompat                  Enforces "strict" library compatibility. 
                                      Fragments that map in a manner other than
                                      what is specified by the expected library
                                      type will be discarded, even if there are
                                      no mappings that agree with the expected 
                                      library type.
  --allowDovetail                     Allow paired-end reads from the same 
                                      fragment to "dovetail", such that the 
                                      ends of the mapped reads can extend past 
                                      each other.
  --discardOrphans                    This option will discard orphaned 
                                      fragments.  This only has an effect on 
                                      paired-end input, but enabling this 
                                      option will discard, rather than count, 
                                      any reads where only one of the paired 
                                      fragments maps to a transcript.
  --numBiasSamples arg (=1000000)     Number of fragment mappings to use when 
                                      learning the sequence-specific bias 
                                      model.
  --numFragSamples arg (=10000)       Number of fragments from unique 
                                      alignments to sample when building the 
                                      fragment length distribution
  --fldMean arg (=200)                If single end reads are being used for 
                                      quantification, or there are an 
                                      insufficient number of uniquely mapping 
                                      reads when performing paired-end 
                                      quantification to estimate the empirical 
                                      fragment length distribution, then use 
                                      this value to calculate effective 
                                      lengths.
  --fldSD arg (=80)                   The standard deviation used in the 
                                      fragment length distribution for 
                                      single-end quantification or when an 
                                      empirical distribution cannot be learned.
  -w [ --maxReadOcc ] arg (=200)      Reads "mapping" to more than this many 
                                      places won't be considered.
  --noEffectiveLengthCorrection       Disables effective length correction when
                                      computing the probability that a fragment
                                      was generated from a transcript.  If this
                                      flag is passed in, the fragment length 
                                      distribution is not taken into account 
                                      when computing this probability.
  --useVBOpt                          Use the Variational Bayesian EM rather 
                                      than the traditional EM algorithm to 
                                      estimate transcript abundances.
  --numGibbsSamples arg (=0)          [*super*-experimental]: Number of Gibbs 
                                      sampling rounds to perform.
  --numBootstraps arg (=0)            [*super*-experimental]: Number of 
                                      bootstrap samples to generate. Note: This
                                      is mutually exclusive with Gibbs 
                                      sampling.

Version Info: This is the most recent version of Sailfish
```

