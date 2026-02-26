# cmash CWL Generation Report

## cmash_MakeDNADatabase.py

### Tool Description
This script creates training/reference sketches for each FASTA/Q file listed in the input file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cmash:0.5.2--pyh5e36f6f_0
- **Homepage**: https://github.com/dkoslicki/CMash
- **Package**: https://anaconda.org/channels/bioconda/packages/cmash/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cmash/overview
- **Total Downloads**: 12.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dkoslicki/CMash
- **Stars**: N/A
### Original Help Text
```text
usage: MakeDNADatabase.py [-h] [-p PRIME] [-t THREADS] [-n NUM_HASHES]
                          [-k K_SIZE] [-i]
                          in_file out_file

This script creates training/reference sketches for each FASTA/Q file listed
in the input file.

positional arguments:
  in_file               Input file: file containing (absolute) file names of
                        training genomes.
  out_file              Output training database/reference file (in HDF5
                        format)

optional arguments:
  -h, --help            show this help message and exit
  -p PRIME, --prime PRIME
                        Prime (for modding hashes) (default: 9999999999971)
  -t THREADS, --threads THREADS
                        Number of threads to use (default: 20)
  -n NUM_HASHES, --num_hashes NUM_HASHES
                        Number of hashes to use. (default: 500)
  -k K_SIZE, --k_size K_SIZE
                        K-mer size (default: 21)
  -i, --intersect_nodegraph
                        Optional flag to export Nodegraph file (bloom filter)
                        containing all k-mers in the training database. Saved
                        in same location as out_file. This is to be used with
                        QueryDNADatabase.py (default: False)
```


## cmash_QueryDNADatabase.py

### Tool Description
This script creates a CSV file of similarity indicies between the input file and each of the sketches in the training/reference file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cmash:0.5.2--pyh5e36f6f_0
- **Homepage**: https://github.com/dkoslicki/CMash
- **Package**: https://anaconda.org/channels/bioconda/packages/cmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: QueryDNADatabase.py [-h] [-t THREADS] [-f] [-fp FP_RATE]
                           [-ct CONTAINMENT_THRESHOLD] [-c CONFIDENCE]
                           [-ng NODE_GRAPH] [-b] [-i]
                           in_file training_data out_csv

This script creates a CSV file of similarity indicies between the input file
and each of the sketches in the training/reference file.

positional arguments:
  in_file               Input file: FASTQ/A file (can be gzipped).
  training_data         Training/reference data (HDF5 file created by
                        MakeTrainingDatabase.py)
  out_csv               Output CSV file

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        Number of threads to use (default: 20)
  -f, --force           Force creation of new NodeGraph. (default: False)
  -fp FP_RATE, --fp_rate FP_RATE
                        False positive rate. (default: 0.0001)
  -ct CONTAINMENT_THRESHOLD, --containment_threshold CONTAINMENT_THRESHOLD
                        Only return results with containment index above this
                        value (default: 0.02)
  -c CONFIDENCE, --confidence CONFIDENCE
                        Desired probability that all results were returned
                        with containment index above threshold [-ct] (default:
                        0.95)
  -ng NODE_GRAPH, --node_graph NODE_GRAPH
                        NodeGraph/bloom filter location. Used if it exists; if
                        not, one will be created and put in the same directory
                        as the specified output CSV file. (default: None)
  -b, --base_name       Flag to indicate that only the base names (not the
                        full path) should be saved in the output CSV file
                        (default: False)
  -i, --intersect_nodegraph
                        Option to only insert query k-mers in bloom filter if
                        they appear anywhere in the training database. Note
                        that the Jaccard estimates will now be J(query
                        intersect union_i training_i, training_i) instead of
                        J(query, training_i), but will use significantly less
                        space. (default: False)
```


## cmash_MakeStreamingDNADatabase.py

### Tool Description
This script creates training/reference sketches for each FASTA/Q file listed in the input file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cmash:0.5.2--pyh5e36f6f_0
- **Homepage**: https://github.com/dkoslicki/CMash
- **Package**: https://anaconda.org/channels/bioconda/packages/cmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: MakeStreamingDNADatabase.py [-h] [-p PRIME] [-t THREADS]
                                   [-n NUM_HASHES] [-k K_SIZE] [-v]
                                   in_file out_file

This script creates training/reference sketches for each FASTA/Q file listed
in the input file.

positional arguments:
  in_file               Input file: file containing (absolute) file names of
                        training genomes.
  out_file              Output training database/reference file (in HDF5
                        format). An additional file (ending in .tst) will also
                        be created in the same directory with the same base
                        name.

optional arguments:
  -h, --help            show this help message and exit
  -p PRIME, --prime PRIME
                        Prime (for modding hashes) (default: 9999999999971)
  -t THREADS, --threads THREADS
                        Number of threads to use (default: 20)
  -n NUM_HASHES, --num_hashes NUM_HASHES
                        Number of hashes to use. (default: 500)
  -k K_SIZE, --k_size K_SIZE
                        k-mer size (default: 21)
  -v, --verbose         Print out progress report/timing information (default:
                        False)
```


## cmash_StreamingQueryDNADatabase.py

### Tool Description
This script calculates containment indicies for each of the training/reference sketches by streaming through the query file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cmash:0.5.2--pyh5e36f6f_0
- **Homepage**: https://github.com/dkoslicki/CMash
- **Package**: https://anaconda.org/channels/bioconda/packages/cmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: StreamingQueryDNADatabase.py [-h] [-t THREADS]
                                    [-c CONTAINMENT_THRESHOLD] [-p]
                                    [-r READS_PER_CORE] [-f FILTER_FILE]
                                    [-l LOCATION_OF_THRESH] [--sensitive] [-v]
                                    in_file reference_file out_file range

This script calculates containment indicies for each of the training/reference
sketches by streaming through the query file.

positional arguments:
  in_file               Input file: FASTA/Q file to be processes
  reference_file        Training database/reference file (in HDF5 format).
                        Created with MakeStreamingDNADatabase.py
  out_file              Output csv file with the containment indices.
  range                 Range of k-mer sizes in the formate
                        <start>-<end>-<increment>. So 5-10-2 means [5, 7, 9].
                        If <end> is larger than the k-mer sizeof the training
                        data, this will automatically be reduced.

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        Number of threads to use (default: 20)
  -c CONTAINMENT_THRESHOLD, --containment_threshold CONTAINMENT_THRESHOLD
                        Only return results with containment index above this
                        threshold at the maximum k-mer size. (default: 0.1)
  -p, --plot_file       Optional flag to specify that a plot of the k-mer
                        curves should also be saved (same basenameas the
                        out_file). (default: False)
  -r READS_PER_CORE, --reads_per_core READS_PER_CORE
                        Number of reads per core in each chunk of
                        parallelization. Set as high as memory will allow (eg.
                        1M on 256GB, 48 core machine) (default: 100000)
  -f FILTER_FILE, --filter_file FILTER_FILE
                        Location of pre-filter bloom filter. Use only if you
                        absolutely know what you're doing (hard to error check
                        bloom filters). (default: None)
  -l LOCATION_OF_THRESH, --location_of_thresh LOCATION_OF_THRESH
                        Location in range to apply the threshold passed by the
                        -c flag. -l 2 -c 5-50-10 means the threshold will be
                        applied at k-size 25. Default is largest size.
                        (default: -1)
  --sensitive           Operate in sensitive mode. Marginally more true
                        positives with significantly more false positives. Use
                        with caution. (default: False)
  -v, --verbose         Print out progress report/timing information (default:
                        False)
```

