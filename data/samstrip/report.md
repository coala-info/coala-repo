# samstrip CWL Generation Report

## samstrip

### Tool Description
Reads a SAM file from stdin, and prints the equivalent stripped file to stdout. A stripped file has the SEQ and QUAL fields removed, and auxiliary tags depending on the setting. Barring any aligner-specific auxiliary tags, a stripped SAM file contain the same alignment information as a full file, but takes up less disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/samstrip:0.2.1--h4349ce8_0
- **Homepage**: https://github.com/jakobnissen/samstrip
- **Package**: https://anaconda.org/channels/bioconda/packages/samstrip/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/samstrip/overview
- **Total Downloads**: 650
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jakobnissen/samstrip
- **Stars**: N/A
### Original Help Text
```text
Reads a SAM file from stdin, and prints the equivalent stripped file to stdout.
A stripped file has the SEQ and QUAL fields removed, and auxiliary tags depending
on the setting.
Barring any aligner-specific auxiliary tags, a stripped SAM file contain the same
alignment information as a full file, but takes up less disk space.

The program optionally takes `--keep`, a list of auxiliary tags to keep in the output.
This defaults to 'NM', which many tools assume is always present.
Examples:
`cat in | samstrip > out` - default: keep tag 'NM' only
`cat in | samstrip --keep NM AS rl > out` - keep tags 'NM', 'AS', 'rl'
`cat in | samstrip --keep > out` - do not keep any tags

Similarly, the `--remove` option only removes the given tags. If no tags are passed,
to `--remove`, all tags are kept.

Example usage:
Stripping an exiting BAM file:
`samtools view -h file.bam | samstrip | samtools view -b - > stripped.bam`

Stripping a BAM file while creating it:
`minimap2 -ax sr ref.fa fw.fq rv.fq | samstrip | samtools view -b - > file.bam`

Usage: samstrip [OPTIONS]

Options:
      --keep [<KEEP>...]
          List of aux tags to keep in file (default: NM)

      --remove [<REMOVE>...]
          List of aux tags to remove (incompatible with --keep)

      --noheader
          Allow input without SAM header

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

