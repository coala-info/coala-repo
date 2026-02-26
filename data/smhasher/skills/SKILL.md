---
name: smhasher
description: SMHasher is a comprehensive test suite designed to analyze the quality and performance of non-cryptographic hash functions. Use when user asks to verify hash correctness, benchmark hash algorithm performance, or test for bit distribution flaws and collisions.
homepage: https://github.com/aappleby/smhasher
---


# smhasher

## Overview
SMHasher is a comprehensive test suite designed to rigorously analyze non-cryptographic hash functions. It serves as a "DieHarder" for hashes, providing a battery of tests that detect flaws in bit distribution and collision resistance. The skill includes the MurmurHash3 family and provides the framework to verify if a custom hash implementation is correct and performant. Use this skill to guide the compilation, verification, and benchmarking of hash algorithms.

## Build and Setup
The tool is primarily a C++ project. To use it, you must first compile the suite:
- **CMake**: The standard way to build. Run `cmake . && make` in the root directory.
- **Hancho**: A specialized build script (`build.hancho`) is available in the repository as an alternative to CMake.
- **Source Integration**: The MurmurHash files (`MurmurHash3.cpp/h`) are designed to be standalone. You can copy them directly into your own projects without external dependencies.

## Verification and Correctness
Before benchmarking, ensure the hash implementation is correct using the built-in verification logic:
- **VerificationTest()**: This function generates a specific 32-bit result for a hash. Compare your implementation's output against the values defined in `main.cpp`. If they match, the implementation is correct.
- **SanityTest()**: Run this to ensure the hash behaves consistently across basic operations.
- **Public Domain**: Note that all MurmurHash versions are in the public domain, while the SMHasher test suite itself is under the MIT license.

## Testing Methodologies
When evaluating a new or existing hash, focus on these specific test patterns:
- **TwoBytes Test**: Generates all keys up to length N with two non-zero bytes. This is highly effective at finding flaws in the finalization and mixing steps of a hash.
- **Keyset Tests**: Use these to test specific patterns (e.g., sparse bits, sequential keys) to see if the hash maintains a uniform distribution.
- **Finalization**: Ensure the hash has a strong finalization step. SMHasher often reveals that a strong finalizer with fewer mixing rounds is faster and more robust than a weak finalizer with more rounds.

## Performance Benchmarking
SMHasher provides detailed performance metrics scaled to a 3.0 GHz processor for comparison:
- **Bulk Speed**: Measured in GiB/sec. Useful for large data processing.
- **Small Key Latency**: Measured in "cycles per key" (e.g., for a 16-byte key). This is critical for hash table lookups where keys are typically small.
- **Platform Variance**: Always test on both x86 and x64 platforms. MurmurHash3 variants, for example, perform differently depending on the architecture (e.g., `x64_128` is optimized for 64-bit systems).

## Reference documentation
- [SMHasher Wiki](./references/github_com_aappleby_smhasher_wiki.md)
- [SMHasher Source Tree](./references/github_com_aappleby_smhasher_tree_master_src.md)