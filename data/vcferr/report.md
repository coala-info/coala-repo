# vcferr CWL Generation Report

## vcferr

### Tool Description
Simulate genotypes in a VCF file with specified error probabilities.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcferr:1.0.2--pyh5e36f6f_0
- **Homepage**: https://github.com/signaturescience/vcferr
- **Package**: https://anaconda.org/channels/bioconda/packages/vcferr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vcferr/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/signaturescience/vcferr
- **Stars**: N/A
### Original Help Text
```text
Usage: vcferr [OPTIONS] <input_vcf>

Options:
  -s, --sample TEXT        ID of sample in VCF file to be simulated
                           [required]
  -o, --output_vcf TEXT    Output VCF file containing simulated genotypes ex:
                           example.sim.vcf.gz
  -p_rarr, --p_rarr FLOAT  Probability of heterozygous drop out (0,1) or (1,0)
                           to (0,0)
  -p_aara, --p_aara FLOAT  Probability of homozygous alt drop out (1,1) to
                           (0,1)
  -p_rrra, --p_rrra FLOAT  Probability of heterozygous drop in (0,0) to (0,1)
  -p_raaa, --p_raaa FLOAT  Probability of homozygous alt drop in (0,1) or
                           (1,0) to (1,1)
  -p_aarr, --p_aarr FLOAT  Probability of double homozygous alt drop out (1,1)
                           to (0,0)
  -p_rraa, --p_rraa FLOAT  Probability of double homozygous alt drop in (0,0)
                           to (1,1)
  -p_rrmm, --p_rrmm FLOAT  Probability of homozygous ref to missing (0,0) to
                           (.,.)
  -p_ramm, --p_ramm FLOAT  Probability of heterozygous to missing (0,1) or
                           (1,0) to (.,.)
  -p_aamm, --p_aamm FLOAT  Probability of homozygous alt to missing (0,0) to
                           (.,.)
  -a, --seed INTEGER       Random number seed
  --help                   Show this message and exit.
```

