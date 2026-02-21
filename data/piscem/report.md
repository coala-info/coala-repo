# piscem CWL Generation Report

## piscem_build

### Tool Description
Index a reference sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/piscem:0.14.5--he431ac4_0
- **Homepage**: https://github.com/COMBINE-lab/piscem
- **Package**: https://anaconda.org/channels/bioconda/packages/piscem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/piscem/overview
- **Total Downloads**: 35.5K
- **Last updated**: 2026-02-08
- **GitHub**: https://github.com/COMBINE-lab/piscem
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Index a reference sequence

Usage: piscem build [OPTIONS] --threads <THREADS> --output <OUTPUT> <--ref-seqs <REF_SEQS>|--ref-lists <REF_LISTS>|--ref-dirs <REF_DIRS>>

Options:
  -o, --output <OUTPUT>            output file stem
      --decoy-paths <DECOY_PATHS>  path to (optional) ',' sparated list of decoy sequences used to
                                   insert poison k-mer information into the index
  -h, --help                       Print help
  -V, --version                    Print version

Input:
  -s, --ref-seqs <REF_SEQS>    ',' separated list of reference FASTA files
  -l, --ref-lists <REF_LISTS>  ',' separated list of files (each listing input FASTA files)
  -d, --ref-dirs <REF_DIRS>    ',' separated list of directories (all FASTA files in each directory
                               will be indexed, but not recursively)

Index Construction Parameters:
  -k, --klen <KLEN>
          length of k-mer to use, must be <= 31 and odd [default: 31]
  -m, --mlen <MLEN>
          length of minimizer to use; must be < `klen` [default: 19]
  -t, --threads <THREADS>
          number of threads to use
      --no-ec-table
          skip the construction of the equivalence class lookup table when building the index (not
          recommended)
      --polya-clip-length <POLYA_CLIP_LENGTH>
          If provided (default is not to clip polyA), then reference sequences ending with polyA
          tails of length greater than or equal to this value will be clipped
      --seed <SEED>
          index construction seed (seed value passed to SSHash index construction; useful if empty
          buckets occur) [default: 1]

Indexing Details:
      --keep-intermediate-dbg  retain the reduced format GFA files produced by cuttlefish that
                               describe the reference cDBG (the default is to remove these)
  -w, --work-dir <WORK_DIR>    working directory where temporary files should be placed [default:
                               ./workdir.noindex]
      --overwrite              overwite an existing index if the output path is the same
```


## piscem_map-sc

### Tool Description
map reads for single-cell processing

### Metadata
- **Docker Image**: quay.io/biocontainers/piscem:0.14.5--he431ac4_0
- **Homepage**: https://github.com/COMBINE-lab/piscem
- **Package**: https://anaconda.org/channels/bioconda/packages/piscem/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
map reads for single-cell processing

Usage: piscem map-sc [OPTIONS] --index <INDEX> --geometry <GEOMETRY> --read1 <READ1> --read2 <READ2> --output <OUTPUT>

Options:
  -g, --geometry <GEOMETRY>
          list available geometries supported by the underlying `pesc-sc` mapper geometry of
          barcode, umi and read
  -t, --threads <THREADS>
          number of threads to use [default: 16]
  -o, --output <OUTPUT>
          path to output directory
      --no-poison
          do not consider poison k-mers, even if the underlying index contains them. In this case,
          the mapping results will be identical to those obtained as if no poison table was added to
          the index
  -c, --struct-constraints
          apply structural constraints when performing mapping
      --skipping-strategy <SKIPPING_STRATEGY>
          the skipping strategy to use for k-mer collection [default: permissive] [possible values:
          permissive, strict]
      --ignore-ambig-hits
          skip checking of the equivalence classes of k-mers that were too ambiguous to be otherwise
          considered (passing this flag can speed up mapping slightly, but may reduce specificity)
      --with-position
          includes the positions of each mapped read in the resulting RAD file. Likewise, this will
          cause the `known_rad_type` tag of the resulting file to be `sc_rna_pos` rather than the
          default `sc_rna_basic`. (incompatible with alevin-fry < 0.12)
  -h, --help
          Print help
  -V, --version
          Print version

Input:
  -i, --index <INDEX>  input index prefix
  -1, --read1 <READ1>  path to a ',' separated list of read 1 files
  -2, --read2 <READ2>  path to a ',' separated list of read 2 files

Advanced options:
  -m, --max-ec-card <MAX_EC_CARD>
          determines the maximum cardinality equivalence class (number of (txp, orientation status)
          pairs) to examine (cannot be used with --ignore-ambig-hits) [default: 4096]
      --max-hit-occ <MAX_HIT_OCC>
          in the first pass, consider only k-mers having <= --max-hit-occ hits [default: 256]
      --max-hit-occ-recover <MAX_HIT_OCC_RECOVER>
          if all k-mers have > --max-hit-occ hits, then make a second pass and consider k-mers
          having <= --max-hit-occ-recover hits [default: 1024]
      --max-read-occ <MAX_READ_OCC>
          reads with more than this number of mappings will not have their mappings reported
          [default: 2500]
```


## piscem_map-bulk

### Tool Description
map reads for bulk processing

### Metadata
- **Docker Image**: quay.io/biocontainers/piscem:0.14.5--he431ac4_0
- **Homepage**: https://github.com/COMBINE-lab/piscem
- **Package**: https://anaconda.org/channels/bioconda/packages/piscem/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
map reads for bulk processing

Usage: piscem map-bulk [OPTIONS] --index <INDEX> --output <OUTPUT> <--read1 <READ1>|--reads <READS>>

Options:
  -t, --threads <THREADS>
          number of threads to use [default: 16]
  -o, --output <OUTPUT>
          path to output directory
      --no-poison
          do not consider poison k-mers, even if the underlying index contains them. In this case,
          the mapping results will be identical to those obtained as if no poison table was added to
          the index
  -c, --struct-constraints
          apply structural constraints when performing mapping
      --skipping-strategy <SKIPPING_STRATEGY>
          skipping strategy to use for k-mer collection [default: permissive] [possible values:
          permissive, strict]
      --ignore-ambig-hits
          skip checking of the equivalence classes of k-mers that were too ambiguous to be otherwise
          considered (passing this flag can speed up mapping slightly, but may reduce specificity)
  -h, --help
          Print help
  -V, --version
          Print version

Input:
  -i, --index <INDEX>  input index prefix
  -1, --read1 <READ1>  path to a comma-separated list of read 1 files
  -2, --read2 <READ2>  path to a ',' separated list of read 2 files
  -r, --reads <READS>  path to a ',' separated list of read unpaired read files

Advanced options:
  -m, --max-ec-card <MAX_EC_CARD>
          determines the maximum cardinality equivalence class (number of (txp, orientation status)
          pairs) to examine (cannot be used with --ignore-ambig-hits) [default: 4096]
      --max-hit-occ <MAX_HIT_OCC>
          in the first pass, consider only k-mers having <= --max-hit-occ hits [default: 256]
      --max-hit-occ-recover <MAX_HIT_OCC_RECOVER>
          if all k-mers have > --max-hit-occ hits, then make a second pass and consider k-mers
          having <= --max-hit-occ-recover hits [default: 1024]
      --max-read-occ <MAX_READ_OCC>
          reads with more than this number of mappings will not have their mappings reported
          [default: 2500]
```


## piscem_map-sc-atac

### Tool Description
map reads for scAtac processing

### Metadata
- **Docker Image**: quay.io/biocontainers/piscem:0.14.5--he431ac4_0
- **Homepage**: https://github.com/COMBINE-lab/piscem
- **Package**: https://anaconda.org/channels/bioconda/packages/piscem/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
map reads for scAtac processing

Usage: piscem map-sc-atac [OPTIONS] --index <INDEX> --output <OUTPUT>

Options:
  -t, --threads <THREADS>
          number of threads to use [default: 16]
  -o, --output <OUTPUT>
          path to output directory
      --ignore-ambig-hits
          skip checking of the equivalence classes of k-mers that were too ambiguous to be otherwise
          considered (passing this flag can speed up mapping slightly, but may reduce specificity)
      --no-poison
          do not consider poison k-mers, even if the underlying index contains them. In this case,
          the mapping results will be identical to those obtained as if no poison table was added to
          the index
  -c, --struct-constraints
          apply structural constraints when performing mapping
      --skipping-strategy <SKIPPING_STRATEGY>
          the skipping strategy to use for k-mer collection [default: permissive] [possible values:
          permissive, strict]
      --sam-format
          output mappings in sam format
      --bed-format
          output mappings in bed format
      --use-chr
          use chromosomes as color
      --thr <THR>
          threshold to be considered for pseudoalignment, default set to 0.7 [default: 0.7]
      --bin-size <BIN_SIZE>
          size of virtual color, default set to 1000 [default: 1000]
      --bin-overlap <BIN_OVERLAP>
          size for bin overlap, default set to 300 [default: 300]
      --no-tn5-shift
          do not apply Tn5 shift to mapped positions
      --check-kmer-orphan
          Check if any mapping kmer exist for a mate which is not mapped, but there exists mapping
          for the other read. If set to true and a mapping kmer exists, then the pair would not be
          mapped (default false)
  -h, --help
          Print help
  -V, --version
          Print version

Input:
  -i, --index <INDEX>      input index prefix
  -1, --read1 <READ1>      path to a ',' separated list of read 1 files
  -2, --read2 <READ2>      path to a ',' separated list of read 2 files
  -r, --reads <READS>      
  -b, --barcode <BARCODE>  path to a ',' separated list of read 2 files

Advanced options:
  -m, --max-ec-card <MAX_EC_CARD>
          determines the maximum cardinality equivalence class (number of (txp, orientation status)
          pairs) to examine (cannot be used with --ignore-ambig-hits) [default: 4096]
      --max-hit-occ <MAX_HIT_OCC>
          in the first pass, consider only k-mers having <= --max-hit-occ hits [default: 256]
      --max-hit-occ-recover <MAX_HIT_OCC_RECOVER>
          if all k-mers have > --max-hit-occ hits, then make a second pass and consider k-mers
          having <= --max-hit-occ-recover hits [default: 1024]
      --max-read-occ <MAX_READ_OCC>
          reads with more than this number of mappings will not have their mappings reported
          [default: 2500]
      --bclen <BCLEN>
          the length of the barcode sequence [default: 16]
      --end-cache-capacity <END_CACHE_CAPACITY>
          the capacity of the cache used to provide fast lookup for k-mers at the ends of unitigs
          [default: 5000000]
```


## Metadata
- **Skill**: generated
