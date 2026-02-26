# pheniqs CWL Generation Report

## pheniqs_mux

### Tool Description
Multiplex and Demultiplex annotated DNA sequence reads

### Metadata
- **Docker Image**: quay.io/biocontainers/pheniqs:2.1.0--py38h1b92da4_7
- **Homepage**: http://biosails.github.io/pheniqs
- **Package**: https://anaconda.org/channels/bioconda/packages/pheniqs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pheniqs/overview
- **Total Downloads**: 34.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biosails/pheniqs
- **Stars**: N/A
### Original Help Text
```text
pheniqs version 2.1.0
Multiplex and Demultiplex annotated DNA sequence reads

Usage : pheniqs mux [-h] [-i PATH]* [-o PATH]* [-c PATH] [-R PATH]
                    [--prior PATH] [-I URL] [-O URL] [-s] [-n] [-N] [-l INT]
                    [-F fastq|sam|bam|cram] [-Z none|gz|bgzf] [-L 0|1|2|3|4|5|6|7|8|9]
                    [-T SEGMENT:START:END]*
                    [-P CAPILLARY|LS454|ILLUMINA|SOLID|HELICOS|IONTORRENT|ONT|PACBIO] [-q] [-V]
                    [-D] [-C] [-S] [-j] [-t INT] [--decoding-threads INT] [--htslib-threads INT]
                    [-B INT] [--precision INT]
Optional :
  -h, --help                       Show this help
  -i, --input PATH                 Path to an input file. May be repeated.
  -o, --output PATH                Path to an output file. May be repeated.
  -c, --config PATH                Path to configuration file
  -R, --report PATH                Path to report file
  --prior PATH                     Path to adjusted prior job file
  -I, --base-input URL             Base input url
  -O, --base-output URL            Base output url
  -s, --sense-input                Sense input segment layout
  -n, --no-output-npf              Filter outgoing QC failed reads
  -N, --no-input-npf               Filter incoming QC failed reads.
  -l, --leading INT                Leading read segment index
  -F, --format STRING              Defult output format
  -Z, --compression STRING         Defult output compression
  -L, --level STRING               Defult output compression level
  -T, --token SEGMENT:START:END    Output read token
  -P, --platform STRING            Sequencing platform
  -q, --quality                    Enable quality control
  -V, --validate                   Validate configuration file and emit a report
  -D, --distance                   Display pairwise barcode distance during validation
  -C, --compile                    Compiled JSON configuration file
  -S, --static                     Static configuration JSON file
  -j, --job                        Include a copy of the compiled job in the report
  -t, --threads INT                Thread pool size
  --decoding-threads INT           Number of parallel decoding threads
  --htslib-threads INT             Size of htslib thread pool size
  -B, --buffer INT                 Feed buffer capacity
  --precision INT                  Output floating point precision

  -i/--input defaults to /dev/stdin with inputing layout sensing.
  -o/--output default to /dev/stdout with SAM format.
  -I/--base-input and -O/--base-output default to the working directory.
  -V/--validate, -C/--compile and -S/--static disable job excution and only emit information.
  -s/--sense-input will guess input layout by examining the first few reads of each input file.
  -S/--static emits a static configuration file with all imports resolved.
  -C/--compile emits a compiled configuration file ready for execution with implicit attributes resolved.
  -i/--input and -o/--output can be repeated to provide multiple paths,
  i.e. `pheniqs mux -i in_segment_1.fastq -i in_segment_2.fastq -o out_segment_1.fastq -o out_segment_2.fastq`

This program comes with ABSOLUTELY NO WARRANTY. This is free software,
and you are welcome to redistribute it under certain conditions.
```

