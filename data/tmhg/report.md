# tmhg CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tmhg_add | Failed | tool bug: with old nodes to reuse it crashes (TypeError in tMHGFinderAddGenome.py: concat_fasta now returns a tuple but is used as a dict) |
| tmhg_find | PASS |  |

## tmhg_find

### Tool Description
Run tMHG-Finder on a set of genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/tmhg:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/yongze-yin/tMHG-Finder/
- **Package**: https://anaconda.org/channels/bioconda/packages/tmhg/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tmhgf find [-h] [-b BLASTN_DIR] [--mash_tree_path MASH_TREE_PATH]
                  [--customized_tree_path CUSTOMIZED_TREE_PATH] [-r REROOT]
                  [-k KMER_SIZE] [-t THREAD] [-a ALIGNMENT_LENGTH_THRESHOLD]
                  -g GENOME [-o MHG_OUTPUT_DIR] [-tg TEMP_DIR]

options:
  -h, --help            show this help message and exit
  -b BLASTN_DIR, --blastn_dir BLASTN_DIR
                        Directory storing blastn results
  --mash_tree_path MASH_TREE_PATH
                        Mash-estimated guide tree path
  --customized_tree_path CUSTOMIZED_TREE_PATH
                        Path to customized tree instead of using auto-
                        estimated tree
  -r REROOT, --reroot REROOT
                        Boolean value determining whether to reroot the guide
                        tree or not. If this is set to True, it will reroot
                        the guide tree changing the MHG output order to
                        minimize the tree height. If this is False, it will
                        keep the MHG visiting order as it is.
  -k KMER_SIZE, --kmer_size KMER_SIZE
                        Kmer size for Mash, default 16
  -t THREAD, --thread THREAD
                        Number of threads
  -a ALIGNMENT_LENGTH_THRESHOLD, --alignment_length_threshold ALIGNMENT_LENGTH_THRESHOLD
                        Alignment length threshold in base pair. tMHG-Finder
                        does not consider MHGs shorter than 60 base pairs by
                        default. If this threshold is too low, it will result
                        in an excessive amount of short MHGs and a longer
                        runtime.
  -g GENOME, --genome GENOME
                        Genome nucleotide sequence directory
  -o MHG_OUTPUT_DIR, --mhg_output_dir MHG_OUTPUT_DIR
                        Directory storing all tMHG-Finder outputs
  -tg TEMP_DIR, --temp_dir TEMP_DIR
                        Directory storing a copy of each genome and
                        representative genomes
```

## tmhg_add

### Tool Description
Add genomes to an existing tMHG-Finder run.

### Metadata
- **Docker Image**: quay.io/biocontainers/tmhg:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/yongze-yin/tMHG-Finder/
- **Package**: https://anaconda.org/channels/bioconda/packages/tmhg/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tmhgf add [-h] [-b BLASTN_DIR] [--mash_tree_path MASH_TREE_PATH]
                 [--customized_tree_path CUSTOMIZED_TREE_PATH] [-r REROOT]
                 [-k KMER_SIZE] [-t THREAD] [-a ALIGNMENT_LENGTH_THRESHOLD]
                 -og OLD_TEMP_GENOME_DIR -om OLD_MHG_OUTPUT_DIR -g
                 NEW_GENOME_DIR [-o MHG_OUTPUT_DIR] [-tg NEW_TEMP_GENOME_DIR]

options:
  -h, --help            show this help message and exit
  -b BLASTN_DIR, --blastn_dir BLASTN_DIR
                        Directory storing blastn results
  --mash_tree_path MASH_TREE_PATH
                        Mash-estimated guide tree path
  --customized_tree_path CUSTOMIZED_TREE_PATH
                        Path to customized tree instead of using auto-
                        estimated tree
  -r REROOT, --reroot REROOT
                        Boolean value determining whether to reroot the guide
                        tree or not. If this is set to True, it will reroot
                        the guide tree changing the MHG output order to
                        minimize the tree height. If this is False, it will
                        keep the MHG visiting order as it is.
  -k KMER_SIZE, --kmer_size KMER_SIZE
                        Kmer size for Mash, default 16
  -t THREAD, --thread THREAD
                        Number of threads
  -a ALIGNMENT_LENGTH_THRESHOLD, --alignment_length_threshold ALIGNMENT_LENGTH_THRESHOLD
                        Alignment length threshold in base pair. tMHG-Finder
                        does not consider MHGs shorter than 60 base pairs by
                        default. If this threshold is too low, it will result
                        in an excessive amount of short MHGs and a longer
                        runtime.
  -og OLD_TEMP_GENOME_DIR, --old_temp_genome_dir OLD_TEMP_GENOME_DIR
                        Path to the old tMHG-Finder temp genome directory,
                        this is NOT the previous genome directory, but the
                        tMHG-Finder temporary genome directory
  -om OLD_MHG_OUTPUT_DIR, --old_mhg_output_dir OLD_MHG_OUTPUT_DIR
                        Path to the old tMHG-Finder output directory which
                        should contain an MHG set for each internal node
  -g NEW_GENOME_DIR, --new_genome_dir NEW_GENOME_DIR
                        Directory contaning the new set of genomes
  -o MHG_OUTPUT_DIR, --mhg_output_dir MHG_OUTPUT_DIR
                        Directory storing the new MHG output
  -tg NEW_TEMP_GENOME_DIR, --new_temp_genome_dir NEW_TEMP_GENOME_DIR
                        Directory storing a copy of each genome and
                        representative genomes
```

