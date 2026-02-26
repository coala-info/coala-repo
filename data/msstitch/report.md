# msstitch CWL Generation Report

## msstitch_storespectra

### Tool Description
Stores spectra from mzML files into a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Total Downloads**: 124.9K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/lehtiolab/msstitch
- **Stars**: N/A
### Original Help Text
```text
usage: msstitch storespectra [-h] [--version] [--dbfile LOOKUPFN]
                             [--in-memory] [-o OUTFILE]
                             --spectra SPECTRAFNS [SPECTRAFNS ...]
                             --setnames SETNAMES [SETNAMES ...]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --dbfile LOOKUPFN     Database lookup file
  --in-memory           Load sqlite lookup in memory in case of not having
                        access to a fast file system
  -o OUTFILE            Output file
  --spectra SPECTRAFNS [SPECTRAFNS ...]
                        Spectra files in mzML format. Multiple files can be
                        specified, if order is important, e.g. when matching
                        them with quant data, the order will be their input
                        order at the command line.
  --setnames SETNAMES [SETNAMES ...]
                        Names of biological sets. Can be specified with
                        quotation marks if spaces are used
```


## msstitch_storequant

### Tool Description
Store quantitative data from various MS1 quantitation tools.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch storequant [-h] [--version] --dbfile LOOKUPFN [--in-memory]
                           --spectra SPECTRAFNS [SPECTRAFNS ...]
                           [--kronik KRONIKFNS [KRONIKFNS ...]]
                           [--dinosaur DINOSAURFNS [DINOSAURFNS ...]]
                           [--isobaric ISOBARICFNS [ISOBARICFNS ...]] [--apex]
                           [--rttol RT_TOL] [--mztol MZ_TOL]
                           [--mztoltype {ppm,Da}]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --dbfile LOOKUPFN     Database lookup file
  --in-memory           Load sqlite lookup in memory in case of not having
                        access to a fast file system
  --spectra SPECTRAFNS [SPECTRAFNS ...]
                        Spectra files in mzML format. Multiple files can be
                        specified, if order is important, e.g. when matching
                        them with quant data, the order will be their input
                        order at the command line.
  --kronik KRONIKFNS [KRONIKFNS ...]
                        MS1 persisting peptide quant output files from Kronik
                        in text format.Multiple files can be specified, and
                        matching order with spectra files is important.
  --dinosaur DINOSAURFNS [DINOSAURFNS ...]
                        MS1 persisting peptide output files from Dinosaur in
                        text format.Multiple files can be specified, and
                        matching order with spectra files is important.
  --isobaric ISOBARICFNS [ISOBARICFNS ...]
                        Isobaric quant output files from OpenMS in
                        consensusXML format. Multiple files can be specified,
                        and matching order with spectra files is important.
  --apex                Use MS1 peak envelope apex instead of peak sum when
                        storing quant data.
  --rttol RT_TOL        Specifies tolerance in seconds for retention time when
                        mapping MS1 feature quant info to identifications in
                        the PSM table.
  --mztol MZ_TOL        Specifies tolerance in mass-to-charge when mapping MS1
                        feature quant info to identifications in the PSM
                        table.
  --mztoltype {ppm,Da}  Type of tolerance in mass-to-charge when mapping MS1
                        feature quant info to identifications in the PSM
                        table. One of ppm, Da.
```


## msstitch_storeseq

### Tool Description
Store sequence information

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch storeseq [-h] [--version] [--dbfile LOOKUPFN] [--in-memory]
                         -i FN [-o OUTFILE] [--fullprotein] [--map-accessions]
                         [--insourcefrag] [--nterm-meth-loss] [--cutproline]
                         [--minlen MINLENGTH] [--notrypsin]
                         [--miscleav MISS_CLEAVAGE]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --dbfile LOOKUPFN     Database lookup file
  --in-memory           Load sqlite lookup in memory in case of not having
                        access to a fast file system
  -i FN                 Input file of {} format
  -o OUTFILE            Output file
  --fullprotein         Store (storeseq) or use (seqfilt, seqmatch) full
                        protein sequences (at a minimum-match length) in the
                        SQLite file rather than tryptic sequences
  --map-accessions      Use this flag when building a peptide lookup (not
                        --fullprotein) where you want to keep the protein
                        mapping for later use in e.g. annotating PSM table
                        with sequence hits to the passed FASTA
  --insourcefrag        Apply filter against both intact peptides and those
                        that match to the C-terminal part of a tryptic peptide
                        from the database, resulting from in-source
                        fragmentation, where some amino acids will be missing
                        from the N-terminus. Specify the max number of amino
                        acids that may be missing. Database should be built
                        with this flag in order for the lookup to work, since
                        sequences will be stored and looked up reversed
  --nterm-meth-loss     Include peptides in trypsinization where the protein
                        N-term methionine residue has been lost. When used in
                        storeseq, the filter database should be built with
                        this flag in order for the filtering to work.
  --cutproline          Flag to make trypsin before a proline residue. Then
                        filtering will be done against both cut and non-cut
                        peptides.
  --minlen MINLENGTH    Minimum length of peptide to be included
  --notrypsin           Do not trypsinize. In case of using a pretrypsinized
                        FASTA file
  --miscleav MISS_CLEAVAGE
                        Amount of missed cleavages to allow when trypsinizing,
                        default is 0
```


## msstitch_makedecoy

### Tool Description
Create decoy sequences for MS/MS analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch makedecoy [-h] [--version] -i FN [-d OUTDIR] [-o OUTFILE]
                          [--dbfile LOOKUPFN] [--in-memory]
                          [--scramble SCRAMBLE] [--ignore-target-hits]
                          [--notrypsin] [--miscleav MISS_CLEAVAGE]
                          [--minlen MINLENGTH] [--maxshuffle MAX_SHUFFLE]
                          [--keep-target]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i FN                 Input file of {} format
  -d OUTDIR             Directory to output in
  -o OUTFILE            Output file
  --dbfile LOOKUPFN     Database lookup file
  --in-memory           Load sqlite lookup in memory in case of not having
                        access to a fast file system
  --scramble SCRAMBLE   Decoy scrambling method, use: "tryp_rev": tryptic
                        reverse, or "prot_rev": full (protein) reverse.
  --ignore-target-hits  Do not remove tryptic peptides from sequence where
                        they match target DB
  --notrypsin           Do not trypsinize. In case of using a pretrypsinized
                        FASTA file
  --miscleav MISS_CLEAVAGE
                        Amount of missed cleavages to allow when trypsinizing,
                        default is 0
  --minlen MINLENGTH    Minimum length of peptide to be included
  --maxshuffle MAX_SHUFFLE
                        Amount of times to attempt to shuffle a decoy reversed
                        peptide to make it not match target peptides, before
                        discarding it. Used when using tryptic peptide
                        reversal (not protein reversal)
  --keep-target         If this flag is passed, sequences that are shuffled
                        the --max-shuffle amount of times will be kept as
                        unshuffled tryptic reversed peptides. In case you want
                        to keep the target/decoy DB the same sizes
```


## msstitch_trypsinize

### Tool Description
Trypsinizes proteins in a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch trypsinize [-h] [--version] -i FN [-d OUTDIR] [-o OUTFILE]
                           [--miscleav MISS_CLEAVAGE] [--minlen MINLENGTH]
                           [--cutproline] [--nterm-meth-loss]
                           [--ignore-stop-codons]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i FN                 Input file of {} format
  -d OUTDIR             Directory to output in
  -o OUTFILE            Output file
  --miscleav MISS_CLEAVAGE
                        Amount of missed cleavages to allow when trypsinizing,
                        default is 0
  --minlen MINLENGTH    Minimum length of peptide to be included
  --cutproline          Flag to make trypsin before a proline residue. Then
                        filtering will be done against both cut and non-cut
                        peptides.
  --nterm-meth-loss     Include peptides in trypsinization where the protein
                        N-term methionine residue has been lost. When used in
                        storeseq, the filter database should be built with
                        this flag in order for the filtering to work.
  --ignore-stop-codons  Ignore stop codons in protein sequences when
                        trypsinizing them (default is to split on them.
```


## msstitch_concat

### Tool Description
Concatenates multiple msstitch files.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch concat [-h] [--version] [-d OUTDIR] [-o OUTFILE]
                       -i FN [FN ...]

options:
  -h, --help      show this help message and exit
  --version       show program's version number and exit
  -d OUTDIR       Directory to output in
  -o OUTFILE      Output file
  -i FN [FN ...]  Multiple input files of {} format
```


## msstitch_split

### Tool Description
Split an input file based on a specified column or identifier.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch split [-h] [--version] -i FN [-d OUTDIR] [-o OUTFILE]
                      --splitcol SPLITCOL

options:
  -h, --help           show this help message and exit
  --version            show program's version number and exit
  -i FN                Input file of {} format
  -d OUTDIR            Directory to output in
  -o OUTFILE           Output file
  --splitcol SPLITCOL  Either a column number to split a PSM table on, or
                       "TD", "bioset" for splitting on target/decoy or
                       biological sample set columns (resulting from msstitch
                       perco2psm or msstitch psmtable. First column is number
                       1.
```


## msstitch_perco2psm

### Tool Description
Converts Percolator output to PSM table format.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch perco2psm [-h] [--version] [-d OUTDIR] [-o OUTFILE]
                          -i FN [FN ...] [--mzids MZIDFNS [MZIDFNS ...]]
                          --perco PERCOFN [--filtpep FILTPEP]
                          [--filtpsm FILTPSM] [--qvalitypsms QVALITYPSMS]
                          [--qvalitypeps QVALITYPEPS]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -d OUTDIR             Directory to output in
  -o OUTFILE            Output file
  -i FN [FN ...]        Multiple input files of {} format
  --mzids MZIDFNS [MZIDFNS ...]
                        MzIdentML output files belonging to PSM table TSV
                        files, use same order as for TSVs. Must be included
                        when using MSGF+.
  --perco PERCOFN       Percolator XML output file
  --filtpep FILTPEP     Peptide q-value cutoff level as a floating point
                        number
  --filtpsm FILTPSM     PSM q-value cutoff level as a floating point number
  --qvalitypsms QVALITYPSMS
                        Qvality tab separated output containing targets and
                        decoys (i.e. prepared with qvality -d) for PSM scores
  --qvalitypeps QVALITYPEPS
                        Qvality tab separated output containing targets and
                        decoys (i.e. prepared with qvality -d) for peptide
                        scores
```


## msstitch_conffilt

### Tool Description
Applies confidence filtering to PSM data.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch conffilt [-h] [--version] -i FN [-d OUTDIR] [-o OUTFILE]
                         [--confidence-col CONFCOL]
                         [--confcolpattern CONFPATTERN]
                         --confidence-lvl CONFLVL
                         --confidence-better {higher,lower} [--unroll]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i FN                 Input file of {} format
  -d OUTDIR             Directory to output in
  -o OUTFILE            Output file
  --confidence-col CONFCOL
                        Confidence column number or name in the tsv file.
                        First column has number 1.
  --confcolpattern CONFPATTERN
                        Text pattern to identify column in table on which
                        confidence filtering should be done. Use in case of
                        not using standard {} column
  --confidence-lvl CONFLVL
                        Confidence cutoff level as a floating point number
  --confidence-better {higher,lower}
                        Confidence type to define if higher or lower score is
                        better. One of [higher, lower]
  --unroll              PSM table from Mzid2TSV contains either one PSM per
                        line with all the proteins of that shared peptide on
                        the same line (not unrolled, default), or one
                        PSM/protein match per line where each protein from
                        that shared peptide gets its own line (unrolled).
```


## msstitch_psmtable

### Tool Description
Processes PSM tables with various options for analysis and output.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch psmtable [-h] [--version] -i FN [-d OUTDIR] [-o OUTFILE]
                         [--oldpsms OLDPSMFILE] --dbfile LOOKUPFN
                         [--in-memory] [--ms1quant] [--isobaric]
                         [--min-precursor-purity MIN_PURITY] [--unroll]
                         [--spectracol SPECTRACOL] [--addbioset]
                         [--addmiscleav] [--genes] [--proteingroup]
                         [--fasta FASTA] [--genefield GENEFIELD]
                         [--fastadelim {tab,pipe,semicolon}]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i FN                 Input file of {} format
  -d OUTDIR             Directory to output in
  -o OUTFILE            Output file
  --oldpsms OLDPSMFILE  PSM table file containing previously analysed PSMs to
                        append new PSM table to.
  --dbfile LOOKUPFN     Database lookup file
  --in-memory           Load sqlite lookup in memory in case of not having
                        access to a fast file system
  --ms1quant            Specifies to add precursor quant data from lookup DB
                        to output table
  --isobaric            Specifies to add isobaric quant data from lookup DB to
                        output table
  --min-precursor-purity MIN_PURITY
                        Minimum purity of precursor required to output
                        isobaric quantification data, MS2 scans with purity
                        below this value will be assigned NA in isobaric
                        channels
  --unroll              PSM table from Mzid2TSV contains either one PSM per
                        line with all the proteins of that shared peptide on
                        the same line (not unrolled, default), or one
                        PSM/protein match per line where each protein from
                        that shared peptide gets its own line (unrolled).
  --spectracol SPECTRACOL
                        Column number in which spectra file names are, in case
                        some framework has changed the file names. First
                        column number is 1.
  --addbioset           Add biological setname from DB lookup to PSM table
  --addmiscleav         Add missed cleavages to PSM table
  --genes               Specifies to add genes to PSM table
  --proteingroup        Specifies to add protein groups to PSM table
  --fasta FASTA         FASTA sequence database
  --genefield GENEFIELD
                        Field nr (first=1) in FASTA that contains gene name
                        when using --fastadelim to parse the gene names
  --fastadelim {tab,pipe,semicolon}
                        Delimiter in FASTA header, used to parse gene names in
                        case of non-ENSEMBL/Uniprot
```


## msstitch_isosummarize

### Tool Description
Summarize isobaric quantification data.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch isosummarize [-h] [--version] -i FN [-d OUTDIR] [-o OUTFILE]
                             --isobquantcolpattern QUANTCOLPATTERN
                             [--denompatterns DENOMPATTERNS [DENOMPATTERNS ...]]
                             [--denomcols DENOMCOLS [DENOMCOLS ...]]
                             [--mediansweep] [--medianintensity]
                             [--summarize-average] [--keep-psms-na-quant]
                             [--minint MININT] [--featcol FEATCOL]
                             [--logisoquant] [--split-multi-entries]
                             [--median-normalize]
                             [--normalization-factors-table MEDNORM_FACTORS]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i FN                 Input file of {} format
  -d OUTDIR             Directory to output in
  -o OUTFILE            Output file
  --isobquantcolpattern QUANTCOLPATTERN
                        Unique text pattern to identify isobaric quant columns
                        in input table.
  --denompatterns DENOMPATTERNS [DENOMPATTERNS ...]
                        Regex patterns to detect denominator channels in a PSM
                        table, when creating a table with summarized feature
                        isobaric ratios. If both --denompatterns and
                        --denomcol are given then column numbers are used.
                        Usage e.g. --denompattern _126 _131. Also possible:
                        --denompattern _12[6-7] to detect multiple columns.
  --denomcols DENOMCOLS [DENOMCOLS ...]
                        Column numbers of denominator channels when creating a
                        summarized feature table with isobaric ratios from
                        PSMs
  --mediansweep         Instead of choosing a denominator channel, use the
                        median intensity of each PSM as its denominator.
  --medianintensity     Instead of choosing a denominator channel or median-
                        sweeping, report the the median intensity of each
                        summarized feat per channel. This results in reported
                        intensities rather than ratios.
  --summarize-average   Use average isobaric quantification values for
                        summarizing quant from PSMs, instead of default PSM
                        median values
  --keep-psms-na-quant  When summarizing isobaric quantification data, also
                        use the PSMs that have an NA in any channel, even if
                        these may contain overly noisy quant data in the other
                        channels. Normally these PSMs would be skipped in
                        quantification
  --minint MININT       Intensity threshold of PSMs when calculating isobaric
                        ratios. Values below threshold will be set to NA.
                        Defaults to no threshold.
  --featcol FEATCOL     Column number in table in which desired accessions to
                        summarize are stored. First column number is 1. If not
                        specified this will summarize to PSMs themselves, i.e.
                        only calculate the ratios and add those to the PSM
                        table.
  --logisoquant         Output log2 values for isoquant ratios. This
                        log2-transforms input PSM data prior to summarizing
                        and optional normalization. Ratios will be calculated
                        subtracted rather than divided, obviously.
  --split-multi-entries
                        When summarizing isobaric quantification data, also
                        use the PSMs that have multiple mappings to their
                        column, and split these, so that quant data from a PSM
                        mapping to two proteins is used for both proteins
                        Normally these PSMs accessionould be skipped in
                        quantification
  --median-normalize    Median-centering normalization for isobaric quant data
                        on protein or peptide level. This median-centers the
                        data for each channel by dividing with the median
                        channel value (or subtracting in case of log data),
                        for each channel in output features, e.g. proteins.
  --normalization-factors-table MEDNORM_FACTORS
                        A protein/peptide/gene table that provides an
                        alternate source of normalization factors than the
                        table to be normalized. This can be used e.g. when
                        having a PTM table which does not have a large amount
                        of peptides or is noisy. Use together with --median-
                        normalize
```


## msstitch_deletesets

### Tool Description
Deletes sets from a multispecies stitch file.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch deletesets [-h] [--version] -i FN [-d OUTDIR] [-o OUTFILE]
                           [--dbfile LOOKUPFN] [--in-memory]
                           --setnames SETNAMES [SETNAMES ...]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i FN                 Input file of {} format
  -d OUTDIR             Directory to output in
  -o OUTFILE            Output file
  --dbfile LOOKUPFN     Database lookup file
  --in-memory           Load sqlite lookup in memory in case of not having
                        access to a fast file system
  --setnames SETNAMES [SETNAMES ...]
                        Names of biological sets. Can be specified with
                        quotation marks if spaces are used
```


## msstitch_deduppsms

### Tool Description
Deduplicate spectra based on peptide sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch deduppsms [-h] [--version] -i FN [-d OUTDIR] [-o OUTFILE]
                          [--spectracol SPECTRACOL]
                          [--peptidecolpattern PEPTIDECOLPATTERN]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i FN                 Input file of {} format
  -d OUTDIR             Directory to output in
  -o OUTFILE            Output file
  --spectracol SPECTRACOL
                        Column number in which spectra file names are, in case
                        some framework has changed the file names. First
                        column number is 1.
  --peptidecolpattern PEPTIDECOLPATTERN
                        Regular expression pattern to find header field in
                        table where peptide sequences are stored
```


## msstitch_seqfilt

### Tool Description
Filter sequences based on a database lookup.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch seqfilt [-h] [--version] -i FN [-d OUTDIR] [-o OUTFILE]
                        [--fullprotein] --dbfile LOOKUPFN [--in-memory]
                        [--unroll] [--minlen MINLENGTH] [--deamidate]
                        [--enforce-tryptic] [--insourcefrag INSOURCEFRAG]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i FN                 Input file of {} format
  -d OUTDIR             Directory to output in
  -o OUTFILE            Output file
  --fullprotein         Store (storeseq) or use (seqfilt, seqmatch) full
                        protein sequences (at a minimum-match length) in the
                        SQLite file rather than tryptic sequences
  --dbfile LOOKUPFN     Database lookup file
  --in-memory           Load sqlite lookup in memory in case of not having
                        access to a fast file system
  --unroll              PSM table from Mzid2TSV contains either one PSM per
                        line with all the proteins of that shared peptide on
                        the same line (not unrolled, default), or one
                        PSM/protein match per line where each protein from
                        that shared peptide gets its own line (unrolled).
  --minlen MINLENGTH    Minimum length of peptide to be included
  --deamidate           Filter against both normal peptides and deamidated
                        peptides where a D->N transition has occurred.
  --enforce-tryptic     When filtering peptides against whole proteins, filter
                        out peptides that match a whole protein but only if
                        they are fully tryptic, i.e. the protein needs K,R 1
                        position upstream of the peptide, and the peptide
                        C-terminal should also be K,R. Useful when discerning
                        from pseudogenes
  --insourcefrag INSOURCEFRAG
                        Apply filter against both intact peptides and those
                        that match to the C-terminal part of a tryptic peptide
                        from the database, resulting from in-source
                        fragmentation, where some amino acids will be missing
                        from the N-terminus. Specify the max number of amino
                        acids that may be missing. Database should be built
                        with this flag in order for the lookup to work, since
                        sequences will be stored and looked up reversed
```


## msstitch_seqmatch

### Tool Description
Performs sequence matching against a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch seqmatch [-h] [--version] -i FN [-d OUTDIR] [-o OUTFILE]
                         [--fullprotein] --dbfile LOOKUPFN [--in-memory]
                         [--unroll] [--minlen MINLENGTH]
                         --matchcolname MATCHFILENAME [--deamidate]
                         [--enforce-tryptic] [--insourcefrag INSOURCEFRAG]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i FN                 Input file of {} format
  -d OUTDIR             Directory to output in
  -o OUTFILE            Output file
  --fullprotein         Store (storeseq) or use (seqfilt, seqmatch) full
                        protein sequences (at a minimum-match length) in the
                        SQLite file rather than tryptic sequences
  --dbfile LOOKUPFN     Database lookup file
  --in-memory           Load sqlite lookup in memory in case of not having
                        access to a fast file system
  --unroll              PSM table from Mzid2TSV contains either one PSM per
                        line with all the proteins of that shared peptide on
                        the same line (not unrolled, default), or one
                        PSM/protein match per line where each protein from
                        that shared peptide gets its own line (unrolled).
  --minlen MINLENGTH    Minimum length of peptide to be included
  --matchcolname MATCHFILENAME
                        Column header field name for the column where matching
                        accessions will be in
  --deamidate           Filter against both normal peptides and deamidated
                        peptides where a D->N transition has occurred.
  --enforce-tryptic     When filtering peptides against whole proteins, filter
                        out peptides that match a whole protein but only if
                        they are fully tryptic, i.e. the protein needs K,R 1
                        position upstream of the peptide, and the peptide
                        C-terminal should also be K,R. Useful when discerning
                        from pseudogenes
  --insourcefrag INSOURCEFRAG
                        Apply filter against both intact peptides and those
                        that match to the C-terminal part of a tryptic peptide
                        from the database, resulting from in-source
                        fragmentation, where some amino acids will be missing
                        from the N-terminus. Specify the max number of amino
                        acids that may be missing. Database should be built
                        with this flag in order for the lookup to work, since
                        sequences will be stored and looked up reversed
```


## msstitch_filterperco

### Tool Description
Filter peptides based on their properties and a lookup database.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch filterperco [-h] [--version] -i FN [-d OUTDIR] [-o OUTFILE]
                            [--fullprotein] [--deamidate] [--minlen MINLENGTH]
                            --dbfile LOOKUPFN [--in-memory]
                            [--enforce-tryptic] [--insourcefrag INSOURCEFRAG]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i FN                 Input file of {} format
  -d OUTDIR             Directory to output in
  -o OUTFILE            Output file
  --fullprotein         Store (storeseq) or use (seqfilt, seqmatch) full
                        protein sequences (at a minimum-match length) in the
                        SQLite file rather than tryptic sequences
  --deamidate           Filter against both normal peptides and deamidated
                        peptides where a D->N transition has occurred.
  --minlen MINLENGTH    Minimum length of peptide to be included
  --dbfile LOOKUPFN     Database lookup file
  --in-memory           Load sqlite lookup in memory in case of not having
                        access to a fast file system
  --enforce-tryptic     When filtering peptides against whole proteins, filter
                        out peptides that match a whole protein but only if
                        they are fully tryptic, i.e. the protein needs K,R 1
                        position upstream of the peptide, and the peptide
                        C-terminal should also be K,R. Useful when discerning
                        from pseudogenes
  --insourcefrag INSOURCEFRAG
                        Apply filter against both intact peptides and those
                        that match to the C-terminal part of a tryptic peptide
                        from the database, resulting from in-source
                        fragmentation, where some amino acids will be missing
                        from the N-terminus. Specify the max number of amino
                        acids that may be missing. Database should be built
                        with this flag in order for the lookup to work, since
                        sequences will be stored and looked up reversed
```


## msstitch_dedupperco

### Tool Description
When running dedupperco also remove "duplicate" PSMs (by PSM ID plus sequence). Keeps first PSM encountered of each PSM ID / sequence combination

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch dedupperco [-h] [--version] -i FN [-d OUTDIR] [-o OUTFILE]
                           [--includepsms]

options:
  -h, --help     show this help message and exit
  --version      show program's version number and exit
  -i FN          Input file of {} format
  -d OUTDIR      Directory to output in
  -o OUTFILE     Output file
  --includepsms  When running dedupperco also remove "duplicate" PSMs (by PSM
                 ID plus sequence). Keeps first PSM encountered of each PSM ID
                 / sequence combination
```


## msstitch_splitperco

### Tool Description
Split peptides based on protein headers.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch splitperco [-h] [--version] -i FN [-d OUTDIR]
                           --protheaders PROTHEADERS [PROTHEADERS ...]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i FN                 Input file of {} format
  -d OUTDIR             Directory to output in
  --protheaders PROTHEADERS [PROTHEADERS ...]
                        Specify protein FASTA headers to split on. Multiple
                        headers of the same split-type can be grouped with
                        semicolons. E.g. --protheaders 'ENSP;sp
                        PSEUDOGEN;ncRNA' would split into ENSP/swissprot
                        peptides and pseudogenes/non-coding RNA peptides.
```


## msstitch_peptides

### Tool Description
Stitches together peptide-level quantification data.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch peptides [-h] [--version] -i FN [-d OUTDIR] [-o OUTFILE]
                         [--spectracol SPECTRACOL]
                         --scorecolpattern SCORECOLPATTERN
                         [--isobquantcolpattern QUANTCOLPATTERN]
                         [--ms1quantcolpattern PRECURSORQUANTCOLPATTERN]
                         [--minint MININT]
                         [--denomcols DENOMCOLS [DENOMCOLS ...]]
                         [--denompatterns DENOMPATTERNS [DENOMPATTERNS ...]]
                         [--mediansweep] [--medianintensity]
                         [--summarize-average] [--logisoquant]
                         [--median-normalize]
                         [--normalization-factors-table MEDNORM_FACTORS]
                         [--modelqvals] [--qvalthreshold QVALTHRESHOLD]
                         [--keep-psms-na-quant] [--minpepnr MINPEPTIDENR]
                         [--totalproteome TOTALPROTFN]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i FN                 Input file of {} format
  -d OUTDIR             Directory to output in
  -o OUTFILE            Output file
  --spectracol SPECTRACOL
                        Specify this column number (first col. is 1)
                        containing PSM table spectrafiles (e.g. mzML) if you
                        want to track PSMs when creating peptide tables
  --scorecolpattern SCORECOLPATTERN
                        Regular expression pattern to find column where score
                        to use (e.g. percolator svm-score) is written.
  --isobquantcolpattern QUANTCOLPATTERN
                        Unique text pattern to identify isobaric quant columns
                        in input table.
  --ms1quantcolpattern PRECURSORQUANTCOLPATTERN
                        Unique text pattern to identify precursor quant column
                        in input table.
  --minint MININT       Intensity threshold of PSMs when calculating isobaric
                        ratios. Values below threshold will be set to NA.
                        Defaults to no threshold.
  --denomcols DENOMCOLS [DENOMCOLS ...]
                        Column numbers of denominator channels when creating a
                        summarized feature table with isobaric ratios from
                        PSMs
  --denompatterns DENOMPATTERNS [DENOMPATTERNS ...]
                        Regex patterns to detect denominator channels in a PSM
                        table, when creating a table with summarized feature
                        isobaric ratios. If both --denompatterns and
                        --denomcol are given then column numbers are used.
                        Usage e.g. --denompattern _126 _131. Also possible:
                        --denompattern _12[6-7] to detect multiple columns.
  --mediansweep         Instead of choosing a denominator channel, use the
                        median intensity of each PSM as its denominator.
  --medianintensity     Instead of choosing a denominator channel or median-
                        sweeping, report the the median intensity of each
                        summarized feat per channel. This results in reported
                        intensities rather than ratios.
  --summarize-average   Use average isobaric quantification values for
                        summarizing quant from PSMs, instead of default PSM
                        median values
  --logisoquant         Output log2 values for isoquant ratios. This
                        log2-transforms input PSM data prior to summarizing
                        and optional normalization. Ratios will be calculated
                        subtracted rather than divided, obviously.
  --median-normalize    Median-centering normalization for isobaric quant data
                        on protein or peptide level. This median-centers the
                        data for each channel by dividing with the median
                        channel value (or subtracting in case of log data),
                        for each channel in output features, e.g. proteins.
  --normalization-factors-table MEDNORM_FACTORS
                        A protein/peptide/gene table that provides an
                        alternate source of normalization factors than the
                        table to be normalized. This can be used e.g. when
                        having a PTM table which does not have a large amount
                        of peptides or is noisy. Use together with --median-
                        normalize
  --modelqvals          Create linear-modeled q-vals for peptides, to avoid
                        overlapping stepped low-qvalue data of peptides with
                        different scores
  --qvalthreshold QVALTHRESHOLD
                        Specifies the inclusion threshold for q-values to fit
                        a linear model to. Any scores/q-values below this
                        threshold will not be used.
  --keep-psms-na-quant  When summarizing isobaric quantification data, also
                        use the PSMs that have an NA in any channel, even if
                        these may contain overly noisy quant data in the other
                        channels. Normally these PSMs would be skipped in
                        quantification
  --minpepnr MINPEPTIDENR
                        Specifies the minimal amount of peptides (passing the
                        --qvalthreshold) needed to fit a linear model, default
                        is 10.
  --totalproteome TOTALPROTFN
                        File containing total proteome quantification to
                        normalize PTM peptide quantification against, i.e.
                        Phospho peptides isobaric quant ratios are divided by
                        their proteins to distinguish differential
                        phosphorylation from the protein expression variation
                        in the sample. This file can also be a gene names or
                        ENSG table. Accession should be in the first column.
                        The file is preferably generated from a search without
                        the relevant PTM, and can be a median-center
                        normalized table.
```


## msstitch_proteins

### Tool Description
Processes protein quantification data, including isobaric labeling and FDR calculation.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch proteins [-h] [--version] -i FN [-d OUTDIR] [-o OUTFILE]
                         --decoyfn DECOYFN --scorecolpattern SCORECOLPATTERN
                         [--logscore] [--isobquantcolpattern QUANTCOLPATTERN]
                         [--minint MININT]
                         [--denomcols DENOMCOLS [DENOMCOLS ...]]
                         [--denompatterns DENOMPATTERNS [DENOMPATTERNS ...]]
                         [--mediansweep] [--medianintensity]
                         [--summarize-average] [--logisoquant]
                         [--median-normalize]
                         [--normalization-factors-table MEDNORM_FACTORS]
                         [--keep-psms-na-quant] [--ms1quant]
                         [--psmtable PSMFILE]
                         [--fastadelim {tab,pipe,semicolon}]
                         [--genefield GENEFIELD] [--targetfasta T_FASTA]
                         [--decoyfasta D_FASTA] [--fdrtype {picked,classic}]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i FN                 Input file of {} format
  -d OUTDIR             Directory to output in
  -o OUTFILE            Output file
  --decoyfn DECOYFN     Decoy peptide table input file
  --scorecolpattern SCORECOLPATTERN
                        Regular expression pattern to find column where score
                        to use (e.g. percolator svm-score) is written.
  --logscore            Score, e.g. q-values will be converted to -log10
                        values.
  --isobquantcolpattern QUANTCOLPATTERN
                        Unique text pattern to identify isobaric quant columns
                        in input table.
  --minint MININT       Intensity threshold of PSMs when calculating isobaric
                        ratios. Values below threshold will be set to NA.
                        Defaults to no threshold.
  --denomcols DENOMCOLS [DENOMCOLS ...]
                        Column numbers of denominator channels when creating a
                        summarized feature table with isobaric ratios from
                        PSMs
  --denompatterns DENOMPATTERNS [DENOMPATTERNS ...]
                        Regex patterns to detect denominator channels in a PSM
                        table, when creating a table with summarized feature
                        isobaric ratios. If both --denompatterns and
                        --denomcol are given then column numbers are used.
                        Usage e.g. --denompattern _126 _131. Also possible:
                        --denompattern _12[6-7] to detect multiple columns.
  --mediansweep         Instead of choosing a denominator channel, use the
                        median intensity of each PSM as its denominator.
  --medianintensity     Instead of choosing a denominator channel or median-
                        sweeping, report the the median intensity of each
                        summarized feat per channel. This results in reported
                        intensities rather than ratios.
  --summarize-average   Use average isobaric quantification values for
                        summarizing quant from PSMs, instead of default PSM
                        median values
  --logisoquant         Output log2 values for isoquant ratios. This
                        log2-transforms input PSM data prior to summarizing
                        and optional normalization. Ratios will be calculated
                        subtracted rather than divided, obviously.
  --median-normalize    Median-centering normalization for isobaric quant data
                        on protein or peptide level. This median-centers the
                        data for each channel by dividing with the median
                        channel value (or subtracting in case of log data),
                        for each channel in output features, e.g. proteins.
  --normalization-factors-table MEDNORM_FACTORS
                        A protein/peptide/gene table that provides an
                        alternate source of normalization factors than the
                        table to be normalized. This can be used e.g. when
                        having a PTM table which does not have a large amount
                        of peptides or is noisy. Use together with --median-
                        normalize
  --keep-psms-na-quant  When summarizing isobaric quantification data, also
                        use the PSMs that have an NA in any channel, even if
                        these may contain overly noisy quant data in the other
                        channels. Normally these PSMs would be skipped in
                        quantification
  --ms1quant            Specifies to add precursor quant data from lookup DB
                        to output table
  --psmtable PSMFILE    PSM table file containing isobaric quant data to add
                        to table.
  --fastadelim {tab,pipe,semicolon}
                        Delimiter in FASTA header, used to parse gene names in
                        case of non-ENSEMBL/Uniprot
  --genefield GENEFIELD
                        Field nr (first=1) in FASTA that contains gene name
                        when using --fastadelim to parse the gene names
  --targetfasta T_FASTA
                        FASTA file with target proteins to determine best
                        scoring proteins of target/decoy pairs for picked FDR.
                        Required when using --fdrtype picked
  --decoyfasta D_FASTA  FASTA file with decoy proteins to determine best
                        scoring proteins of target/decoy pairs for picked FDR.
                        Required when using --fdrtype picked
  --fdrtype {picked,classic}
                        FDR strategy type used. Can be one of [classic,
                        picked]. Picked FDR is implemented after Savitski et
                        al. 2015, MCP, and needs target and decoy fasta files
                        to form pairs
```


## msstitch_genes

### Tool Description
Processes gene-related data, likely from mass spectrometry experiments, for quantification and analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch genes [-h] [--version] -i FN [-d OUTDIR] [-o OUTFILE]
                      --decoyfn DECOYFN --scorecolpattern SCORECOLPATTERN
                      [--logscore] [--isobquantcolpattern QUANTCOLPATTERN]
                      [--minint MININT]
                      [--denomcols DENOMCOLS [DENOMCOLS ...]]
                      [--denompatterns DENOMPATTERNS [DENOMPATTERNS ...]]
                      [--mediansweep] [--medianintensity]
                      [--summarize-average] [--logisoquant]
                      [--median-normalize]
                      [--normalization-factors-table MEDNORM_FACTORS]
                      [--keep-psms-na-quant] [--ms1quant] [--psmtable PSMFILE]
                      [--fastadelim {tab,pipe,semicolon}]
                      [--genefield GENEFIELD] [--targetfasta T_FASTA]
                      [--decoyfasta D_FASTA] [--fdrtype {picked,classic}]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i FN                 Input file of {} format
  -d OUTDIR             Directory to output in
  -o OUTFILE            Output file
  --decoyfn DECOYFN     Decoy peptide table input file
  --scorecolpattern SCORECOLPATTERN
                        Regular expression pattern to find column where score
                        to use (e.g. percolator svm-score) is written.
  --logscore            Score, e.g. q-values will be converted to -log10
                        values.
  --isobquantcolpattern QUANTCOLPATTERN
                        Unique text pattern to identify isobaric quant columns
                        in input table.
  --minint MININT       Intensity threshold of PSMs when calculating isobaric
                        ratios. Values below threshold will be set to NA.
                        Defaults to no threshold.
  --denomcols DENOMCOLS [DENOMCOLS ...]
                        Column numbers of denominator channels when creating a
                        summarized feature table with isobaric ratios from
                        PSMs
  --denompatterns DENOMPATTERNS [DENOMPATTERNS ...]
                        Regex patterns to detect denominator channels in a PSM
                        table, when creating a table with summarized feature
                        isobaric ratios. If both --denompatterns and
                        --denomcol are given then column numbers are used.
                        Usage e.g. --denompattern _126 _131. Also possible:
                        --denompattern _12[6-7] to detect multiple columns.
  --mediansweep         Instead of choosing a denominator channel, use the
                        median intensity of each PSM as its denominator.
  --medianintensity     Instead of choosing a denominator channel or median-
                        sweeping, report the the median intensity of each
                        summarized feat per channel. This results in reported
                        intensities rather than ratios.
  --summarize-average   Use average isobaric quantification values for
                        summarizing quant from PSMs, instead of default PSM
                        median values
  --logisoquant         Output log2 values for isoquant ratios. This
                        log2-transforms input PSM data prior to summarizing
                        and optional normalization. Ratios will be calculated
                        subtracted rather than divided, obviously.
  --median-normalize    Median-centering normalization for isobaric quant data
                        on protein or peptide level. This median-centers the
                        data for each channel by dividing with the median
                        channel value (or subtracting in case of log data),
                        for each channel in output features, e.g. proteins.
  --normalization-factors-table MEDNORM_FACTORS
                        A protein/peptide/gene table that provides an
                        alternate source of normalization factors than the
                        table to be normalized. This can be used e.g. when
                        having a PTM table which does not have a large amount
                        of peptides or is noisy. Use together with --median-
                        normalize
  --keep-psms-na-quant  When summarizing isobaric quantification data, also
                        use the PSMs that have an NA in any channel, even if
                        these may contain overly noisy quant data in the other
                        channels. Normally these PSMs would be skipped in
                        quantification
  --ms1quant            Specifies to add precursor quant data from lookup DB
                        to output table
  --psmtable PSMFILE    PSM table file containing isobaric quant data to add
                        to table.
  --fastadelim {tab,pipe,semicolon}
                        Delimiter in FASTA header, used to parse gene names in
                        case of non-ENSEMBL/Uniprot
  --genefield GENEFIELD
                        Field nr (first=1) in FASTA that contains gene name
                        when using --fastadelim to parse the gene names
  --targetfasta T_FASTA
                        FASTA file with target proteins to determine best
                        scoring proteins of target/decoy pairs for picked FDR.
                        Required when using --fdrtype picked
  --decoyfasta D_FASTA  FASTA file with decoy proteins to determine best
                        scoring proteins of target/decoy pairs for picked FDR.
                        Required when using --fdrtype picked
  --fdrtype {picked,classic}
                        FDR strategy type used. Can be one of [classic,
                        picked]. Picked FDR is implemented after Savitski et
                        al. 2015, MCP, and needs target and decoy fasta files
                        to form pairs
```


## msstitch_ensg

### Tool Description
Stitches together isobaric quantification data from PSMs and other sources.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch ensg [-h] [--version] -i FN [-d OUTDIR] [-o OUTFILE]
                     --decoyfn DECOYFN --scorecolpattern SCORECOLPATTERN
                     [--logscore] [--isobquantcolpattern QUANTCOLPATTERN]
                     [--minint MININT] [--denomcols DENOMCOLS [DENOMCOLS ...]]
                     [--denompatterns DENOMPATTERNS [DENOMPATTERNS ...]]
                     [--mediansweep] [--medianintensity] [--summarize-average]
                     [--logisoquant] [--median-normalize]
                     [--normalization-factors-table MEDNORM_FACTORS]
                     [--keep-psms-na-quant] [--ms1quant] [--psmtable PSMFILE]
                     [--fastadelim {tab,pipe,semicolon}]
                     [--genefield GENEFIELD] [--targetfasta T_FASTA]
                     [--decoyfasta D_FASTA] [--fdrtype {picked,classic}]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i FN                 Input file of {} format
  -d OUTDIR             Directory to output in
  -o OUTFILE            Output file
  --decoyfn DECOYFN     Decoy peptide table input file
  --scorecolpattern SCORECOLPATTERN
                        Regular expression pattern to find column where score
                        to use (e.g. percolator svm-score) is written.
  --logscore            Score, e.g. q-values will be converted to -log10
                        values.
  --isobquantcolpattern QUANTCOLPATTERN
                        Unique text pattern to identify isobaric quant columns
                        in input table.
  --minint MININT       Intensity threshold of PSMs when calculating isobaric
                        ratios. Values below threshold will be set to NA.
                        Defaults to no threshold.
  --denomcols DENOMCOLS [DENOMCOLS ...]
                        Column numbers of denominator channels when creating a
                        summarized feature table with isobaric ratios from
                        PSMs
  --denompatterns DENOMPATTERNS [DENOMPATTERNS ...]
                        Regex patterns to detect denominator channels in a PSM
                        table, when creating a table with summarized feature
                        isobaric ratios. If both --denompatterns and
                        --denomcol are given then column numbers are used.
                        Usage e.g. --denompattern _126 _131. Also possible:
                        --denompattern _12[6-7] to detect multiple columns.
  --mediansweep         Instead of choosing a denominator channel, use the
                        median intensity of each PSM as its denominator.
  --medianintensity     Instead of choosing a denominator channel or median-
                        sweeping, report the the median intensity of each
                        summarized feat per channel. This results in reported
                        intensities rather than ratios.
  --summarize-average   Use average isobaric quantification values for
                        summarizing quant from PSMs, instead of default PSM
                        median values
  --logisoquant         Output log2 values for isoquant ratios. This
                        log2-transforms input PSM data prior to summarizing
                        and optional normalization. Ratios will be calculated
                        subtracted rather than divided, obviously.
  --median-normalize    Median-centering normalization for isobaric quant data
                        on protein or peptide level. This median-centers the
                        data for each channel by dividing with the median
                        channel value (or subtracting in case of log data),
                        for each channel in output features, e.g. proteins.
  --normalization-factors-table MEDNORM_FACTORS
                        A protein/peptide/gene table that provides an
                        alternate source of normalization factors than the
                        table to be normalized. This can be used e.g. when
                        having a PTM table which does not have a large amount
                        of peptides or is noisy. Use together with --median-
                        normalize
  --keep-psms-na-quant  When summarizing isobaric quantification data, also
                        use the PSMs that have an NA in any channel, even if
                        these may contain overly noisy quant data in the other
                        channels. Normally these PSMs would be skipped in
                        quantification
  --ms1quant            Specifies to add precursor quant data from lookup DB
                        to output table
  --psmtable PSMFILE    PSM table file containing isobaric quant data to add
                        to table.
  --fastadelim {tab,pipe,semicolon}
                        Delimiter in FASTA header, used to parse gene names in
                        case of non-ENSEMBL/Uniprot
  --genefield GENEFIELD
                        Field nr (first=1) in FASTA that contains gene name
                        when using --fastadelim to parse the gene names
  --targetfasta T_FASTA
                        FASTA file with target proteins to determine best
                        scoring proteins of target/decoy pairs for picked FDR.
                        Required when using --fdrtype picked
  --decoyfasta D_FASTA  FASTA file with decoy proteins to determine best
                        scoring proteins of target/decoy pairs for picked FDR.
                        Required when using --fdrtype picked
  --fdrtype {picked,classic}
                        FDR strategy type used. Can be one of [classic,
                        picked]. Picked FDR is implemented after Savitski et
                        al. 2015, MCP, and needs target and decoy fasta files
                        to form pairs
```


## msstitch_merge

### Tool Description
Merge results from multiple msstitch runs.

### Metadata
- **Docker Image**: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
- **Homepage**: https://github.com/lehtiolab/msstitch
- **Package**: https://anaconda.org/channels/bioconda/packages/msstitch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msstitch merge [-h] [--version] [-d OUTDIR] [-o OUTFILE]
                      --setnames SETNAMES [SETNAMES ...] [--in-memory]
                      [--isobquantcolpattern QUANTCOLPATTERN]
                      [--ms1quantcolpattern PRECURSORQUANTCOLPATTERN]
                      [--fdrcolpattern FDRCOLPATTERN]
                      [--flrcolpattern FLRCOLPATTERN] -i FN [FN ...]
                      [--no-group-annotation] [--featcol FEATCOL]
                      --dbfile LOOKUPFN [--mergecutoff MERGECUTOFF]
                      [--pepcolpattern PEPCOLPATTERN] [--genecentric]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -d OUTDIR             Directory to output in
  -o OUTFILE            Output file
  --setnames SETNAMES [SETNAMES ...]
                        Names of biological sets. Can be specified with
                        quotation marks if spaces are used
  --in-memory           Load sqlite lookup in memory in case of not having
                        access to a fast file system
  --isobquantcolpattern QUANTCOLPATTERN
                        Unique text pattern to identify isobaric quant columns
                        in input table.
  --ms1quantcolpattern PRECURSORQUANTCOLPATTERN
                        Unique text pattern to identify precursor quant column
                        in input table.
  --fdrcolpattern FDRCOLPATTERN
                        Unique text pattern to identify FDR column in input
                        table.
  --flrcolpattern FLRCOLPATTERN
                        Unique text pattern to identify FLR (peptide PTM false
                        localization rate) column in input table.
  -i FN [FN ...]        Multiple input files of {} format
  --no-group-annotation
                        For protein/peptide table merging. Do not include
                        protein group or gene data in output, just use protein
                        accessions.
  --featcol FEATCOL     Column number in table in which desired accessions
                        are. stored. First column number is 1. Use in case of
                        not using default column 1
  --dbfile LOOKUPFN     Database lookup file
  --mergecutoff MERGECUTOFF
                        FDR cutoff when building merged protein table, to use
                        when a cutoff has been used before storing the table
                        to lookup. FDR values need to be stored in the lookup
  --pepcolpattern PEPCOLPATTERN
                        Unique text pattern to identify PEP column (given by
                        percolator for peptides) in input table.
  --genecentric         For peptide table merging. Do not include protein
                        group data in output, but use gene names instead to
                        count peptides per feature, determine peptide-
                        uniqueness.
```

