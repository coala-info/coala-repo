# ucsc-fatovcf CWL Generation Report

## ucsc-fatovcf_faToVcf

### Tool Description
Convert a FASTA alignment file to Variant Call Format (VCF) single-nucleotide diffs

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-fatovcf:482--hdc0a859_1
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-fatovcf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-fatovcf/overview
- **Total Downloads**: 90.4K
- **Last updated**: 2025-06-21
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
-help is not a valid option

faToVcf - Convert a FASTA alignment file to Variant Call Format (VCF) single-nucleotide diffs
usage:
   faToVcf in.fa out.vcf
options:
   -ambiguousToN         Treat all IUPAC ambiguous bases (N, R, V etc) as N (no call).
   -excludeFile=file     Exclude sequences named in file which has one sequence name per line
   -includeNoAltN        Include base positions with no alternate alleles observed, but at
                         least one N (missing base / no-call)
   -includeRef           Include the reference in the genotype columns
                         (default: omitted as redundant)
   -maskSites=file       Exclude variants in positions recommended for masking in file
                         (typically https://github.com/W-L/ProblematicSites_SARS-CoV2/raw/master/problematic_sites_sarsCov2.vcf)
   -maxDiff=N            Exclude sequences with more than N mismatches with the reference
                         (if -windowSize is used, sequences are masked accordingly first)
   -minAc=N              Ignore alternate alleles observed fewer than N times
   -minAf=F              Ignore alternate alleles observed in less than F of non-N bases
   -minAmbigInWindow=N   When -windowSize is provided, mask any base for which there are at
                         least this many N, ambiguous or gap characters within the window.
                         (default: 2)
   -noGenotypes          Output 8-column VCF, without the sample genotype columns
   -ref=seqName          Use seqName as the reference sequence; must be present in faFile
                         (default: first sequence in faFile)
   -resolveAmbiguous     For IUPAC ambiguous characters like R (A or G), if the character
                         represents two bases and one is the reference base, convert it to the
                         non-reference base.  Otherwise convert it to N.
   -startOffset=N        Add N bases to each position (for trimmed alignments)
   -vcfChrom=seqName     Use seqName for the CHROM column in VCF (default: ref sequence)
   -windowSize=N         Mask any base for which there are at least -minAmbigWindow bases in a
                         window of +-N bases around the base.  Masking approach adapted from
                         https://github.com/roblanf/sarscov2phylo/ file scripts/mask_seq.py
                         Use -windowSize=7 for same results.
in.fa must contain a series of sequences with different names and the same length.
Both N and - are treated as missing information.
```

