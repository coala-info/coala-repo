[Coreutils](/coreutils)
[Findutils](/findutils)
[Diffutils](/diffutils)

[Blog](/blog)
[Twitter](https://twitter.com/uutils_/)
[Mastodon](https://mastodon.social/%40uutils)
[GSOC](/gsoc)

Uutils at GSOC

Google summer of code is:

> Google Summer of Code is a global, online program focused on bringing
> new contributors into open source software development. GSoC
> Contributors work with an open source organization on a 12+ week
> programming project under the guidance of mentors.

If you want to know more about how it works, check out the links below.

**Useful links**:

* [GSOC Contributor Guide](https://google.github.io/gsocguides/student/)
* [GSOC FAQ](https://developers.google.com/open-source/gsoc/faq)
* [GSOC Timeline](https://developers.google.com/open-source/gsoc/timeline) (important for deadlines!)

# What is it about?

The [uutils project](https://github.com/uutils/) is aiming at rewriting key Linux utilities in Rust, targeting [coreutils](https://github.com/uutils/coreutils), [findutils](https://github.com/uutils/findutils), [diffutils](https://github.com/uutils/diffutils), [procps](https://github.com/uutils/procps), [util-linux](https://github.com/uutils/util-linux), and [bsdutils](https://github.com/uutils/bsdutils). Their goal is to create fully compatible, high-performance drop-in replacements, ensuring reliability through upstream test suites. Significant progress has been made with coreutils, diffutils, and findutils, while the other utilities are in the early stages of development.

# How to get started

Here are some steps to follow if you want to apply for a GSOC project
with uutils.

1. **Check the requirements.** You have to meet
   [Google's requirements](https://developers.google.com/open-source/gsoc/faq#what_are_the_eligibility_requirements_for_participation) to apply. Specifically for uutils, it's best if you at
   least know some Rust and have some familiarity with using the
   coreutils and the other tools.
2. **Reach out to us!** We are happy to discuss potential projects and help you find a meaningful project for uutils. Tell us what interests you about the project and what experience you have and we can find a suitable project together. You can talk to the uutils maintainers on the [Discord server](https://discord.gg/wQVJbvJ). In particular, you can contact:

   * Sylvestre Ledru (@sylvestre on GitHub and Discord)
3. **Get comfortable with uutils.** To find a good project you need to understand the codebase. We recommend that you take a look at the code, the issue tracker and maybe try to tackle some [good-first-issues](https://github.com/uutils/coreutils/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22). Also take a look at our [contributor guidelines](https://github.com/uutils/coreutils/blob/main/CONTRIBUTING.md).
4. **Find a project and a mentor.** We have a [list of potential projects](https://github.com/uutils/coreutils/wiki/GSOC-Project-Ideas) you can adapt or use as inspiration. Make sure discuss your ideas with the maintainers! Some project ideas below have suggested mentors you could contact.
5. **Write the application.** You can do this with your mentor. The application has to go through Google, so make sure to follow all the advice in Google's [Contributor Guide](https://google.github.io/gsocguides/student/writing-a-proposal). Please make sure you include your prior contributions to uutils in your application.

# Tips

* Make sure the project is concrete and well-defined.
* Communication is super important!
* Try to tackle some issues to get familiar with uutils and demonstrate your motivation.

# Project Ideas

This page contains project ideas for the Google Summer of Code for
uutils. Feel free to suggest project ideas of your own.

[Guidelines for the project list](https://google.github.io/gsocguides/mentor/defining-a-project-ideas-list)

Summarizing that page, each project should include:

* Title
* Description
* Expected outputs
* Skills required/preferred
* Possible mentors
* Size (either ~175 or ~350 hours)
* Difficulty (easy, medium or hard)

## Performance optimization for coreutils

While [uutils/coreutils](https://github.com/uutils/coreutils) has achieved strong GNU compatibility, some utilities can still benefit from performance improvements to match or exceed GNU coreutils speed. This project focuses on identifying performance bottlenecks and implementing optimizations across key utilities.

The goal is to systematically profile, benchmark, and optimize coreutils to ensure they are production-ready for performance-critical environments.

Key areas of work include:

* Profiling utilities to identify performance bottlenecks (using perf, flamegraph, criterion)
* Creating comprehensive benchmark suite comparing against GNU coreutils
* Optimizing hot paths in frequently-used utilities (cat, cut, sort, uniq, wc, etc.)
* Implementing algorithmic improvements and efficient data structures
* Reducing allocations and improving memory usage patterns
* Leveraging SIMD instructions where applicable for data processing
* Optimizing I/O operations with proper buffering strategies
* Benchmarking across different file sizes and input patterns
* Setting up continuous performance monitoring in CI
* Documenting performance characteristics and optimization techniques

* **Difficulty**: Medium
* **Size**: ~175 hours
* **Mentors**: TBD
* **Required skills**:
  + Rust
  + Performance profiling and optimization techniques
  + Understanding of systems programming and I/O optimization
  + Benchmarking methodologies
  + Knowledge of SIMD and parallel processing is a plus
  + Familiarity with coreutils behavior

## Expand differential fuzzing for coreutils

The [uutils/coreutils](https://github.com/uutils/coreutils) project has [some fuzzing infrastructure](https://github.com/uutils/coreutils/tree/main/fuzz/fuzz_targets) in place, but many utilities still lack comprehensive fuzz testing. This project focuses on expanding differential fuzzing coverage across coreutils to identify edge cases, improve robustness, and ensure compatibility with GNU coreutils.

Differential fuzzing compares the behavior of uutils implementations against GNU coreutils to automatically detect discrepancies and bugs that might be missed by traditional testing.

Key areas of work include:

* Creating new fuzz targets for utilities that currently lack them
* Implementing differential fuzzing harnesses that compare uutils vs GNU outputs
* Expanding existing fuzz targets to cover more code paths and options
* Setting up structured fuzzing campaigns with AFL++ and libFuzzer
* Integrating continuous fuzzing into CI/CD workflows
* Triaging and fixing bugs discovered through fuzzing
* Creating a corpus of interesting test inputs for regression testing
* Documenting fuzzing infrastructure and best practices
* Performance profiling of fuzz targets to maximize coverage

* **Difficulty**: Medium
* **Size**: ~175 hours
* **Mentors**: TBD
* **Required skills**:
  + Rust
  + Experience with fuzzing tools (AFL++, libFuzzer, cargo-fuzz)
  + Understanding of differential testing methodologies
  + Debugging and bug triage skills
  + Familiarity with coreutils behavior

## Complete `findutils` GNU compatibility

The [uutils/findutils](https://github.com/uutils/findutils) project has made significant progress with [more than half](https://github.com/uutils/findutils-tracking/) of the GNU findutils and BFS tests passing. This project focuses on completing the remaining work to achieve full GNU compatibility and production readiness.

The goal is to finish implementing missing features, fix failing test cases, and ensure the utilities (`find`, `xargs`, `locate`, etc.) are fully compatible with their GNU counterparts.

Key areas of work include:

* Implementing missing command-line options and predicates for `find`
* Fixing edge cases in file system traversal and symlink handling
* Completing `xargs` implementation with proper argument handling
* Improving performance and memory efficiency
* Setting up fuzzing infrastructure for differential testing
* Implementing fuzz targets similar to the [coreutils fuzzing approach](https://github.com/uutils/coreutils/tree/main/fuzz/fuzz_targets)
* Running and passing remaining GNU test suite cases
* Conducting differential fuzzing against GNU findutils and BFS

* **Difficulty**: Medium
* **Size**: ~175 hours
* **Mentors**: Sylvestre
* **Required skills**:
  + Rust
  + Understanding of file system operations
  + Familiarity with `find` and `xargs` usage
  + Experience with fuzzing tools is a plus

## Complete `diffutils` GNU compatibility

The [uutils/diffutils](https://github.com/uutils/diffutils) project provides Rust implementations of `diff`, `diff3`, `cmp`, and `sdiff`. Significant progress has been made, but additional work is needed to achieve full GNU compatibility and handle all edge cases.

This project focuses on completing the remaining features, fixing compatibility issues, and ensuring all utilities pass the GNU test suite.

Key areas of work include:

* Implementing missing options and output formats for `diff`
* Improving algorithm efficiency for large file comparisons
* Completing `diff3` three-way merge functionality
* Fixing edge cases in binary file detection and handling
* Supporting all unified and context diff formats
* Running and passing the GNU diffutils test suite
* Performance benchmarking and optimization
* Adding fuzzing infrastructure for differential testing against GNU diffutils

* **Difficulty**: Medium
* **Size**: ~175 hours
* **Mentors**: TBD
* **Required skills**:
  + Rust
  + Understanding of diff algorithms (Myers, Patience, etc.)
  + Familiarity with `diff` and patch workflows
  + Text processing and parsing

## Complete the Rust implementation of `sed`

The `sed` (stream editor) utility is a fundamental Unix tool for parsing and transforming text. A Rust implementation has been started but requires significant work to achieve full compatibility with GNU `sed` and POSIX standards.

This project focuses on completing the existing Rust `sed` implementation to make it production-ready. The work involves implementing missing commands and flags, fixing edge cases, improving regular expression support, and ensuring the implementation passes the GNU test suite.

Key areas of work include:

* Implementing missing `sed` commands and addressing flags
* Handling complex regular expressions and backreferences
* Supporting multi-line pattern space operations
* Implementing hold space operations correctly
* Adding support for GNU `sed` extensions
* Fixing edge cases and improving error handling
* Running and passing the GNU `sed` test suite
* Performance optimization and benchmarking against GNU `sed`
* Setting up fuzzing infrastructure for differential testing
* Implementing fuzz targets similar to the [coreutils fuzzing approach](https://github.com/uutils/coreutils/tree/main/fuzz/fuzz_targets)
* Conducting differential fuzzing against GNU `sed` to identify edge cases and bugs

* **Difficulty**: Medium
* **Size**: ~175 hours
* **Mentors**: TBD
* **Required skills**:
  + Rust
  + Understanding of regular expressions
  + Familiarity with `sed` usage and scripting
  + Text processing and parsing concepts
  + Experience with fuzzing tools (AFL++, cargo-fuzz) is a plus

## Rust implementation of `grep`

The goal of this project is to create a high-performance, feature-complete Rust implementation of `grep` (GNU grep) as part of the uutils ecosystem. While tools like `ripgrep` exist, this project aims to provide a drop-in replacement for GNU `grep` with full compatibility, including all command-line options, output formats, and edge case behaviors.

The `grep` utility is one of the most widely-used Unix tools for searching text using patterns. A uutils implementation would need to balance GNU compatibility with the performance advantages that Rust can provide.

Key aspects of the project include:

* Implementing full POSIX and GNU `grep` command-line interface
* Supporting basic regular expressions (BRE), extended regular expressions (ERE), and Perl-compatible regular expressions (PCRE)
* Implementing all output modes (normal, inverted match, count, files-with-matches, etc.)
* Supporting context lines (-A, -B, -C options) and various formatting options
* Handling binary files, compressed files, and recursive directory search
* Optimizing performance for common use cases while maintaining correctness
* Implementing color output and various line-buffering modes
* Running and passing the GNU `grep` test suite
* Setting up fuzzing infrastructure and differential testing against GNU `grep`
* Performance benchmarking against GNU `grep` and other implementations

* **Difficulty**: Hard
* **Size**: ~350 hours
* **Mentors**: TBD
* **Required skills**:
  + Rust
  + Deep understanding of regular expression engines
  + Familiarity with `grep` usage and advanced features
  + Performance optimization and profiling
  + Text processing and I/O optimization techniques

## Rust implementation of `awk`

The goal of this project is to create a Rust-based implementation of `awk`, one of the most powerful and widely-used text processing utilities in Unix/Linux systems. The `awk` utility provides a complete programming language for pattern scanning and processing, making it essential for data extraction, report generation, and text transformation tasks.

This implementation would be a standalone project within the uutils ecosystem, similar to how `findutils` and `diffutils` are organized. The primary objectives are to achieve compatibility with POSIX `awk` specification and GNU `awk` (gawk) extensions, while leveraging Rust's performance and safety guarantees.

Key aspects of the project include:

* Implementing the `awk` lexer and parser for the AWK programming language
* Building the pattern-action execution engine
* Supporting built-in variables (`NR`, `NF`, `FS`, `RS`, etc.) and functions
* Implementing regular expression matching and field splitting
* Adding support for arrays, user-defined functions, and control flow
* Ensuring compatibility with the POSIX `awk` standard
* Gradually implementing GNU `awk` extensions where feasible
* Setting up GNU test suite execution for validation

* **Difficulty**: Hard
* **Size**: ~350 hours
* **Mentors**: TBD
* **Required skills**:
  + Rust
  + Understanding of lexers, parsers, and interpreters
  + Familiarity with `awk` usage and programming
  + Knowledge of regular expressions
  + Experience with programming language implementation is a plus

## Complete `procps` implementation and GNU compatibility

The [uutils/procps](https://github.com/uutils/procps) project aims to reimplement process and system monitoring utilities in Rust. While initial implementations have been started for various tools, this project focuses on completing the core utilities and achieving production readiness with full GNU compatibility.

This project focuses on complet