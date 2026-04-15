---
name: perl-math-matrix
description: This tool provides a suite of methods for performing matrix algebra and handling 2D numerical arrays as mathematical objects in Perl. Use when user asks to initialize matrices, perform operations like multiplication and inversion, or solve systems of linear equations.
homepage: https://metacpan.org/pod/Math::Matrix
metadata:
  docker_image: "quay.io/biocontainers/perl-math-matrix:0.94--pl5321hdfd78af_2"
---

# perl-math-matrix

## Overview
The `perl-math-matrix` skill enables efficient handling of 2D numerical arrays as mathematical objects. It provides a comprehensive suite of methods for matrix algebra, allowing you to perform complex operations like LU decomposition, transposition, and solving systems of equations without manual implementation of the underlying algorithms. This skill is particularly useful when automating data processing pipelines where matrix-based transformations are required.

## Core Usage Patterns

### Matrix Initialization
Matrices can be created from nested arrays, row vectors, or column vectors.
```perl
use Math::Matrix;

# From nested array (rows)
my $A = Math::Matrix->new([[1, 2], [3, 4]]);

# From row vectors
my $B = Math::Matrix->new_from_rows([5, 6], [7, 8]);

# From column vectors
my $C = Math::Matrix->new_from_cols([1, 3], [2, 4]);
```

### Common Mathematical Operations
Most methods return a new matrix object, leaving the original unchanged.
```perl
my $sum        = $A->add($B);       # Addition
my $diff       = $A->sub($B);       # Subtraction
my $product    = $A->multiply($B);  # Matrix multiplication
my $transpose  = $A->transpose;     # Transposition
my $inverse    = $A->invert;        # Inversion
```

### Solving Linear Systems
To solve $Ax = b$, concatenate the result vector $b$ to matrix $A$ and use the `solve` method.
```perl
# Solve Ax = b
my $A = Math::Matrix->new([[2, 1], [1, -1]]);
my $b = Math::Matrix->new([[5], [1]]);

my $system = $A->concat($b);
my $solution = $system->solve; 
$solution->print("Solution vector x:");
```

### Specialized Constructors
- `Math::Matrix->id($n)`: Creates an $n \times n$ identity matrix.
- `Math::Matrix->zeros($m, $n)`: Creates an $m \times n$ matrix of zeros.
- `Math::Matrix->rand($m, $n)`: Creates a matrix with random values between 0 and 1.
- `Math::Matrix->new_from_sub(sub { ... }, $m, $n)`: Generates elements based on a function of row/column indices.

## Expert Tips
- **Method Chaining**: Since methods return new objects, you can chain operations: `$result = $A->multiply($B)->transpose()->invert();`.
- **Overloading**: The module supports operator overloading. You can use `$C = $A + $B` or `$A += $B` for more readable code.
- **Printing**: Use `$matrix->print("Label")` for quick debugging; it formats the matrix into a human-readable grid.
- **Memory**: For very large matrices, be mindful that methods like `add` and `multiply` create new objects rather than modifying in-place, which increases memory consumption.

## Reference documentation
- [Math::Matrix - multiply and invert matrices](./references/metacpan_org_pod_Math__Matrix.md)
- [perl-math-matrix - bioconda overview](./references/anaconda_org_channels_bioconda_packages_perl-math-matrix_overview.md)