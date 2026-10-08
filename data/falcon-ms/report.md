# falcon-ms CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| falcon-ms_falcon | PASS |  |

## falcon-ms_falcon

### Tool Description
falcon: Fast spectrum clustering using nearest neighbor searching.

### Metadata
- **Docker Image**: biocontainers/falcon-ms:v0.1.3_cv1
- **Homepage**: https://github.com/bittremieux/falcon
- **Package**: https://anaconda.org/channels/bioconda/packages/falcon-ms/overview
- **Validation**: PASS

### Original Help Text
```text
usage: falcon [-h] [-c CONFIG_FILE] [--work_dir WORK_DIR] [--overwrite]
              [--export_representatives] [--export_include_singletons]
              [--usi_pxd USI_PXD]
              [--precursor_tol PRECURSOR_TOL PRECURSOR_TOL] [--rt_tol RT_TOL]
              [--fragment_tol FRAGMENT_TOL] [--eps EPS]
              [--min_samples MIN_SAMPLES] [--mz_interval MZ_INTERVAL]
              [--hash_len HASH_LEN] [--n_neighbors N_NEIGHBORS]
              [--n_neighbors_ann N_NEIGHBORS_ANN] [--batch_size BATCH_SIZE]
              [--n_probe N_PROBE] [--min_peaks MIN_PEAKS]
              [--min_mz_range MIN_MZ_RANGE] [--min_mz MIN_MZ]
              [--max_mz MAX_MZ] [--remove_precursor_tol REMOVE_PRECURSOR_TOL]
              [--min_intensity MIN_INTENSITY]
              [--max_peaks_used MAX_PEAKS_USED]
              [--scaling {off,root,log,rank}]
              input_filenames [input_filenames ...] output_filename

falcon: Fast spectrum clustering using nearest neighbor searching
=================================================================

falcon version 0.1.3

Official code website: https://github.com/bittremieux/falcon

positional arguments:
  input_filenames       Input peak files (supported formats: .mzML, .mzXML,
                        .MGF).
  output_filename       Output file name.

optional arguments:
  -h, --help            show this help message and exit
  -c CONFIG_FILE, --config CONFIG_FILE
                        config file path
  --work_dir WORK_DIR   Working directory (default: temporary directory).
  --overwrite           Overwrite existing results (default: don't overwrite).
  --export_representatives
                        Export cluster representatives to an MGF file
                        (default: no export).
  --export_include_singletons
                        Include singletons in the cluster representatives MGF
                        file (default: don't include singletons).
  --usi_pxd USI_PXD     ProteomeXchange dataset identifier to create Universal
                        Spectrum Identifier references (default: USI000000).
  --precursor_tol PRECURSOR_TOL PRECURSOR_TOL
                        Precursor tolerance mass and mode (default: 20 ppm).
                        Mode should be either "ppm" or "Da".
  --rt_tol RT_TOL       Retention time tolerance (default: no retention time
                        filtering).
  --fragment_tol FRAGMENT_TOL
                        Fragment mass tolerance in m/z (default: 0.05 m/z).
  --eps EPS             The eps parameter (cosine distance) for DBSCAN
                        clustering (default: 0.1). Relevant cosine distance
                        thresholds are typically between 0.05 and 0.30.
  --min_samples MIN_SAMPLES
                        The min_samples parameter for DBSCAN clustering
                        (default: 2).
  --mz_interval MZ_INTERVAL
                        Precursor m/z interval (centered around x.5 Da) to
                        process spectra simultaneously (default: 1 m/z).
  --hash_len HASH_LEN   Hashed vector length (default: 800).
  --n_neighbors N_NEIGHBORS
                        Number of neighbors to include in the pairwise
                        distance matrix for each spectrum (default: 64).
  --n_neighbors_ann N_NEIGHBORS_ANN
                        Number of neighbors to retrieve from the nearest
                        neighbor indexes prior to precursor tolerance
                        filtering (default: 128).
  --batch_size BATCH_SIZE
                        Number of spectra to process simultaneously (default:
                        65536).
  --n_probe N_PROBE     Maximum number of lists in the inverted index to
                        inspect during querying (default: 32).
  --min_peaks MIN_PEAKS
                        Discard spectra with fewer than this number of peaks
                        (default: 5).
  --min_mz_range MIN_MZ_RANGE
                        Discard spectra with a smaller mass range (default:
                        250.0 m/z).
  --min_mz MIN_MZ       Minimum peak m/z value (inclusive, default: 101.0
                        m/z).
  --max_mz MAX_MZ       Maximum peak m/z value (inclusive, default: 1500.0
                        m/z).
  --remove_precursor_tol REMOVE_PRECURSOR_TOL
                        Window around the precursor mass to remove peaks
                        (default: 1.5 m/z).
  --min_intensity MIN_INTENSITY
                        Remove peaks with a lower intensity relative to the
                        base intensity (default: 0.01).
  --max_peaks_used MAX_PEAKS_USED
                        Only use the specified most intense peaks in the
                        spectra (default: 50).
  --scaling {off,root,log,rank}
                        Peak scaling method used to reduce the influence of
                        very intense peaks (default: off).

Args that start with '--' (eg. --work_dir) can also be set in a config file
(config.ini or specified via -c). Config file syntax allows: key=value,
flag=true, stuff=[a,b,c] (for details, see syntax at https://goo.gl/R74nmi).
If an arg is specified in more than one place, then commandline values
override config file values which override defaults.
```

## Metadata
- **Skill**: not generated
