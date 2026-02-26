# hapbin CWL Generation Report

## hapbin_hapbinconv

### Tool Description
Convert between ASCII hap and binary hapbin formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/hapbin:1.3.0--h503566f_6
- **Homepage**: https://github.com/evotools/hapbin
- **Package**: https://anaconda.org/channels/bioconda/packages/hapbin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hapbin/overview
- **Total Downloads**: 12.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/evotools/hapbin
- **Stars**: N/A
### Original Help Text
```text
Usage: hapbinconv --hap input.hap --out outfile.hapbin

	-h,--help			Show this help
	-v,--version			Version information
	-d,--hap			ASCII Hap file
	-o,--out			Binary output file
```


## hapbin_ehhbin

### Tool Description
Calculate EHH and EHHbin statistics for a given locus.

### Metadata
- **Docker Image**: quay.io/biocontainers/hapbin:1.3.0--h503566f_6
- **Homepage**: https://github.com/evotools/hapbin
- **Package**: https://anaconda.org/channels/bioconda/packages/hapbin/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ehhbin --map input.map --hap input.hap --locus id

	-h,--help			Show this help
	-v,--version			Version information
	-d,--hap			Hap file
	-m,--map			Map file
	-l,--locus			Locus
	-c,--cutoff			EHH cutoff value (default: 0.05)
	-b,--minmaf			Minimum allele frequency (default: 0.05)
	-s,--scale			Gap scale parameter in bp, used to scale gaps > scale parameter as in Voight, et al.
	-e,--max-extend			Maximum distance in bp to traverse when calculating EHH (default: 0 (disabled))
	-a,--binom			Use binomial coefficients rather than frequency squared for EHH
```


## hapbin_ihsbin

### Tool Description
Calculate iHS values for SNPs based on haplotype data.

### Metadata
- **Docker Image**: quay.io/biocontainers/hapbin:1.3.0--h503566f_6
- **Homepage**: https://github.com/evotools/hapbin
- **Package**: https://anaconda.org/channels/bioconda/packages/hapbin/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ihsbin --map input.map --hap input.hap [--ascii] [--out outfile]

	-h,--help			Show this help
	-v,--version			Version information
	-d,--hap			Hap file
	-m,--map			Map file
	-o,--out			Output file
	-c,--cutoff			EHH cutoff value (default: 0.05)
	-f,--minmaf			Minimum allele frequency (default: 0.05)
	-s,--scale			Gap scale parameter in bp, used to scale gaps > scale parameter as in Voight, et al.
	-b,--bin			Number of frequency bins for iHS normalization (default: 50)
	-e,--max-extend			Maximum distance in bp to traverse when calculating EHH (default: 0 (disabled))
	-a,--binom			Use binomial coefficients rather than frequency squared for EHH
```


## hapbin_xpehhbin

### Tool Description
Calculate XP-EHH values for bins of SNPs.

### Metadata
- **Docker Image**: quay.io/biocontainers/hapbin:1.3.0--h503566f_6
- **Homepage**: https://github.com/evotools/hapbin
- **Package**: https://anaconda.org/channels/bioconda/packages/hapbin/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: xpehhbin --map input.map --hapA inputA.hap --hapB inputB.hap

	-h,--help			Show this help
	-v,--version			Version information
	-d,--hapA			Hap file for population A
	-e,--hapB			Hap file for population B
	-m,--map			Map file
	-o,--out			Output file
	-c,--cutoff			EHH cutoff value (default: 0.05)
	-f,--minmaf			Minimum allele frequency (default: 0.05)
	-s,--scale			Gap scale parameter in bp, used to scale gaps > scale parameter as in Voight, et al.
	-b,--bin			Number of frequency bins for iHS normalization (default: 50)
	-a,--binom			Use binomial coefficients rather than frequency squared for EHH
	-e,--max-extend			Maximum distance in bp to traverse when calculating EHH (default: 0 (disabled))
```

