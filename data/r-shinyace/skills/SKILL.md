---
name: r-shinyace
description: The r-shinyace package provides R Shiny bindings for the Ace text editor to embed professional code editors into web applications. Use when user asks to integrate a code editor into a Shiny UI, programmatically update editor content, or handle code evaluation and custom autocompletion within an app.
homepage: https://cran.r-project.org/web/packages/shinyace/index.html
---


# r-shinyace

## Overview
The `shinyAce` package provides R Shiny bindings for the Ace text editor. It allows developers to embed a professional-grade code editor into their web applications. Key features include reactive text input, programmatic updates, support for dozens of programming languages (modes), visual themes, and advanced editor interactions like cursor tracking and custom autocompletion.

## Installation
Install the stable version from CRAN:
```R
install.packages("shinyAce")
```

## Core Functions

### UI Definition
Use `aceEditor()` to place the editor in your UI.
```R
aceEditor(
  outputId = "my_editor",
  value = "print('Hello World')",
  mode = "r",
  theme = "monokai",
  height = "400px",
  fontSize = 14,
  wordWrap = TRUE,
  autoComplete = "enabled"
)
```

### Server-Side Updates
Use `updateAceEditor()` to modify an existing editor instance reactively.
```R
updateAceEditor(
  session,
  "my_editor",
  value = "new_content",
  mode = "python",
  theme = "github"
)
```

### Accessing Input
The editor content is available via `input$outputId`.
```R
observe({
  print(input$my_editor)
})
```

## Common Workflows

### Code Evaluation
To evaluate R code written in the editor:
```R
output$output_text <- renderPrint({
  input$eval_button # Action button trigger
  isolate(eval(parse(text = input$my_editor)))
})
```

### Handling Selections and Cursor
To capture specific text selections or cursor positions, use the `selectionId` and `cursorId` parameters in `aceEditor()`.
```R
aceEditor("my_editor", selectionId = "my_selection")

# Access in server
observe({
  req(input$my_selection)
  print(input$my_selection) # Returns the highlighted text
})
```

### Custom Autocompletion
Enable autocompletion by setting `autoComplete = "enabled"`. You can provide custom completion lists:
```R
aceEditor(
  "my_editor",
  autoComplete = "enabled",
  autoCompleters = "static",
  staticCompleters = list(c("function1", "function2", "variableA"))
)
```

### Hotkeys
Define keyboard shortcuts to trigger server-side logic:
```R
aceEditor(
  "my_editor",
  hotkeys = list(run_code = "Ctrl-Enter")
)

observeEvent(input$my_editor_run_code, {
  # Logic to execute when Ctrl-Enter is pressed
})
```

## Tips and Best Practices
- **Security**: Never allow arbitrary code execution (`eval()`) in a public-facing application without strict authentication and sandboxing.
- **Sizing**: Use `height = "auto"` or specific pixel/percent values to ensure the editor fits your layout.
- **Modules**: When using in Shiny modules, ensure `outputId` is wrapped in `ns()` in the UI, but `updateAceEditor` handles the session context automatically if the correct session object is passed.

## Reference documentation
- [shinyAce README](./references/README.html.md)
- [shinyAce Home Page](./references/home_page.md)