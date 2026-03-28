# salmon CWL Generation Report

## salmon_index

### Tool Description
Creates a salmon index.

### Metadata
- **Docker Image**: quay.io/biocontainers/salmon:1.10.3--h45fbf2d_5
- **Homepage**: https://github.com/COMBINE-lab/salmon
- **Package**: https://anaconda.org/channels/bioconda/packages/salmon/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/salmon/overview
- **Total Downloads**: 528.9K
- **Last updated**: 2025-05-28
- **GitHub**: https://github.com/COMBINE-lab/salmon
- **Stars**: N/A
### Original Help Text
```text
Version Server Response: Not Found

Index
==========
Creates a salmon index.

Command Line Options:
  -v [ --version ]              print version string
  -h [ --help ]                 produce help message
  -t [ --transcripts ] arg      Transcript fasta file.
  -k [ --kmerLen ] arg (=31)    The size of k-mers that should be used for the 
                                quasi index.
  -i [ --index ] arg            salmon index.
  --gencode                     This flag will expect the input transcript 
                                fasta to be in GENCODE format, and will split 
                                the transcript name at the first '|' character.
                                These reduced names will be used in the output 
                                and when looking for these transcripts in a 
                                gene to transcript GTF.
  --features                    This flag will expect the input reference to be
                                in the tsv file format, and will split the 
                                feature name at the first 'tab' character. 
                                These reduced names will be used in the output 
                                and when looking for the sequence of the 
                                features.GTF.
  --keepDuplicates              This flag will disable the default indexing 
                                behavior of discarding sequence-identical 
                                duplicate transcripts.  If this flag is passed,
                                then duplicate transcripts that appear in the 
                                input will be retained and quantified 
                                separately.
  -p [ --threads ] arg (=2)     Number of threads to use during indexing.
  --keepFixedFasta              Retain the fixed fasta file (without short 
                                transcripts and duplicates, clipped, etc.) 
                                generated during indexing
  -f [ --filterSize ] arg (=-1) The size of the Bloom filter that will be used 
                                by TwoPaCo during indexing. The filter will be 
                                of size 2^{filterSize}. The default value of -1
                                means that the filter size will be 
                                automatically set based on the number of 
                                distinct k-mers in the input, as estimated by 
                                nthll.
  --tmpdir arg                  The directory location that will be used for 
                                TwoPaCo temporary files; it will be created if 
                                need be and be removed prior to indexing 
                                completion. The default value will cause a 
                                (temporary) subdirectory of the salmon index 
                                directory to be used for this purpose.
  --sparse                      Build the index using a sparse sampling of 
                                k-mer positions This will require less memory 
                                (especially during quantification), but will 
                                take longer to construct and can slow down 
                                mapping / alignment
  -d [ --decoys ] arg           Treat these sequences ids from the reference as
                                the decoys that may have sequence homologous to
                                some known transcript. for example in case of 
                                the genome, provide a list of chromosome name 
                                --- one per line
  -n [ --no-clip ]              Don't clip poly-A tails from the ends of target
                                sequences
  --type arg (=puff)            The type of index to build; the only option is 
                                "puff" in this version of salmon.
```


## salmon_quant

### Tool Description
Quantifies expression using raw reads or already-aligned reads (in BAM/SAM format).

### Metadata
- **Docker Image**: quay.io/biocontainers/salmon:1.10.3--h45fbf2d_5
- **Homepage**: https://github.com/COMBINE-lab/salmon
- **Package**: https://anaconda.org/channels/bioconda/packages/salmon/overview
- **Validation**: PASS

### Original Help Text
```text
salmon v1.10.3
    ===============

    salmon quant has two modes --- one quantifies expression using raw reads
    and the other makes use of already-aligned reads (in BAM/SAM format).
    Which algorithm is used depends on the arguments passed to salmon quant.
    If you provide salmon with alignments '-a [ --alignments ]' then the
    alignment-based algorithm will be used, otherwise the algorithm for
    quantifying from raw reads will be used.

    to view the help for salmon's selective-alignment-based mode, use the command

    salmon quant --help-reads

    To view the help for salmon's alignment-based mode, use the command

    salmon quant --help-alignment
```


## salmon_alevin

### Tool Description
salmon-based processing of single-cell RNA-seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/salmon:1.10.3--h45fbf2d_5
- **Homepage**: https://github.com/COMBINE-lab/salmon
- **Package**: https://anaconda.org/channels/bioconda/packages/salmon/overview
- **Validation**: PASS

### Original Help Text
```text
alevin
==========
salmon-based processing of single-cell RNA-seq data.

alevin options:


mapping input options:
  -l [ --libType ] arg                  Format string describing the library 
                                        type
  -i [ --index ] arg                    salmon index
  -r [ --unmatedReads ] arg             List of files containing unmated reads 
                                        of (e.g. single-end reads)
  -1 [ --mates1 ] arg                   File containing the #1 mates
  -2 [ --mates2 ] arg                   File containing the #2 mates


alevin-specific Options:
  -v [ --version ]                      print version string
  -h [ --help ]                         produce help message
  -o [ --output ] arg                   Output quantification directory.
  -j [ --rad ]                          just selectively align the data and 
                                        write the results to a RAD file.  Do 
                                        not perform the rest of the 
                                        quantification procedure.
  --sketch                              perform sketching rather than selective
                                        alignment and write the results to a 
                                        RAD file. Requires the `--rad` flag. Do
                                        not perform the rest of the 
                                        quantification procedure.
  -p [ --threads ] arg (=5)             The number of threads to use 
                                        concurrently.
  --tgMap arg                           transcript to gene map tsv file
  --hash arg                            Secondary input point for Alevin using 
                                        Big freaking Hash (bfh.txt) file. Works
                                        Only with --chromium
  --dropseq                             Use DropSeq Single Cell protocol for 
                                        the library
  --chromiumV3                          Use 10x chromium v3 Single Cell 
                                        protocol for the library.
  --chromium                            Use 10x chromium v2 Single Cell 
                                        protocol for the library.
  --gemcode                             Use 10x gemcode v1 Single Cell protocol
                                        for the library.
  --citeseq                             Use CITESeq Single Cell protocol for 
                                        the library, 16 CB, 12 UMI and 
                                        features.
  --celseq                              Use CEL-Seq Single Cell protocol for 
                                        the library.
  --celseq2                             Use CEL-Seq2 Single Cell protocol for 
                                        the library.
  --splitseqV1                          Use Split-SeqV1 Single Cell protocol 
                                        for the library.
  --splitseqV2                          Use Split-SeqV2 Single Cell protocol 
                                        for the library.
  --quartzseq2                          Use Quartz-Seq2 v3.2 Single Cell 
                                        protocol for the library assumes 15 
                                        length barcode and 8 length UMI.
  --sciseq3                             Use sci-RNA-seq3 protocol for the 
                                        library.
  --whitelist arg                       File containing white-list barcodes
  --featureStart arg                    This flag should be used with citeseq 
                                        and specifies the starting index of the
                                        feature barcode on Read2.
  --featureLength arg                   This flag should be used with citeseq 
                                        and specifies the length of the feature
                                        barcode.
  --noQuant                             Don't run downstream barcode-salmon 
                                        model.
  --numCellBootstraps arg (=0)          Generate mean and variance for cell x 
                                        gene matrix quantification estimates.
  --numCellGibbsSamples arg (=0)        Generate mean and variance for cell x 
                                        gene matrix quantification by running 
                                        gibbs chain estimates.
  --forceCells arg (=0)                 Explicitly specify the number of cells.
  --expectCells arg (=0)                define a close upper bound on expected 
                                        number of cells
  --mrna arg                            path to a file containing mito-RNA 
                                        gene, one per line
  --rrna arg                            path to a file containing ribosomal 
                                        RNA, one per line
  --keepCBFraction arg (=0)             fraction of CB to keep, value must be 
                                        in range (0,1], use 1 to quantify all 
                                        CB.
  --read-geometry arg                   format string describing the geometry 
                                        of the read
  --bc-geometry arg                     format string describing the geometry 
                                        of the cell barcode
  --umi-geometry arg                    format string describing the genometry 
                                        of the umi
  --end arg                             Cell-Barcodes end (5 or 3) location in 
                                        the read sequence from where barcode 
                                        has to be extracted. (end, umiLength, 
                                        barcodeLength) should all be provided 
                                        if using this option
  --umiLength arg                       umi length Parameter for unknown 
                                        protocol. (end, umiLength, 
                                        barcodeLength) should all be provided 
                                        if using this option
  --barcodeLength arg                   barcode length Parameter for unknown 
                                        protocol. (end, umiLength, 
                                        barcodeLength) should all be provided 
                                        if using this option
  --noem                                do not run em
  --freqThreshold arg (=10)             threshold for the frequency of the 
                                        barcodes
  --umiEditDistance arg (=1)            Maximum allowble edit distance to 
                                        collapse UMIs, Expect delay in running 
                                        time if != 1
  --dumpfq                              Dump barcode modified fastq file for 
                                        downstream analysis by using coin toss 
                                        for multi-mapping.
  --dumpBfh                             dump the big hash with all the barcodes
                                        and the UMI sequence.
  --dumpArborescences                   dump the gene-v-cell matrix for the 
                                        total number of fragments used in the 
                                        UMI deduplicaiton.
  --dumpUmiGraph                        dump the per cell level Umi Graph.
  --dumpCellEq                          dump the per cell level deduplicated 
                                        equivalence classes.
  --dumpFeatures                        Dump features for whitelist and 
                                        downstream analysis.
  --dumpMtx                             Dump cell v transcripts count matrix in
                                        sparse mtx format.
  --lowRegionMinNumBarcodes arg (=200)  Minimum Number of CB to use for 
                                        learning Low confidence region 
                                        (Default: 200).
  --maxNumBarcodes arg (=100000)        Maximum allowable limit to process the 
                                        cell barcodes. (Default: 100000)
```


## salmon_swim

### Tool Description
A tool for single-cell RNA-seq analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/salmon:1.10.3--h45fbf2d_5
- **Homepage**: https://github.com/COMBINE-lab/salmon
- **Package**: https://anaconda.org/channels/bioconda/packages/salmon/overview
- **Validation**: PASS

### Original Help Text
```text
_____       __
   / ___/____ _/ /___ ___  ____  ____
   \__ \/ __ `/ / __ `__ \/ __ \/ __ \
  ___/ / /_/ / / / / / / / /_/ / / / /
 /____/\__,_/_/_/ /_/ /_/\____/_/ /_/
```


## salmon_quantmerge

### Tool Description
Merge multiple quantification results into a single file.

### Metadata
- **Docker Image**: quay.io/biocontainers/salmon:1.10.3--h45fbf2d_5
- **Homepage**: https://github.com/COMBINE-lab/salmon
- **Package**: https://anaconda.org/channels/bioconda/packages/salmon/overview
- **Validation**: PASS

### Original Help Text
```text
Version Server Response: Not Found

quantmerge
==========
Merge multiple quantification results into
a single file.

salmon quantmerge options:


basic options:
  -v [ --version ]            print version string
  -h [ --help ]               produce help message
  --quants arg                List of quantification directories.
  --names arg                 Optional list of names to give to the samples.
  -c [ --column ] arg (=TPM)  The name of the column that will be merged 
                              together into the output files. The options are 
                              {len, elen, tpm, numreads}
  --genes                     Use gene quantification instead of transcript.
  --missing arg (=NA)         The value of missing values.
  -o [ --output ] arg         Output quantification file.
```


## Metadata
- **Skill**: generated
