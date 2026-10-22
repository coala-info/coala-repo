# transposcope CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| transposcope_align | Not completed | no usable test data: needs MELT or TIPseqHunter output, a BAM, a LINE-1 reference and host chromosome FASTAs; no sample set is published |

## transposcope_align

### Tool Description
Local realignment of reads flanking a potential mobile element insertion site.

### Metadata
- **Docker Image**: quay.io/biocontainers/transposcope:2.0.1--py_0
- **Homepage**: https://github.com/FenyoLab/transposcope
- **Package**: https://anaconda.org/channels/bioconda/packages/transposcope/overview
- **Validation**: PASS

### Original Help Text
```text
[help] transposcope align: ok via transposcope align --help (--help=ok, -h=ok, -help=flag_rejected, (no args)=subcommands)
usage: TranspoScope align [-h] [--genes GENES] [--group1 GROUP1]
                          [--group2 GROUP2] [--keep_files]
                          {melt,tipseqhunter} index bam me_reference
                          host_reference sample_id

positional arguments:
  {melt,tipseqhunter}  The software used to identify insertions
  index                The path to the index file which describes the
                       coordinates of insertion sites
  bam                  path to bam file
  me_reference         path to the mobile element's FASTA file
  host_reference       path to a folder containing all of the chromosome FASTA
                       files for the host genome
  sample_id            Unique name to for the given experiment. This is used
                       to label the output.

optional arguments:
  -h, --help           show this help message and exit
  --genes GENES        Path to refFlat.txt (If information regarding the
                       nearest gene should be included.)
  --group1 GROUP1      First level group tag (default: ungrouped)
  --group2 GROUP2      Second level group tag (default: ungrouped)
  --keep_files         Flag which determines whether intermediate bam files
                       and fasta files are deleted (default: False)
```

## Metadata
- **Skill**: not generated
