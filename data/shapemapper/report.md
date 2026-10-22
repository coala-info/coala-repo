# shapemapper CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| shapemapper | Failed | image problem: the command shapemapper is not in the image (1.2 has only ShapeMapper.py, 2.3.2 has only helper programs) |
| shapemapper_mutation_counter | PASS |  |
| shapemapper_mutation_parser | PASS |  |
| shapemapper_read_trimmer | PASS |  |
| shapemapper_tab_to_shape.py | PASS | synthetic data: reactivity table computed from real mutation counts of the example reads |

## shapemapper

### Tool Description
ShapeMapper automates the extraction of SHAPE reactivity profiles from chemical probing multi-stage sequencing experiments.

### Metadata
- **Docker Image**: quay.io/biocontainers/shapemapper:1.2--py27_0
- **Homepage**: https://github.com/Weeks-UNC/shapemapper2
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/shapemapper/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Weeks-UNC/shapemapper2
- **Stars**: N/A
### Original Help Text
```text
Unable to find image 'quay.io/biocontainers/shapemapper:1.2--py27_0' locally
1.2--py27_0: Pulling from biocontainers/shapemapper
a3ed95caeb02: Already exists
b0dc45cd432d: Already exists
3aaade50789a: Already exists
ddd482ea7b54: Already exists
7ff999a2256f: Already exists
e7c454e5167d: Already exists
dfda3e01f2b6: Already exists
a3ed95caeb02: Already exists
10c3bb32200b: Already exists
ba30bc8eed85: Pulling fs layer
docker: write /var/lib/docker/tmp/GetImageBlob3912209193: no space left on device

Run 'docker run --help' for more information
```

## shapemapper_mutation_parser

### Tool Description
Parse mutations from a SAM alignment file (ShapeMapper mutation parser).

### Metadata
- **Docker Image**: quay.io/biocontainers/shapemapper:2.3.2--h5814d7d_0
- **Homepage**: https://github.com/Weeks-UNC/shapemapper2
- **Package**: https://anaconda.org/channels/bioconda/packages/shapemapper/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  -h [ --help ]                         print usage message
  -i [ --in ] arg                       SAM input file path
  -o [ --out ] arg                      parsed mutations output file path
  -d [ --debug_out ] arg                intermediate debug info file path
  --max_paired_fragment_length arg (=800)
                                        analogous to bowtie2's --maxins param. 
                                        Paired reads mapping to a fragment size
                                        above this threshold will be treated as
                                        separate reads.
  -m [ --min_mapq ] arg (=30)           minimum reported mapping quality to 
                                        allow
  --exclude_3prime arg (=0)             exclude mutations occurring within this
                                        many nucleotides of 3-prime end of read
  --input_is_unpaired                   specify that reads are unpaired (as 
                                        opposed to paired and/or unmerged 
                                        paired reads)
  --N7                                  specify that reads are unpaired (as 
                                        opposed to paired and/or unmerged 
                                        paired reads)
  --primers arg
  --trim_primers 
  --require_forward_primer_mapped 
  --require_reverse_primer_mapped 
  --max_primer_offset arg (=0)
  --right_align_ambig_dels              realign ambiguously aligned deletions 
                                        to right end (not recommended), 
                                        otherwise realign left
  --right_align_ambig_ins               realign ambiguously aligned insertions 
                                        to right end (not recommended), 
                                        otherwise realign left
  --max_internal_match arg (=7)         allow up to N unchanged reference 
                                        sequence nucs between merged mutations
  --min_qual arg (=30)                  Exclude mutations that contain or are 
                                        adjacent to any basecalls with Phred 
                                        quality scores below this value. This 
                                        filter is also applied to the 
                                        calculation of the effective read 
                                        depth.
  --use_only_mutation_type arg          Default is to include all mutation 
                                        types. Passing dms will process data 
                                        using DMS mutation signatures. Other 
                                        possible values (though not 
                                        recommended). mismatch gap insert 
                                        gap_multi insert_multi complex
  -v [ --variant_mode ]                 If true, nearby mutation merging and 
                                        ambiguous mutation realignment steps 
                                        will not be performed. Used by 
                                        shapemapper to simplify sequence 
                                        variant detection, i.e. SNP calling.
  --debug                               print debugging information
  -w [ --warn_on_no_mapped ]            exit with warning instead of error if 
                                        no mapped reads present in input
```

## shapemapper_mutation_counter

### Tool Description
Count mutations from parsed mutation files (ShapeMapper mutation counter).

### Metadata
- **Docker Image**: quay.io/biocontainers/shapemapper:2.3.2--h5814d7d_0
- **Homepage**: https://github.com/Weeks-UNC/shapemapper2
- **Package**: https://anaconda.org/channels/bioconda/packages/shapemapper/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  -h [ --help ]                    print usage message
  -i [ --in ] arg                  input file path(s) (parsed mutations). 
                                   comma-separated
  -n [ --length ] arg (=0)         length of reference sequence. If provided, 
                                   output files are guaranteed to have this 
                                   many lines even if there are regions of no 
                                   read coverage.
  -p [ --n_primer_pairs ] arg (=0) number of primer pairs (if any) previously 
                                   used for read mapping location filtering. If
                                   provided, read mapping depth columns will be
                                   split up by amplicon.
  -v [ --variant_out ] arg         sequence variant counts output file path
  -c [ --count_out ] arg           mutation counts output file path
  -h [ --hist ]                    output read length and mutation frequency 
                                   histogram tables
  -s [ --input_is_sorted ]         use less memory if scanning along mutations 
                                   from a BAM file sorted by leftmost alignment
                                   position
  --separate_ambig_counts          output ambiguously aligned derived mutation 
                                   counts in separate columns
  --debug                          debug info
  -w [ --warn_on_no_mapped ]       exit with warning instead of error if no 
                                   mapped reads present in input
```

## shapemapper_read_trimmer

### Tool Description
Trim low-quality ends of reads in a FASTQ file (ShapeMapper read trimmer).

### Metadata
- **Docker Image**: quay.io/biocontainers/shapemapper:2.3.2--h5814d7d_0
- **Homepage**: https://github.com/Weeks-UNC/shapemapper2
- **Package**: https://anaconda.org/channels/bioconda/packages/shapemapper/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  -h [ --help ]                 print usage message
  -i [ --in ] arg               FASTQ input file path
  -o [ --out ] arg              trimmed FASTQ output file path
  -w [ --window_size ] arg (=5) size of window to average quality scores
  -p [ --min_phred ] arg (=20)  minimum average quality score to allow
  -l [ --min_length ] arg (=25) minimum trimmed read length to allow
```

## shapemapper_tab_to_shape.py

### Tool Description
Convert a ShapeMapper reactivity profile table to .map, .shape, VARNA and RiboSketch formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/shapemapper:2.3.2--h5814d7d_0
- **Homepage**: https://github.com/Weeks-UNC/shapemapper2
- **Package**: https://anaconda.org/channels/bioconda/packages/shapemapper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tab_to_shape.py [-h] --infile INFILE [--map MAP] [--shape SHAPE]
                       [--varna VARNA] [--ribosketch RIBOSKETCH]

options:
  -h, --help            show this help message and exit
  --infile INFILE       Tab-delimited input file containing reactivity profile
                        and stderrs.
  --map MAP
  --shape SHAPE
  --varna VARNA
  --ribosketch RIBOSKETCH
```

