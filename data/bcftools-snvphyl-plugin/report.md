# bcftools-snvphyl-plugin CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bcftools-snvphyl-plugin_filter_snv_density | PASS |  |

## bcftools-snvphyl-plugin_filter_snv_density

### Tool Description
bcftools plugin that finds SNV high-density regions of the genome and writes them to a region file

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools-snvphyl-plugin:1.9--h4da6232_0
- **Homepage**: https://github.com/phac-nml/snvphyl-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools-snvphyl-plugin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bcftools-snvphyl-plugin/overview
- **Total Downloads**: 24.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/phac-nml/snvphyl-tools
- **Stars**: N/A

### Original Help Text
```text
About:   Run user defined plugin
Usage:   bcftools plugin <name> [OPTIONS] <file> [-- PLUGIN_OPTIONS]
         bcftools +name [OPTIONS] <file>  [-- PLUGIN_OPTIONS]

VCF input options:
   -e, --exclude <expr>        exclude sites for which the expression is true
   -i, --include <expr>        select sites for which the expression is true
   -r, --regions <region>      restrict to comma-separated list of regions
   -R, --regions-file <file>   restrict to regions listed in a file
   -t, --targets <region>      similar to -r but streams rather than index-jumps
   -T, --targets-file <file>   similar to -R but streams rather than index-jumps
VCF output options:
       --no-version            do not append version and command line to the header
   -o, --output <file>         write output to a file [standard output]
   -O, --output-type <type>    'b' compressed BCF; 'u' uncompressed BCF; 'z' compressed VCF; 'v' uncompressed VCF [v]
       --threads <int>         number of extra output compression threads [0]
Plugin options:
   -h, --help                  list plugin's options
   -l, --list-plugins          list available plugins. See BCFTOOLS_PLUGINS environment variable and man page for details
   -v, --verbose               print verbose information, -vv increases verbosity
   -V, --version               print version string and exit



Plugin filter_snv_density:
   A plugin which filters on freebayes for SNV's deemed to be within high density regions of the genome.
   (The plugin prints no option help; options below are from bcfplugins/filter_snv_density.c in phac-nml/snvphyl-tools.)

PLUGIN_OPTIONS (after --):
   --filename <file>           input VCF file name (stored, not otherwise used)
   --region_file <file>        output file; high-density regions are appended as <chrom> <start> <end>
   --window_size <int>         window size in bases [100]
   --threshold <int>           number of SNVs in a window that makes it high density [10]
```

