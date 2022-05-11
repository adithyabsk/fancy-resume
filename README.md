# My LaTeX resume

[Click here to see the pdf](./resume.pdf)

## Installation

```bash
$ brew install --cask mactex
$ brew install texshop # For GUI interface
# $ pre-commit install
```

## Linting

Note: you may need to install missing packages using `tlmgr install [PACKAGE]`

```bash
$ make lint
```

## Compilation

Simply run make
```bash
$ make
```

## Managing Packages

```bash
sudo tlmgr update --list
# sudo tlmgr update --all
```

### Source

This resume is based on the amazing style file by [Cies Breijs](https://github.com/cies) To see the original [README, please go here.](https://github.com/cies/resume)
