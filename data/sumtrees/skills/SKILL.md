---
name: sumtrees
description: Manages and queries SumTree data structures for efficient text editing and manipulation. Use when user asks to create, edit, or query SumTree data structures, or to get line and column information.
homepage: https://github.com/brmassa/SumTree
---


# sumtrees

yaml
name: sumtrees
description: |
  Manages and queries SumTree data structures. Use when you need to perform efficient text editing, querying, and manipulation with computed summaries, especially for large datasets or scenarios requiring high performance and immutability. This skill is for interacting with the SumTree library, not for general text processing.
```
## Overview
The `sumtrees` skill is designed to help you interact with the SumTree data structure, a high-performance, immutable data structure optimized for fast text editing, querying, and manipulation. It's particularly useful when you need to maintain computed summaries for custom metrics alongside your data, offering benefits like structural sharing for memory efficiency and thread-safe operations due to its immutable nature. This skill focuses on the native command-line usage of the SumTree library.

## Usage Instructions

SumTree is primarily a C# library. Interaction with it typically occurs within a C# development environment. This skill assumes you are working within a .NET project where you can add and utilize the SumTree NuGet package.

### Installation

To use SumTree in your C# project, add the NuGet package:

```bash
dotnet add package BrunoMassa.SumTree
```

### Basic Usage

SumTree can be created from various data types, including strings, arrays, and collections.

**Creating a SumTree from a string:**

```csharp
using SumTree;

// Create a SumTree of characters from a string
SumTree<char> text = "Hello, World!".ToSumTree();
```

**Creating a SumTree from an array or collection:**

```csharp
using SumTree;

// Create a SumTree of integers from an array
SumTree<int> numbers = new int[] { 1, 2, 3, 4, 5 }.ToSumTree();

// Create a SumTree of strings from an array
SumTree<string> words = new string[] { "Hello", "World" }.ToSumTree();
```

### String-like Operations

SumTree<char> supports many familiar string operations.

**Concatenation:**

```csharp
SumTree<char> combined = text + " How are you?".ToSumTree();
```

**Length:**

```csharp
int length = text.Length;
```

**Conversion to string:**

```csharp
string textString = text.ToString();
```

### Text Editing with Line Tracking

SumTree can efficiently track line and column numbers, which is crucial for text editors and code analysis.

**Creating a SumTree with line tracking:**

```csharp
SumTree<char> document = @"Line 1
Line 2
Line 3".ToSumTreeWithLines();
```

**Getting line and column information:**

```csharp
var (line, column) = document.GetLineAndColumn(10); // Example: position 10
```

**Finding the start of a line:**

```csharp
long lineStart = document.FindLineStart(2); // Find the starting position of line 2
```

**Getting the content of a specific line:**

```csharp
string lineContent = document.GetLineContent(1); // Get content of line 1
```

**Inserting text at a specific line and column:**

```csharp
SumTree<char> modified = document.InsertAtLineColumn(2, 1, "Modified "); // Insert at line 2, column 1
```

### Bracket Matching and Code Analysis

SumTree can also track bracket counts for code analysis.

**Creating a SumTree with line and bracket tracking:**

```csharp
SumTree<char> code = @"function example() { if (condition) { return [1, 2, 3]; } }".ToSumTreeWithLinesAndBrackets();
```

**Checking bracket balance:**

```csharp
bool balanced = code.AreBracketsBalanced(code.Length);
```

**Finding specific bracket occurrences:**

```csharp
long firstParen = code.FindNthOpenBracket('(', 1); // Position of the first '('
long secondBrace = code.FindNthOpenBracket('{', 2); // Position of the second '{'
```

**Getting bracket summary:**

```csharp
var bracketSummary = code.GetSummary<BracketCountSummary>();
Console.WriteLine($"Open parens: {bracketSummary.OpenParentheses}");
Console.WriteLine($"Open braces: {bracketSummary.OpenCurlyBraces}");
Console.WriteLine($"Open brackets: {bracketSummary.OpenSquareBrackets}");
```

### Powerful Search Operations

SumTree provides efficient search capabilities.

**Finding index of a substring:**

```csharp
long pos1 = text.IndexOf("quick".ToSumTree());
long pos2 = text.IndexOf("the".ToSumTree(), 10); // Start search from position 10
long pos3 = text.LastIndexOf('o'.ToSumTree()); // Last occurrence of 'o'
```

**Checking for containment:**

```csharp
bool hasQuick = text.Contains("quick".ToSumTree());
bool hasSlow = text.Contains("slow".ToSumTree());
```

**Case-insensitive search:**

```csharp
var caseInsensitiveComparer = EqualityComparer<char>.Create(
    (x, y) => char.ToLower(x) == char.ToLower(y),
    c => char.ToLower(c).GetHashCode()
);
long pos4 = text.IndexOf("QUICK".ToSumTree(), caseInsensitiveComparer);
```

### Advanced Operations

SumTree offers efficient methods for manipulating the data structure.

**Slicing:**

```csharp
SumTree<char> slice = text.Slice(7, 5); // Extracts "World"
```

**Removing ranges:**

```csharp
SumTree<char> modified = text.RemoveRange(5, 2); // Removes characters from index 5 to 7
```

**Replacing elements:**

```csharp
SumTree<char> replaced = text.Replace(' ', '_'); // Replaces all spaces with underscores
```

**Inserting at any position:**

```csharp
SumTree<char> inserted = text.Insert(5, '!'); // Inserts '!' at index 5
```

**Combining multiple SumTrees:**

```csharp
var parts = new SumTree<char>[] { "Hello".ToSumTree(), " ".ToSumTree(), "World".ToSumTree() };
SumTree<char> combined = parts.Combine();
```

### Custom Summary Dimensions

You can define custom summary dimensions to track specific metrics.

```csharp
// Example of a custom dimension (requires implementation)
public class VowelCountDimension : SummaryDimensionBase<char, int>
{
    public override int Identity => 0;
    public override int SummarizeElement(char element)
    {
        // Logic to count vowels
        return "aeiouAEIOU".Contains(element) ? 1 : 0;
    }
}

// Usage:
// SumTree<char> textWithVowels = "Example text".ToSumTreeWithCustomDimension<VowelCountDimension>();
// var vowelSummary = textWithVowels.GetSummary<VowelCountDimension>();
// Console.WriteLine($"Vowel count: {vowelSummary.Total}");
```

## Reference documentation
- [SumTree Overview](./references/github_com_brmassa_SumTree.md)
- [SumTree README](./references/github_com_brmassa_SumTree.md)