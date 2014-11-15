
gherkinfmt - Gherkin Formater
=============================

`gherkinfmt` is a command line tool to format `.feature` files which use the [Gherkin][] language that drives Story/Feature based Behavior Driven Development. 

`gherkinfmt` is written in [golang][] and is just a frontend to the [go-gherkin][] package which covers all the parsing and formating.

Install
-------

### Install from source

```bash
$ go install github.com/muhqu/gherkinfmt
...
$ gherkinfmt -version # verify install
```

### Install binary

Grap a binary release from the [releases](https://github.com/muhqu/gherkinfmt/releases) section.


Usage
-----

```
gherkinfmt OPTIONS

Formating Options
  -centersteps[=false]       control step alignment
  -nosteps[=false]           hide steps
  -nocomments[=false]        hide comments
  -noaligncomments[=false]   disable auto alignment of subsequent comments
  -mincommentindent=NUM      use min indent for aligned comments

IO Options
  -[no]color                 explicitly enable/disable colors
  -in PATH                   path to input file, defaults to stdin
  -out PATH                  path to output file, defaults to stdout

Misc Options
  -version                   version: ...
  -help                      this help
```

Examples
--------

```
$ gherkinfmt -in path/to/some.feature
```

```
$ cat path/to/some.feature | gherkinfmt -centersteps
```

Thanks
------

Thanks to [@peppe](http://github.com/pebbe) for the [util package](github.com/pebbe/util) which is used to detect whether `os.Stdout` is a Terminal or not.

Thanks to [@pointlander](http://github.com/pointlander) for the incredibble [peg package](http://github.com/pointlander/peg), providing a Parser Expression Grammar Parser Generator. [go-gherkin][] is [implemented using peg](https://github.com/muhqu/go-gherkin/blob/master/gherkin.peg).


Author
------

|   |   |
|---|---|
| ![](http://gravatar.com/avatar/0ad964bc2b83e0977d8f70816eda1c70) | © 2014 by Mathias Leppich <br>  [github.com/muhqu](https://github.com/muhqu), [@muhqu](http://twitter.com/muhqu) |
|   |   |

---
[Gherkin]: http://wikipedia.com/Gherkin
[golang]: http://golang.org/
[go-gherkin]: http://github.com/muhqu/go-gherkin
