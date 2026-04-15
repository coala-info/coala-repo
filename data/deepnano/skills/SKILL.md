---
name: deepnano
description: DeepNano is a high-performance basecaller that converts raw Nanopore fast5 signal data into fasta or fastq sequences using recurrent neural networks. Use when user asks to basecall Nanopore reads, convert fast5 files to fastq, or perform real-time basecalling on a CPU.
homepage: https://github.com/fmfi-compbio/deepnano-blitz
metadata:
  docker_image: "biocontainers/deepnano:v0.0git20170813.e8a621e-3-deb_cv1"
---

# deepnano

## Overview

DeepNano-blitz is a high-performance basecaller designed to process Nanopore signal data at speeds exceeding the physical output of a MinION sequencer. It utilizes a recurrent neural network (RNN) architecture implemented in Rust and Python, leveraging Intel MKL libraries for maximum CPU efficiency. This skill provides the necessary command-line patterns and programmatic workflows to convert raw fast5 signal data into fasta or fastq sequences.

## Common CLI Patterns

The primary interface is the `deepnano2_caller.py` script.

### Basecalling Workflows

**1. Real-time / Maximum Speed (Lowest Accuracy)**
Use the smallest network and minimal beam search for live monitoring.
```bash
deepnano2_caller.py --directory reads/ --output live.fasta --network-type 48 --beam-size 1
```

**2. Standard Balanced Mode**
The recommended default for a balance of speed and quality.
```bash
deepnano2_caller.py --directory reads/ --output out.fastq --network-type 64 --output-format fastq
```

**3. High Accuracy Mode**
Uses a larger network; significantly slower but provides better identity rates.
```bash
deepnano2_caller.py --directory reads/ --output high_acc.fastq --network-type 256 --threads 16 --output-format fastq
```

**4. Compressed Output**
Directly generate gzipped files to save disk space.
```bash
deepnano2_caller.py --directory reads/ --output out.fasta.gz --gzip-output
```

### Performance Tuning

- **Threads**: Increase throughput by matching the thread count to your CPU cores (e.g., `--threads 8`).
- **Network Types**: Available sizes include 48, 56, 64, 80, 96, and 256.
- **Beam Size**: Increasing `--beam-size` (default is 5) improves accuracy at the cost of speed.

## Expert Tips and Troubleshooting

### CPU Optimization
- **AMD Users**: If running on an AMD CPU, you must set the following environment variable to ensure MKL uses optimized paths:
  `export MKL_DEBUG_CPU_TYPE=5`
- **Thread Contention**: If the caller hangs or performs poorly on multi-socket systems, try limiting OpenMP threads:
  `export OMP_NUM_THREADS=1`

### Signal Pre-processing
When calling programmatically or working with raw signals, ensure the signal is normalized using Median and Median Absolute Deviation (MAD):
1. Calculate `med = np.median(signal)` and `mad = np.median(np.absolute(signal - med)) * 1.4826`.
2. Rescale: `signal = (signal - med) / mad`.

### Stall Trimming
For very short reads or specific library preps, the initial "stall" (high-current signal at the start) can interfere with basecalling. Use a trimming function to detect the first point where the signal variance or mean stabilizes before passing the array to the caller.

## Programmatic Usage

You can integrate the caller directly into Python scripts for custom pipelines:

```python
import deepnano2
import os

# Initialize caller
network_type = "64"
weights = os.path.join(deepnano2.__path__[0], "weights", f"rnn{network_type}.txt")
caller = deepnano2.Caller(network_type, weights, beam_size=5, beam_cut_threshold=0.01)

# Call normalized signal
# signal must be a 1D numpy float32 array
sequence = caller.call_raw_signal(normalized_signal)
print(sequence)
```

## Reference documentation
- [DeepNano-blitz Main README](./references/github_com_fmfi-compbio_deepnano-blitz.md)
- [DeepNano2 Module Structure](./references/github_com_fmfi-compbio_deepnano-blitz_tree_master_deepnano2.md)