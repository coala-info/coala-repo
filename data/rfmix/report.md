# rfmix CWL Generation Report

## rfmix

### Tool Description
RFMIX v2.03-r0 - Local Ancestry and Admixture Inference

### Metadata
- **Docker Image**: quay.io/biocontainers/rfmix:2.03.r0.9505bfa--h503566f_8
- **Homepage**: https://github.com/slowkoni/rfmix
- **Package**: https://anaconda.org/channels/bioconda/packages/rfmix/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rfmix/overview
- **Total Downloads**: 9.1K
- **Last updated**: 2025-11-25
- **GitHub**: https://github.com/slowkoni/rfmix
- **Stars**: N/A
### Original Help Text
```text
RFMIX v2.03-r0 - Local Ancestry and Admixture Inference
(c) 2016, 2017 Mark Koni Hamilton Wright
Bustamante Lab - Stanford University School of Medicine
Based on concepts developed in RFMIX v1 by Brian Keith Maples, et al.

This version is licensed for non-commercial academic research use only
For commercial licensing, please contact cdbadmin@stanford.edu

--- For use in scientific publications please cite original publication ---
Brian Maples, Simon Gravel, Eimear E. Kenny, and Carlos D. Bustamante (2013).
RFMix: A Discriminative Modeling Approach for Rapid and Robust Local-Ancestry
Inference. Am. J. Hum. Genet. 93, 278-288

Summary of command line options - see manual for details

   -f <string>, --query-file=<string>	(required)
      VCF file with samples to analyze                      (required)
   -r <string>, --reference-file=<string>	(required)
      VCF file with reference individuals                   (required)
   -m <string>, --sample-map=<string>	(required)
      Reference panel sample population classification map  (required)
   -g <string>, --genetic-map=<string>	(required)
      Genetic map file                                      (required)
   -o <string>, --output-basename=<string>	(required)
      Basename (prefix) for output files                    (required)
   --chromosome=<string>	(required)
      Execute only on specified chromosome                  (required)

   -c <float>, --crf-spacing=<float>
      Conditional Random Field spacing (# of SNPs)
   -s <float>, --rf-window-size=<float>
      Random forest window size (class estimation window size)
   -w <float>, --crf-weight=<float>
      Weight of observation term relative to transition term in conditional random field
   -G <float>, --generations=<float>
      Average number of generations since expected admixture
   -e <int>, --em-iterations=<int>
      Maximum number of EM iterations
   --reanalyze-reference
      In EM, analyze local ancestry of the reference panel and reclassify it

   -n <int>, --node-size=<int>
      Terminal node size for random forest trees
   -t <int>, --trees=<int>
      Number of tree in random forest to estimate population class probability
   --max-missing=<float>
      Maximum proportion of missing data allowed to include a SNP
   -b <int>, --bootstrap-mode=<int>
      Specify random forest bootstrap mode as integer code (see manual)
   --rf-minimum-snps=<int>
      With genetic sized rf windows, include at least this many SNPs regardless of span
   --analyze-range=<string>
      Physical position range, specified as <start pos>-<end pos>, in Mbp (decimal allowed)

   --debug=<flag>
      Turn on any debugging output
   --n-threads=<int>
      Force number of simultaneous thread for parallel execution
   --random-seed=<string>
      Seed value for random number generation (integer)
	(maybe specified in hexadecimal by preceeding with 0x), or the string
	"clock" to seed with the current system time.
```

