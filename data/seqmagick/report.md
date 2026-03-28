# seqmagick CWL Generation Report

## seqmagick_help

### Tool Description
Show help for seqmagick actions.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqmagick:0.8.6--pyhdfd78af_0
- **Homepage**: http://github.com/fhcrc/seqmagick
- **Package**: https://anaconda.org/channels/bioconda/packages/seqmagick/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seqmagick/overview
- **Total Downloads**: 29.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fhcrc/seqmagick
- **Stars**: N/A
### Original Help Text
```text
usage: seqmagick help [-h] action

positional arguments:
  action

options:
  -h, --help  show this help message and exit
```


## seqmagick_convert

### Tool Description
Convert between sequence formats

### Metadata
- **Docker Image**: quay.io/biocontainers/seqmagick:0.8.6--pyhdfd78af_0
- **Homepage**: http://github.com/fhcrc/seqmagick
- **Package**: https://anaconda.org/channels/bioconda/packages/seqmagick/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqmagick convert [-h] [--line-wrap N]
                         [--sort {length-asc,length-desc,name-asc,name-desc}]
                         [--apply-function /path/to/module.py:function_name[:parameter]]
                         [--cut start:end[,start2:end2]] [--relative-to ID]
                         [--drop start:end[,start2:end2]] [--dash-gap]
                         [--lower] [--mask start1:end1[,start2:end2]]
                         [--reverse] [--reverse-complement] [--squeeze]
                         [--squeeze-threshold PROP]
                         [--transcribe {dna2rna,rna2dna}]
                         [--translate {dna2protein,rna2protein,dna2proteinstop,rna2proteinstop}]
                         [--ungap] [--upper] [--deduplicate-sequences]
                         [--deduplicated-sequences-file FILE]
                         [--deduplicate-taxa] [--exclude-from-file FILE]
                         [--include-from-file FILE] [--head N]
                         [--max-length N] [--min-length N]
                         [--min-ungapped-length N] [--pattern-include REGEX]
                         [--pattern-exclude REGEX] [--prune-empty]
                         [--sample N] [--sample-seed N]
                         [--seq-pattern-include REGEX]
                         [--seq-pattern-exclude REGEX] [--tail N]
                         [--first-name] [--name-suffix SUFFIX]
                         [--name-prefix PREFIX]
                         [--pattern-replace search_pattern replace_pattern]
                         [--strip-range] [--input-format FORMAT]
                         [--output-format FORMAT]
                         [--alphabet {dna,dna-ambiguous,rna,rna-ambiguous,protein}]
                         source_file dest_file

Convert between sequence formats

positional arguments:
  source_file           Input sequence file
  dest_file             Output file

options:
  -h, --help            show this help message and exit
  --alphabet {dna,dna-ambiguous,rna,rna-ambiguous,protein}
                        Input alphabet. Required for writing NEXUS.

Sequence File Modification:
  --line-wrap N         Adjust line wrap for sequence strings. When N is 0,
                        all line breaks are removed. Only fasta files are
                        supported for the output format.
  --sort {length-asc,length-desc,name-asc,name-desc}
                        Perform sorting by length or name, ascending or
                        descending. ASCII sorting is performed for names

Sequence Modificaton:
  --apply-function /path/to/module.py:function_name[:parameter]
                        Specify a custom function to apply to the input
                        sequences, specified as
                        /path/to/file.py:function_name. Function should accept
                        an iterable of Bio.SeqRecord objects, and yield
                        SeqRecords. If the parameter is specified, it will be
                        passed as a string as the second argument to the
                        function. Specify more than one to chain.
  --cut start:end[,start2:end2]
                        Keep only the residues within the 1-indexed start and
                        end positions specified, : separated. Includes last
                        item. Start or end can be left unspecified to indicate
                        start/end of sequence. A negative start may be
                        provided to indicate an offset from the end of the
                        sequence. Note that to prevent negative numbers being
                        interpreted as flags, this should be written with an
                        equals sign between `--cut` and the argument, e.g.:
                        `--cut=-10:`
  --relative-to ID      Apply --cut relative to the indexes of non-gap
                        residues in sequence identified by ID
  --drop start:end[,start2:end2]
                        Remove the residues at the specified indices. Same
                        format as `--cut`.
  --dash-gap            Replace any of the characters "?.:~" with a "-" for
                        all sequences
  --lower               Translate the sequences to lower case
  --mask start1:end1[,start2:end2]
                        Replace residues in 1-indexed slice with gap-
                        characters. If --relative-to is also specified,
                        coordinates are relative to the sequence ID provided.
  --reverse             Reverse the order of sites in sequences
  --reverse-complement  Convert sequences into reverse complements
  --squeeze             Remove any gaps that are present in the same position
                        across all sequences in an alignment (equivalent to
                        --squeeze-threshold=1.0)
  --squeeze-threshold PROP
                        Trim columns from an alignment which have gaps in
                        least the specified proportion of sequences.
  --transcribe {dna2rna,rna2dna}
                        Transcription and back transcription for generic DNA
                        and RNA. Source sequences must be the correct alphabet
                        or this action will likely produce incorrect results.
  --translate {dna2protein,rna2protein,dna2proteinstop,rna2proteinstop}
                        Translate from generic DNA/RNA to proteins. Options
                        with "stop" suffix will NOT translate through stop
                        codons . Source sequences must be the correct alphabet
                        or this action will likely produce incorrect results.
  --ungap               Remove gaps in the sequence alignment
  --upper               Translate the sequences to upper case

Record Selection:
  --deduplicate-sequences
                        Remove any duplicate sequences by sequence content,
                        keep the first instance seen
  --deduplicated-sequences-file FILE
                        Write all of the deduplicated sequences to a file
  --deduplicate-taxa    Remove any duplicate sequences by ID, keep the first
                        instance seen
  --exclude-from-file FILE
                        Filter sequences, removing those sequence IDs in the
                        specified file
  --include-from-file FILE
                        Filter sequences, keeping only those sequence IDs in
                        the specified file
  --head N              Trim down to top N sequences. With the leading `-',
                        print all but the last N sequences.
  --max-length N        Discard any sequences beyond the specified maximum
                        length. This operation occurs *before* all length-
                        changing options such as cut and squeeze.
  --min-length N        Discard any sequences less than the specified minimum
                        length. This operation occurs *before* cut and
                        squeeze.
  --min-ungapped-length N
                        Discard any sequences less than the specified minimum
                        length, excluding gaps. This operation occurs *before*
                        cut and squeeze.
  --pattern-include REGEX
                        Filter the sequences by regular expression in ID or
                        description
  --pattern-exclude REGEX
                        Filter the sequences by regular expression in ID or
                        description
  --prune-empty         Prune sequences containing only gaps ('-')
  --sample N            Select a random sampling of sequences
  --sample-seed N       Set random seed for sampling of sequences
  --seq-pattern-include REGEX
                        Filter the sequences by regular expression in sequence
  --seq-pattern-exclude REGEX
                        Filter the sequences by regular expression in sequence
  --tail N              Trim down to bottom N sequences. Use +N to output
                        sequences starting with the Nth.

Sequence ID Modification:
  --first-name          Take only the first whitespace-delimited word as the
                        name of the sequence
  --name-suffix SUFFIX  Append a suffix to all IDs.
  --name-prefix PREFIX  Insert a prefix for all IDs.
  --pattern-replace search_pattern replace_pattern
                        Replace regex pattern "search_pattern" with
                        "replace_pattern" in sequence ID and description
  --strip-range         Strip ranges from sequences IDs, matching </x-y>

Format Options:
  --input-format FORMAT
                        Input file format (default: determine from extension)
  --output-format FORMAT
                        Output file format (default: determine from extension)

Filters using regular expressions are case-sensitive by default. Append "(?i)"
to a pattern to make it case-insensitive.
```


## seqmagick_info

### Tool Description
Info action

### Metadata
- **Docker Image**: quay.io/biocontainers/seqmagick:0.8.6--pyhdfd78af_0
- **Homepage**: http://github.com/fhcrc/seqmagick
- **Package**: https://anaconda.org/channels/bioconda/packages/seqmagick/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqmagick info [-h] [--input-format INPUT_FORMAT]
                      [--out-file destination_file] [--format {tab,csv,align}]
                      [--threads THREADS]
                      sequence_files [sequence_files ...]

Info action

positional arguments:
  sequence_files

options:
  -h, --help            show this help message and exit
  --input-format INPUT_FORMAT
                        Input format. Overrides extension for all input files
  --out-file destination_file
                        Output destination. Default: STDOUT
  --format {tab,csv,align}
                        Specify output format as tab-delimited, CSV or aligned
                        in a borderless table. Default is tab-delimited if the
                        output is directed to a file, aligned if output to the
                        console.
  --threads THREADS     Number of threads (CPUs). [1]
```


## seqmagick_mogrify

### Tool Description
Modify sequence file(s) in place.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqmagick:0.8.6--pyhdfd78af_0
- **Homepage**: http://github.com/fhcrc/seqmagick
- **Package**: https://anaconda.org/channels/bioconda/packages/seqmagick/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqmagick mogrify [-h] [--line-wrap N]
                         [--sort {length-asc,length-desc,name-asc,name-desc}]
                         [--apply-function /path/to/module.py:function_name[:parameter]]
                         [--cut start:end[,start2:end2]] [--relative-to ID]
                         [--drop start:end[,start2:end2]] [--dash-gap]
                         [--lower] [--mask start1:end1[,start2:end2]]
                         [--reverse] [--reverse-complement] [--squeeze]
                         [--squeeze-threshold PROP]
                         [--transcribe {dna2rna,rna2dna}]
                         [--translate {dna2protein,rna2protein,dna2proteinstop,rna2proteinstop}]
                         [--ungap] [--upper] [--deduplicate-sequences]
                         [--deduplicated-sequences-file FILE]
                         [--deduplicate-taxa] [--exclude-from-file FILE]
                         [--include-from-file FILE] [--head N]
                         [--max-length N] [--min-length N]
                         [--min-ungapped-length N] [--pattern-include REGEX]
                         [--pattern-exclude REGEX] [--prune-empty]
                         [--sample N] [--sample-seed N]
                         [--seq-pattern-include REGEX]
                         [--seq-pattern-exclude REGEX] [--tail N]
                         [--first-name] [--name-suffix SUFFIX]
                         [--name-prefix PREFIX]
                         [--pattern-replace search_pattern replace_pattern]
                         [--strip-range] [--input-format FORMAT]
                         [--output-format FORMAT]
                         [--alphabet {dna,dna-ambiguous,rna,rna-ambiguous,protein}]
                         sequence_file [sequence_file ...]

Modify sequence file(s) in place.

positional arguments:
  sequence_file         Sequence file(s) to mogrify

options:
  -h, --help            show this help message and exit
  --alphabet {dna,dna-ambiguous,rna,rna-ambiguous,protein}
                        Input alphabet. Required for writing NEXUS.

Sequence File Modification:
  --line-wrap N         Adjust line wrap for sequence strings. When N is 0,
                        all line breaks are removed. Only fasta files are
                        supported for the output format.
  --sort {length-asc,length-desc,name-asc,name-desc}
                        Perform sorting by length or name, ascending or
                        descending. ASCII sorting is performed for names

Sequence Modificaton:
  --apply-function /path/to/module.py:function_name[:parameter]
                        Specify a custom function to apply to the input
                        sequences, specified as
                        /path/to/file.py:function_name. Function should accept
                        an iterable of Bio.SeqRecord objects, and yield
                        SeqRecords. If the parameter is specified, it will be
                        passed as a string as the second argument to the
                        function. Specify more than one to chain.
  --cut start:end[,start2:end2]
                        Keep only the residues within the 1-indexed start and
                        end positions specified, : separated. Includes last
                        item. Start or end can be left unspecified to indicate
                        start/end of sequence. A negative start may be
                        provided to indicate an offset from the end of the
                        sequence. Note that to prevent negative numbers being
                        interpreted as flags, this should be written with an
                        equals sign between `--cut` and the argument, e.g.:
                        `--cut=-10:`
  --relative-to ID      Apply --cut relative to the indexes of non-gap
                        residues in sequence identified by ID
  --drop start:end[,start2:end2]
                        Remove the residues at the specified indices. Same
                        format as `--cut`.
  --dash-gap            Replace any of the characters "?.:~" with a "-" for
                        all sequences
  --lower               Translate the sequences to lower case
  --mask start1:end1[,start2:end2]
                        Replace residues in 1-indexed slice with gap-
                        characters. If --relative-to is also specified,
                        coordinates are relative to the sequence ID provided.
  --reverse             Reverse the order of sites in sequences
  --reverse-complement  Convert sequences into reverse complements
  --squeeze             Remove any gaps that are present in the same position
                        across all sequences in an alignment (equivalent to
                        --squeeze-threshold=1.0)
  --squeeze-threshold PROP
                        Trim columns from an alignment which have gaps in
                        least the specified proportion of sequences.
  --transcribe {dna2rna,rna2dna}
                        Transcription and back transcription for generic DNA
                        and RNA. Source sequences must be the correct alphabet
                        or this action will likely produce incorrect results.
  --translate {dna2protein,rna2protein,dna2proteinstop,rna2proteinstop}
                        Translate from generic DNA/RNA to proteins. Options
                        with "stop" suffix will NOT translate through stop
                        codons . Source sequences must be the correct alphabet
                        or this action will likely produce incorrect results.
  --ungap               Remove gaps in the sequence alignment
  --upper               Translate the sequences to upper case

Record Selection:
  --deduplicate-sequences
                        Remove any duplicate sequences by sequence content,
                        keep the first instance seen
  --deduplicated-sequences-file FILE
                        Write all of the deduplicated sequences to a file
  --deduplicate-taxa    Remove any duplicate sequences by ID, keep the first
                        instance seen
  --exclude-from-file FILE
                        Filter sequences, removing those sequence IDs in the
                        specified file
  --include-from-file FILE
                        Filter sequences, keeping only those sequence IDs in
                        the specified file
  --head N              Trim down to top N sequences. With the leading `-',
                        print all but the last N sequences.
  --max-length N        Discard any sequences beyond the specified maximum
                        length. This operation occurs *before* all length-
                        changing options such as cut and squeeze.
  --min-length N        Discard any sequences less than the specified minimum
                        length. This operation occurs *before* cut and
                        squeeze.
  --min-ungapped-length N
                        Discard any sequences less than the specified minimum
                        length, excluding gaps. This operation occurs *before*
                        cut and squeeze.
  --pattern-include REGEX
                        Filter the sequences by regular expression in ID or
                        description
  --pattern-exclude REGEX
                        Filter the sequences by regular expression in ID or
                        description
  --prune-empty         Prune sequences containing only gaps ('-')
  --sample N            Select a random sampling of sequences
  --sample-seed N       Set random seed for sampling of sequences
  --seq-pattern-include REGEX
                        Filter the sequences by regular expression in sequence
  --seq-pattern-exclude REGEX
                        Filter the sequences by regular expression in sequence
  --tail N              Trim down to bottom N sequences. Use +N to output
                        sequences starting with the Nth.

Sequence ID Modification:
  --first-name          Take only the first whitespace-delimited word as the
                        name of the sequence
  --name-suffix SUFFIX  Append a suffix to all IDs.
  --name-prefix PREFIX  Insert a prefix for all IDs.
  --pattern-replace search_pattern replace_pattern
                        Replace regex pattern "search_pattern" with
                        "replace_pattern" in sequence ID and description
  --strip-range         Strip ranges from sequences IDs, matching </x-y>

Format Options:
  --input-format FORMAT
                        Input file format (default: determine from extension)
  --output-format FORMAT
                        Output file format (default: determine from extension)

Filters using regular expressions are case-sensitive by default. Append "(?i)"
to a pattern to make it case-insensitive.
```


## seqmagick_quality-filter

### Tool Description
Filter reads based on quality scores

### Metadata
- **Docker Image**: quay.io/biocontainers/seqmagick:0.8.6--pyhdfd78af_0
- **Homepage**: http://github.com/fhcrc/seqmagick
- **Package**: https://anaconda.org/channels/bioconda/packages/seqmagick/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqmagick quality-filter [-h] [--input-qual INPUT_QUAL]
                                [--report-out REPORT_OUT]
                                [--details-out DETAILS_OUT]
                                [--no-details-comment]
                                [--min-mean-quality QUALITY]
                                [--min-length LENGTH] [--max-length LENGTH]
                                [--quality-window-mean-qual QUALITY_WINDOW_MEAN_QUAL]
                                [--quality-window-prop QUALITY_WINDOW_PROP]
                                [--quality-window WINDOW_SIZE]
                                [--ambiguous-action {truncate,drop}]
                                [--max-ambiguous MAX_AMBIGUOUS]
                                [--pct-ambiguous PCT_AMBIGUOUS]
                                [--primer PRIMER | --no-primer]
                                [--barcode-file BARCODE_FILE]
                                [--barcode-header] [--map-out SAMPLE_MAP]
                                [--quoting {QUOTE_ALL,QUOTE_MINIMAL,QUOTE_NONE,QUOTE_NONNUMERIC}]
                                sequence_file output_file

Filter reads based on quality scores

positional arguments:
  sequence_file         Input fastq file. A fasta-format file may also be
                        provided if --input-qual is also specified.
  output_file           Output file. Format determined from extension.

options:
  -h, --help            show this help message and exit
  --input-qual INPUT_QUAL
                        The quality scores associated with the input file.
                        Only used if input file is fasta.
  --min-mean-quality QUALITY
                        Minimum mean quality score for each read [default:
                        25.0]
  --min-length LENGTH   Minimum length to keep sequence [default: 200]
  --max-length LENGTH   Maximum length to keep before truncating [default:
                        1000]. This operation occurs before --max-ambiguous
  --ambiguous-action {truncate,drop}
                        Action to take on ambiguous base in sequence (N's).
                        [default: no action]
  --max-ambiguous MAX_AMBIGUOUS
                        Maximum number of ambiguous bases in a sequence.
                        Sequences exceeding this count will be removed.
  --pct-ambiguous PCT_AMBIGUOUS
                        Maximun percent of ambiguous bases in a sequence.
                        Sequences exceeding this percent will be removed.

Output:
  --report-out REPORT_OUT
                        Output file for report [default: stdout]
  --details-out DETAILS_OUT
                        Output file to report fate of each sequence
  --no-details-comment  Do not write comment lines with version and call to
                        start --details-out

Quality window options:
  --quality-window-mean-qual QUALITY_WINDOW_MEAN_QUAL
                        Minimum quality score within the window defined by
                        --quality-window. [default: same as --min-mean-
                        quality]
  --quality-window-prop QUALITY_WINDOW_PROP
                        Proportion of reads within quality window to that must
                        pass filter. Floats are [default: 1.0]
  --quality-window WINDOW_SIZE
                        Window size for truncating sequences. When set to a
                        non-zero value, sequences are truncated where the mean
                        mean quality within the window drops below --min-mean-
                        quality. [default: 0]

Barcode/Primer:
  --primer PRIMER       IUPAC ambiguous primer to require
  --no-primer           Do not use a primer.
  --barcode-file BARCODE_FILE
                        CSV file containing sample_id,barcode[,primer] in the
                        rows. A single primer for all sequences may be
                        specified with `--primer`, or `--no-primer` may be
                        used to indicate barcodes should be used without a
                        primer check.
  --barcode-header      Barcodes have a header row [default: False]
  --map-out SAMPLE_MAP  Path to write sequence_id,sample_id pairs
  --quoting {QUOTE_ALL,QUOTE_MINIMAL,QUOTE_NONE,QUOTE_NONNUMERIC}
                        A string naming an attribute of the csv module
                        defining the quoting behavior for `SAMPLE_MAP`.
                        [default: QUOTE_MINIMAL]
```


## seqmagick_extract-ids

### Tool Description
Extract the sequence IDs from a file

### Metadata
- **Docker Image**: quay.io/biocontainers/seqmagick:0.8.6--pyhdfd78af_0
- **Homepage**: http://github.com/fhcrc/seqmagick
- **Package**: https://anaconda.org/channels/bioconda/packages/seqmagick/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqmagick extract-ids [-h] [-o OUTPUT_FILE]
                             [--input-format INPUT_FORMAT] [-d]
                             sequence_file

Extract the sequence IDs from a file

positional arguments:
  sequence_file         Sequence file

options:
  -h, --help            show this help message and exit
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        Destination file
  --input-format INPUT_FORMAT
                        Input format for sequence file
  -d, --include-description
                        Include the sequence description in output [default:
                        False]
```


## seqmagick_backtrans-align

### Tool Description
Given a protein alignment and unaligned nucleotides, align the nucleotides using the protein alignment. Protein and nucleotide sequence files must contain the same number of sequences, in the same order, with the same IDs.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqmagick:0.8.6--pyhdfd78af_0
- **Homepage**: http://github.com/fhcrc/seqmagick
- **Package**: https://anaconda.org/channels/bioconda/packages/seqmagick/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqmagick backtrans-align [-h] [-o destination_file]
                                 [-t {standard,standard-ambiguous,vertebrate-mito}]
                                 [-a {fail,warn,none}]
                                 protein_align nucl_align

Given a protein alignment and unaligned nucleotides, align the nucleotides
using the protein alignment. Protein and nucleotide sequence files must
contain the same number of sequences, in the same order, with the same IDs.

positional arguments:
  protein_align         Protein Alignment
  nucl_align            FASTA Alignment

options:
  -h, --help            show this help message and exit
  -o destination_file, --out-file destination_file
                        Output destination. Default: STDOUT
  -t {standard,standard-ambiguous,vertebrate-mito}, --translation-table {standard,standard-ambiguous,vertebrate-mito}
                        Translation table to use. [Default: standard-
                        ambiguous]
  -a {fail,warn,none}, --fail-action {fail,warn,none}
                        Action to take on an ambiguous codon [default: fail]
```


## Metadata
- **Skill**: generated
