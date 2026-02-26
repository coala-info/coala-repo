# extract-sv-reads CWL Generation Report

## extract-sv-reads

### Tool Description
Extracts split and discordant reads from BAM/CRAM/SAM files for structural variant analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/extract-sv-reads:1.3.0--pl5321h9948957_6
- **Homepage**: https://github.com/hall-lab/extract_sv_reads
- **Package**: https://anaconda.org/channels/bioconda/packages/extract-sv-reads/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/extract-sv-reads/overview
- **Total Downloads**: 30.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hall-lab/extract_sv_reads
- **Stars**: N/A
### Original Help Text
```text
ERROR: the option '--discordant' is required but missing

Usage: extract-sv-reads [OPTIONS...] <input_file> <splitter_file> <discordant_file>

Examples:
	extract-sv-reads input.bam splitters.bam discordants.bam
	extract-sv-reads -i input.bam -s splitters.bam -d discordants.bam
	extract-sv-reads -e -r --threads 4 -T /path/to/reference.fa \
	  -i input.cram -s splitters.bam -d discordants.bam

Notes:
	-T is only useful when the input file is a CRAM.

	When parsing CRAM, extract-sv-reads will download the entire reference
	used to encode the CRAM from EBI unless the -T option is specified to the
	proper local reference. This is both slow and may fill up your home
	directory. See the REF_PATH and REF_CACHE documentation of htslib and
	samtools for more information.

Available options:
  -h [ --help ]                  produce this message
  -v [ --version ]               output the version
  -i [ --input ] arg (=-)        input BAM/CRAM/SAM. Use '-' for stdin if using
                                 positional arguments
  -s [ --splitter ] arg          output split reads to this file in BAM format 
                                 (Required)
  -d [ --discordant ] arg        output discordant reads to this file in BAM 
                                 format (Required)
  -T [ --reference ] arg         reference sequence used to encode CRAM file, 
                                 recommended if reading CRAM
  -e [ --exclude-dups ]          exclude duplicate reads from output
  -r [ --reduce-output-bams ]    remove sequences and qualities from output 
                                 bams
  -n [ --with-nm ]               ensure NM tag is present in output if reading 
                                 CRAM file
  --max-unmapped-bases arg (=50) maximum number of unaligned bases between two 
                                 alignments to be included in the splitter file
  --min-indel-size arg (=50)     minimum structural variant feature size for 
                                 split alignments to be included in the 
                                 splitter file
  --min-non-overlap arg (=20)    minimum number of non-overlapping base pairs 
                                 between two alignments for a read to be 
                                 included in the splitter file
  --threads arg (=1)             number of threads to use
```

