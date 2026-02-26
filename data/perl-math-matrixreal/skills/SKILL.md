---
name: perl-math-matrixreal
description: The Math::MatrixReal module provides a comprehensive suite of linear algebra operations for handling NxN matrices of real numbers in Perl. Use when user asks to create matrices from strings or arrays, perform matrix arithmetic and inversion, calculate determinants, or manipulate rows and columns.
homepage: http://metacpan.org/pod/Math::MatrixReal
---


# perl-math-matrixreal

## Overview
The `Math::MatrixReal` module is a powerful tool for handling NxN matrices of real numbers in Perl. It provides a comprehensive suite of linear algebra operations, including matrix multiplication, inversion, and decomposition. This skill enables the creation of matrices from various sources—such as strings, arrays, or random generators—and facilitates complex mathematical workflows through overloaded operators that make Perl code look like standard algebraic notation.

## Core Usage Patterns

### Matrix Initialization
There are several ways to instantiate a matrix object depending on your data source:

*   **From Strings (Best for readability):** Use the "here-document" syntax for clear, visual matrix definitions.
    ```perl
    my $matrix = Math::MatrixReal->new_from_string(<<"MATRIX");
    [ 1.0  0.5  0.0 ]
    [ 0.5  1.0  0.5 ]
    [ 0.0  0.5  1.0 ]
    MATRIX
    ```
*   **From Arrays:** Use `new_from_rows` or `new_from_cols` when dealing with dynamic data.
    ```perl
    my $m = Math::MatrixReal->new_from_rows([ [1, 2], [3, 4] ]);
    ```
*   **Special Matrices:** Quickly generate common structures.
    ```perl
    my $diag = Math::MatrixReal->new_diag([ 1, 5, 9 ]);
    my $rand = Math::MatrixReal->new_random(5, 5, { integer => 1, bounded_by => [0, 100] });
    ```

### Matrix Operations
The module overloads standard operators to simplify matrix math:

*   **Arithmetic:** Use `+`, `-`, and `*` for addition, subtraction, and multiplication (matrix-matrix or scalar-matrix).
*   **Exponentiation:** `$a ** 3` calculates the cube of a matrix; `$a ** -1` calculates the inverse.
*   **Transpose:** Use the tilde `~$a` or `$a->transpose`.
*   **Inversion:** Use `1/$a` or `$a->inverse`.
*   **Determinant:** `$a->det` returns the determinant as a scalar.

### Row and Column Manipulation
Extract specific parts of a matrix for vector operations:
```perl
my $row_vector = $matrix->row(2); # Returns 2nd row as a 1xN matrix
my $col_vector = $matrix->col(1); # Returns 1st column as an Nx1 matrix
```

## Expert Tips and Best Practices

*   **Precision Control:** By default, stringification uses scientific notation. Use `$matrix->display_precision($n)` to set the number of decimal places for output. Setting it to `0` shows only integers.
*   **Memory Efficiency:** Note that `new` and other constructors are called implicitly by many methods. For very large matrices, be mindful of memory overhead as this is a pure-Perl implementation.
*   **String Round-tripping:** You can save a matrix to a file by simply printing it (`print $matrix`) and read it back using `new_from_string`. However, be aware that stringification may result in a loss of precision (typically limited to 13 digits in the mantissa).
*   **Error Handling:** When using `new_from_string` with user input, wrap the call in an `eval` block to catch syntax exceptions and prevent script termination.

## Reference documentation
- [Math::MatrixReal - Matrix of Reals](./references/metacpan_org_pod_Math__MatrixReal.md)
- [perl-math-matrixreal - bioconda](./references/anaconda_org_channels_bioconda_packages_perl-math-matrixreal_overview.md)