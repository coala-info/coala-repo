# polymutt CWL Generation Report

## polymutt

### Tool Description
Polymutt is a tool for genotype likelihood calculation and variant calling.

### Metadata
- **Docker Image**: quay.io/biocontainers/polymutt:0.18--0
- **Homepage**: https://genome.sph.umich.edu/wiki/Polymutt
- **Package**: https://anaconda.org/channels/bioconda/packages/polymutt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/polymutt/overview
- **Total Downloads**: 5.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
*** This build (v.0.16) was compiled on Nov  6 2017, 22:17:09 ***

The following parameters are in effect:
                       pedfile :                 (-pname)
                       datfile :                 (-dname)
                  glfIndexFile :                 (-gname)
              posterior cutoff :            0.50 (-c99.999)

Additional Options
   Alternative input file : --in_vcf [], --mixed_vcf_records
     Scaled mutation rate : --theta [1.0e-03], --indel_theta [1.0e-04]
     Prior of ts/tv ratio : --poly_tstv [2.00]
      Non-autosome labels : --chrX [X], --chrY [Y], --MT [MT]
         de novo mutation : --denovo, --rate_denovo [1.5e-08],
                            --tstv_denovo [2.00], --minLLR_denovo [-3.0e+00]
   Optimization precision : --prec [1.0e-04]
       Multiple threading : --nthreads [1]
                  Filters : --minMapQuality, --minDepth, --maxDepth,
                            --minPercSampleWithData [0.00]
                   Output : --out_vcf [], --pos [], --all_sites, --gl_off,
                            --quick_call, --ext


WARNING - 
Problems encountered parsing command line:

Command line parameter --help is undefined


FATAL ERROR - 
Input and output VCF files are the same!
```


## Metadata
- **Skill**: generated
