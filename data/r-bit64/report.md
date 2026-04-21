# bit64: A S3 Class for Vectors of 64bit Integers

Package 'bit64' provides serializable S3 atomic 64bit (signed) integers.
  These are useful for handling database keys and exact counting in +-2^63.
  WARNING: do not use them as replacement for 32bit integers, integer64 are not
  supported for subscripting by R-core and they have different semantics when
  combined with double, e.g. integer64 + double =&gt; integer64.
  Class integer64 can be used in vectors, matrices, arrays and data.frames.
  Methods are available for coercion from and to log...

### Metadata
- **Conda**: https://anaconda.org/channels/r/packages/r-bit64/overview
- **R-project (CRAN)**: https://cloud.r-project.org/web/packages/bit64/index.html
- **Home (project)**: https://github.com/truecluster/bit64
- **Package**: bit64
- **Version**: 4.6.0-1
- **Author**: Michael Chirico [aut, cre], Jens Oehlschlägel [aut], Leonardo Silvestri [ctb], Ofek Shilon [ctb]
- **Maintainer**: Michael Chirico <michaelchirico4 at gmail.com>
- **Docker Image**: quay.io/biocontainers/r-bit64:0.9_5--r3.2.2_0
- **Skill**: generated
- **Total Downloads**: 141.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/truecluster/bit64
- **Stars**: N/A

