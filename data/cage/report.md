# cage CWL Generation Report

## cage

### Tool Description
Changepoint detection for efficient variant calling

### Metadata
- **Docker Image**: quay.io/biocontainers/cage:2016.05.13--he8c0b07_8
- **Homepage**: https://github.com/docker/cagent
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cage/overview
- **Total Downloads**: 25.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/docker/cagent
- **Stars**: N/A
### Original Help Text
```text
USAGE: 

   cage  {-o <VCF_output_file>|-s <SNP_input_db>} [-v] [--] [--version]
         [-h] <contig> <start> <end> <stepsize> <beta> <cage_output_file>


Where: 

   -o <VCF_output_file>,  --output_vcf <VCF_output_file>
     (OR required)  File to output variants called when running CAGe
         -- OR --
   -s <SNP_input_db>,  --input_SNP_db <SNP_input_db>
     (OR required)  Filename of sqlite3 SNP database


   -v,  --verbose
     print verbose output of CAGe

   --,  --ignore_rest
     Ignores the rest of the labeled arguments following this flag.

   --version
     Displays version information and exits.

   -h,  --help
     Displays usage information and exits.

   <contig>
     (required)  contig name

   <start>
     (required)  start position

   <end>
     (required)  end position

   <stepsize>
     (required)  step size

   <beta>
     (required)  beta parameter for PELT

   <cage_output_file>
     (required)  File to output the changepoints determined by CAGe


   CAGe - Changepoint detection for efficient variant calling
```

