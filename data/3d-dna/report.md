# 3d-dna CWL Generation Report

## 3d-dna

### Tool Description
This is a script to assemble draft assemblies (represented in input by draft fasta and deduplicated list of alignments of Hi-C reads to this fasta as produced by the Juicer pipeline) into chromosome-length scaffolds. The script will produce an output fasta file, a Hi-C map of the final assembly, and a few supplementary annotation files to help review the result in Juicebox.

### Metadata
- **Docker Image**: quay.io/biocontainers/3d-dna:201008--hdfd78af_0
- **Homepage**: https://github.com/aidenlab/3d-dna/tree/201008
- **Package**: https://anaconda.org/channels/bioconda/packages/3d-dna/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/3d-dna/overview
- **Total Downloads**: 3.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/aidenlab/3d-dna
- **Stars**: 222
### Original Help Text
```text
/usr/local/share/3d-dna/run-asm-pipeline.sh --help
version: 190716

*****************************************************
3D de novo assembly: version 170123

USAGE: ./run-asm-pipeline.sh [options] <path_to_input_fasta> <path_to_input_mnd> 

DESCRIPTION:
This is a script to assemble draft assemblies (represented in input by draft fasta and deduplicated list of alignments of Hi-C reads to this fasta as produced by the Juicer pipeline) into chromosome-length scaffolds. The script will produce an output fasta file, a Hi-C map of the final assembly, and a few supplementary annotation files to help review the result in Juicebox.

ARGUMENTS:
path_to_input_fasta			Specify file path to draft assembly fasta file.
path_to_input_mnd			Specify path to deduplicated list of alignments of Hi-C reads to the draft assembly fasta as produced by the Juicer pipeline: the merged_nodups file (mnd).

OPTIONS:
-h			Shows main options.
--help			Shows this help.
-m|--mode haploid/diploid			Runs in specific mode, either haploid or diploid (default is haploid).
-i|--input input_size			Specifies threshold input contig/scaffold size (default is 15000). Contigs/scaffolds smaller than input_size are going to be ignored.
-r|--rounds number_of_edit_rounds			Specifies number of iterative rounds for misjoin correction (default is 2).
-s|--stage stage					Fast forward to later assembly steps, can be polish, split, seal, merge and finalize.

ADDITIONAL OPTIONS:
**scaffolder**
-q|--mapq mapq					Mapq threshold for scaffolding and visualization (default is 1).

**misjoin detector**
--editor-coarse-resolution editor_coarse_resolution
			Misjoin editor coarse matrix resolution, should be one of the following: 2500000, 1000000, 500000, 250000, 100000, 50000, 25000, 10000, 5000, 1000 (default is 25000).
--editor-coarse-region editor_coarse_region
			Misjoin editor triangular motif region size (default is 125000).
--editor-coarse-stringency editor_coarse_stringency
			Misjoin editor stringency parameter (default is 55).
--editor-saturation-centile editor_saturation_centile
			Misjoin editor saturation parameter (default is 5).
--editor-fine-resolution editor_fine_resiolution
			Misjoin editor fine matrix resolution, should be one of the following: 2500000, 1000000, 500000, 250000, 100000, 50000, 25000, 10000, 5000, 1000 (default is 1000).
--editor-repeat-coverage editor_repeat_coverage
			Misjoin editor threshold repeat coverage (default is 2). 

**polisher**
--polisher-input-size polisher_input_size
			Polisher input size threshold. Scaffolds smaller than polisher_input_size are going to be placed into unresolved (default is 1000000).
--polisher-coarse-resolution editor_coarse_resolution
			Polisher coarse matrix resolution, should be one of the following: 2500000, 1000000, 500000, 250000, 100000, 50000, 25000, 10000, 5000, 1000 (default is 25000).
--polisher-coarse-region editor_coarse_region
			Polisher  triangular motif region size (default is 3000000).
--polisher-coarse-stringency editor_coarse_stringency
			Polisher stringency parameter (default is 55).
--polisher-saturation-centile editor_saturation_centile
			Polisher saturation parameter (default is 5).
--polisher-fine-resolution editor_fine_resiolution
			Polisher fine matrix resolution, should be one of the following: 2500000, 1000000, 500000, 250000, 100000, 50000, 25000, 10000, 5000, 1000 (default is 1000).

**splitter**
--splitter-input-size splitter_input_size
			Splitter input size threshold. Scaffolds smaller than polisher_input_size are going to be placed into unresolved (Default: 1000000).
--splitter-coarse-resolution splitter_coarse_resolution
			Splitter coarse matrix resolution, should be one of the following: 2500000, 1000000, 500000, 250000, 100000, 50000, 25000, 10000, 5000, 1000 (Default: 25000).
--splitter-coarse-region splitter_coarse_region
			Splitter  triangular motif region size (Default: 3000000).
--splitter-coarse-stringency splitter_coarse_stringency
			Splitter stringency parameter (Default: 55).
--splitter-saturation-centile splitter_saturation_centile
			Splitter saturation parameter (Default: 5).
--splitter-fine-resolution splitter_fine_resiolution
			Splitter fine matrix resolution, should be one of the following: 2500000, 1000000, 500000, 250000, 100000, 50000, 25000, 10000, 5000, 1000 (Default: 1000).

**merger**
--merger-search-band merger_search_band		
			Distance (in bp) within which to locally search for alternative haplotypes to a given contig or scaffold, from the position of their suggested incorporation in the assembly. The larger the original input contigs/scaffolds, the larger band size it might be necessary to set. Default: 3000000.
--merger-alignment-score merger_alignment_score
			Minimal LASTZ alignment score for nearby sequences (located in the assembly within the distance defined by the merger_search_band parameter) to be recongnized as alternative haplotypes. Default: 50000000.
--merger-alignment-identity merger_alignment_identity
			Minimal identity score required from similar nearby sequences (per length) for them to be classified as alternative haplotypes. Default: 20.
--merger-alignment-length	merger_alignment_length
			Minimal length necessary to recognize similar nearby sequences as alternative haplotypes. Default: 20000.
--merger-lastz-options	merger_lastz_options
			Option string to customize LASTZ alignment. Default: "--gfextend\ --gapped\ --chain=200,200"		

**finalizer**
-g|--gap-size gap_size
			Gap size to be added between scaffolded sequences in the final chromosome-length scaffolds (default is 500).

**supplementary**
-e|--early-exit
			Option to exit after first round of scaffolding.
-f|--fast-start
			Option to pick up processing assuming the first round of scaffolding is done. In conjunction with --early-exit this option is to help tune the parameters for best performance.
--sort-output
			Option to sort the chromosome-length scaffolds by size, in the descending order.
-c|--chromosome-map chromosome_count
			Option to build a standard sandboxed hic file for the first chromosome_count Hi-C scaffolds 
*****************************************************
```


## Metadata
- **Skill**: generated
