cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-math
label: connectome-workbench_wb_command_cifti-math
doc: "This command evaluates <expression> at each matrix element independently. There must be at least one -var option (to get the output layout from), even if the <name> specified in it isn't used in <expression>. To select a single column from a 2D file (most cifti files are 2D), use -select 1 <index>, where <index> is 1-based. To select a single row from a 2D file, use -select 2 <index>. Where -select is not used, the cifti files must have compatible mappings (e.g., brain models and parcels mappings must match exactly except for parcel names). Use -override-mapping-check to skip this checking. Filenames are not valid in <expression>, use a variable name and a -var option with matching <name> to specify an input file. The format of <expression> is as follows: Expressions consist of constants, variables, operators, parentheses, and functions, in infix notation, such as 'exp(-x + 3) * scale'. Variables are strings of any length, using the characters a-z, A-Z, 0-9, and _, but may not take the name of a named constant. Currently, there is only one named constant, PI. The operators are +, -, *, /, ^, >, <, >=, <=, ==, !=, !, &&, ||. These behave as in C, except that ^ is exponentiation, i.e. pow(x, y), and takes higher precedence than other binary operators (also, '-3^-4^-5' means '-(3^(-(4^-5)))'). The <=, >=, ==, and != operators are given a small amount of wiggle room, equal to one millionth of the smaller of the absolute values of the values being compared. Comparison and logical operators return 0 or 1, you can do masking with expressions like 'x * (mask > 0)'. For all logical operators, an input is considered true iff it is greater than 0. The expression '0 < x < 5' is not syntactically wrong, but it will NOT do what is desired, because it is evaluated left to right, i.e. '((0 < x) < 5)', which will always return 1, as both possible results of a comparison are less than 5. A warning is generated if an expression of this type is detected. Use something like 'x > 0 && x < 5' to get the desired behavior. Whitespace between elements is ignored, ' sin ( 2 * x ) ' is equivalent to 'sin(2*x)', but 's in(2*x)' is an error. Implied multiplication is not allowed, the expression '2x' will be parsed as a variable. Parentheses are (), do not use [] or {}. Functions require parentheses, the expression 'sin x' is an error. The following functions are supported: sin: 1 argument, the sine of the argument (units are radians) cos: 1 argument, the cosine of the argument (units are radians) tan: 1 argument, the tangent of the argument (units are radians) asin: 1 argument, the inverse of sine of the argument, in radians acos: 1 argument, the inverse of cosine of the argument, in radians atan: 1 argument, the inverse of tangent of the argument, in radians atan2: 2 arguments, atan2(y, x) returns the inverse of tangent of (y/x), in radians, determining quadrant by the sign of both arguments sinh: 1 argument, the hyperbolic sine of the argument cosh: 1 argument, the hyperbolic cosine of the argument tanh: 1 argument, the hyperboloc tangent of the argument asinh: 1 argument, the inverse hyperbolic sine of the argument acosh: 1 argument, the inverse hyperbolic cosine of the argument atanh: 1 argument, the inverse hyperboloc tangent of the argument ln: 1 argument, the natural logarithm of the argument exp: 1 argument, the constant e raised to the power of the argument log: 1 argument, the base 10 logarithm of the argument sqrt: 1 argument, the square root of the argument abs: 1 argument, the absolute value of the argument floor: 1 argument, the largest integer not greater than the argument round: 1 argument, the nearest integer, with ties rounded away from zero ceil: 1 argument, the smallest integer not less than the argument min: 2 arguments, min(x, y) returns y if (x > y), x otherwise max: 2 arguments, max(x, y) returns y if (x < y), x otherwise mod: 2 arguments, mod(x, y) = x - y * floor(x / y), or 0 if y == 0 clamp: 3 arguments, clamp(x, low, high) = min(max(x, low), high)\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
requirements:
  - class: SchemaDefRequirement
    types:
      - name: select_item
        type: record
        fields:
          - name: dim
            type: int
            doc: the dimension to select from (1-based)
            inputBinding:
              position: 1
              prefix: -select
          - name: index
            type: int
            doc: the index to use (1-based)
            inputBinding:
              position: 2
          - name: repeat
            type:
              - 'null'
              - boolean
            doc: repeat the selected values for each index of output in this dimension
            inputBinding:
              position: 3
              prefix: -repeat
      - name: var_item
        type: record
        fields:
          - name: name
            type: string
            doc: the name of the variable, as used in the expression
            inputBinding:
              position: 1
              prefix: -var
          - name: cifti
            type: File
            doc: the cifti file to use as this variable
            inputBinding:
              position: 2
          - name: select
            type:
              - 'null'
              - type: array
                items: select_item
            doc: select a single index from a dimension (repeatable)
            inputBinding:
              position: 3
inputs:
  - id: expression
    type: string
    doc: the expression to evaluate, in quotes
    inputBinding:
      position: 1
  - id: cifti_out
    type: string
    doc: the output cifti file
    inputBinding:
      position: 2
  - id: fixnan
    type:
      - 'null'
      - float
    doc: 'replace NaN results with a value: value to replace NaN with'
    inputBinding:
      position: 3
      prefix: -fixnan
  - id: override_mapping_check
    type:
      - 'null'
      - boolean
    doc: don't check the mappings for compatibility, only check length
    inputBinding:
      position: 4
      prefix: -override-mapping-check
  - id: var
    type:
      - 'null'
      - type: array
        items: var_item
    doc: a cifti file to use as a variable (repeatable; one record per use of -var)
    inputBinding:
      position: 5
outputs:
  - id: cifti_out_file
    type: File
    doc: the output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
