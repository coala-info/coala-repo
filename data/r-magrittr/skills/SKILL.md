---
name: r-magrittr
description: "Provides a mechanism for chaining commands with a new     forward-pipe operator, %&gt;%. This operator will forward a value, or the     result of an expression, into the next function call/expression.     There is flexible support for the type of right-hand side expressions.     For more information, see package vignette.  To quote Rene Magritte,     \"Ceci n'est pas un pipe.\"</p>"
homepage: https://cloud.r-project.org/web/packages/magrittr/index.html
---

# r-magrittr

name: r-magrittr
description: Provides the forward-pipe operator (`%>%`) and related semantic pipes for R. Use this skill when you need to chain R commands to improve code readability, reduce nested function calls, or perform data munging workflows. It includes specialized pipes for side effects (%T>%), exposing variables (%$%), and compound assignment (%<>%).

# r-magrittr

## Overview
The `magrittr` package provides a mechanism for chaining commands in R using the forward-pipe operator, `%>%`. It forwards a value or the result of an expression into the next function call, allowing for a "recipe-like" coding style that follows logical execution order rather than nested function calls.

## Installation
```R
install.packages("magrittr")
library(magrittr)
```

## Core Operators

### The Forward-Pipe: `%>%`
Pipes the left-hand side (LHS) into the right-hand side (RHS).
- **Default**: LHS becomes the first argument of the RHS function.
- **Placeholder**: Use a dot `.` to place the LHS in a specific position other than the first.
- **Unary Functions**: A pipeline starting with `.` creates a function.

```R
# Basic usage
mtcars %>% head()

# Using the dot placeholder
mtcars %>% subset(hp > 100) %>% lm(mpg ~ cyl, data = .)

# Building a function
avg_round <- . %>% mean() %>% round(2)
```

### The Tee Pipe: `%T>%`
Works like `%>%` but returns the LHS instead of the RHS result. Ideal for side effects like plotting or printing in the middle of a chain.
```R
rnorm(100) %T>% plot() %>% sum()
```

### The Exposition Pipe: `%$%`
Exposes the names within the LHS object to the RHS expression. Useful for functions that don't have a `data` argument.
```R
iris %$% cor(Sepal.Length, Sepal.Width)
```

### The Assignment Pipe: `%<>%`
Updates the LHS object with the result of the pipeline. Must be the first pipe in the chain.
```R
x <- 1:10
x %<>% sqrt() %>% log()
```

## Advanced Workflows

### Anonymous Functions (Lambdas)
You can pipe into complex expressions using curly braces `{}`.
```R
mtcars %>%
{ 
  if (nrow(.) > 0)
    rbind(head(., 1), tail(., 1))
  else .
}
```

### Functional Aliases
`magrittr` provides aliases for standard operators to make them pipe-friendly:
- `add()`: `+`
- `subtract()`: `-`
- `multiply_by()`: `*`
- `divide_by()`: `/`
- `extract()`: `[`
- `extract2()`: `[[`
- `set_colnames()`: `colnames<-`

```R
# Instead of `*`(5)
rnorm(10) %>% multiply_by(5) %>% add(10)
```

## Best Practices
- **Readability**: Use pipes to replace deeply nested calls like `f(g(h(x)))` with `x %>% h() %>% g() %>% f()`.
- **Debugging**: If a pipeline fails, check the intermediate steps by inserting `%T>% print()`.
- **Base R Pipe**: Note that R 4.1.0+ introduced a native pipe `|>`. Use `magrittr` when you need the dot placeholder, specialized pipes (`%T>%`, `%$%`), or functional aliases not supported by the native pipe.

## Reference documentation
- [Introducing magrittr](./references/magrittr.Rmd)
- [Design tradeoffs](./references/tradeoffs.Rmd)