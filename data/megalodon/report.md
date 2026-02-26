# megalodon CWL Generation Report

## megalodon

### Tool Description
Megalodon is a tool for basecalling and variant calling from Oxford Nanopore sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/megalodon:2.5.0--py311haab0aaa_4
- **Homepage**: https://github.com/nanoporetech/megalodon
- **Package**: https://anaconda.org/channels/bioconda/packages/megalodon/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/megalodon/overview
- **Total Downloads**: 101.1K
- **Last updated**: 2025-09-09
- **GitHub**: https://github.com/nanoporetech/megalodon
- **Stars**: N/A
### Original Help Text
```text
usage: megalodon [-h] [--guppy-config GUPPY_CONFIG]
                 [--guppy-server-path GUPPY_SERVER_PATH] [--live-processing]
                 [--outputs {basecalls,mod_basecalls,mappings,per_read_variants,variants,variant_mappings,per_read_mods,mods,mod_mappings,signal_mappings,per_read_refs} [{basecalls,mod_basecalls,mappings,per_read_variants,variants,variant_mappings,per_read_mods,mods,mod_mappings,signal_mappings,per_read_refs} ...]]
                 [--output-directory OUTPUT_DIRECTORY] [--overwrite]
                 [--mappings-format {bam,cram,sam}] [--reference REFERENCE]
                 [--haploid] [--variant-filename VARIANT_FILENAME]
                 [--mod-motif BASE MOTIF REL_POSITION]
                 [--remora-modified-bases PORE BASECALL_MODEL_TYPE BASECALL_MODEL_VERSION MODIFIED_BASES REMORA_MODEL_TYPE REMORA_MODEL_VERSION]
                 [--processes PROCESSES] [--devices DEVICES [DEVICES ...]]
                 [--help-long] [--rna] [-v]
                 fast5s_dir

positional arguments:
  fast5s_dir            Directory containing raw fast5 (will be searched
                        recursively).

options:
  -h, --help            show this help message and exit

Guppy Backend Arguments:
  --guppy-config GUPPY_CONFIG
                        Guppy config. Default:
                        dna_r9.4.1_450bps_modbases_5mc_hac.cfg
  --guppy-server-path GUPPY_SERVER_PATH
                        Path to guppy server executable. Default: ./ont-
                        guppy/bin/guppy_basecall_server

Output Arguments:
  --live-processing     Process reads from a live sequencing run. The
                        [fast5s_dir] must be the base MinKNOW output
                        directory. Megalodon will continue searching for FAST5
                        files until the file starting with "final_summary" is
                        found.
  --outputs {basecalls,mod_basecalls,mappings,per_read_variants,variants,variant_mappings,per_read_mods,mods,mod_mappings,signal_mappings,per_read_refs} [{basecalls,mod_basecalls,mappings,per_read_variants,variants,variant_mappings,per_read_mods,mods,mod_mappings,signal_mappings,per_read_refs} ...]
                        Desired output(s).
                        Options:
                        	basecalls: Called bases (FASTA/Q)
                        	mod_basecalls: Basecall-anchored modified base scores (modBAM/CRAM/SAM)
                        	mappings: Mapped reads (BAM/CRAM/SAM)
                        	per_read_variants: Per-read, per-site sequence variant scores database
                        	variants: Reference site aggregated sequence variant calls (VCF)
                        	variant_mappings: Per-read mappings annotated with variant calls
                        	per_read_mods: Per-read, per-site modified base scores database
                        	mods: Reference site aggregated modified base calls (bedmethyl/modVCF/wig)
                        	mod_mappings: Per-read mappings annotated with modified base calls (BAM/CRAM/SAM)
                        	signal_mappings: Signal mappings for taiyaki model training (HDF5)
                        	per_read_refs: Per-read reference sequence for model training (FASTA)
                        Default: ['basecalls']
                        Note that all outputs are unsorted unless noted in the output filename.
  --output-directory OUTPUT_DIRECTORY
                        Directory to store output results. Default:
                        megalodon_results
  --overwrite           Overwrite output directory if it exists.

Mapping Arguments:
  --mappings-format {bam,cram,sam}
                        Mappings output format. Default: bam
  --reference REFERENCE
                        Reference FASTA or minimap2 index file used for
                        mapping called reads.

Sequence Variant Arguments:
  --haploid             Compute variant aggregation for haploid genotypes.
                        Default: diploid
  --variant-filename VARIANT_FILENAME
                        Sequence variants to call for each read in VCF/BCF
                        format (required for variant output).

Modified Base Arguments:
  --mod-motif BASE MOTIF REL_POSITION
                        Restrict modified base calls to specified motif(s).
                        Argument takes 3 values representing 1) the single
                        letter modified base(s), 2) sequence motif and 3)
                        relative modified base position. Multiple --mod-motif
                        arguments may be provided to a single command. For
                        example to restrict to CpG sites use "--mod-motif m CG
                        0".

Remora Modified Base Arguments:
  --remora-modified-bases PORE BASECALL_MODEL_TYPE BASECALL_MODEL_VERSION MODIFIED_BASES REMORA_MODEL_TYPE REMORA_MODEL_VERSION
                        Specify the Remora per-trained modified base detection
                        model to load. Copy a row from `remora model
                        list_pretrained``.

Compute Resource Arguments:
  --processes PROCESSES
                        Number of parallel processes. Default: 1
  --devices DEVICES [DEVICES ...]
                        GPU devices for guppy or taiyaki basecalling backends.

Miscellaneous Arguments:
  --help-long           Show all options.
  --rna                 RNA input data. Requires RNA model. Default: DNA input
                        data
  -v, --version         show megalodon version and exit.
```

