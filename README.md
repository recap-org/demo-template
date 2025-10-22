# RECAP Demo template

## Purpose

[RECAP](https://recap-org.github.io) (Reproducible Environments for Collaborative Academic Projects) helps social scientists start projects with fully reproducible, ready-to-use research environments. This repository is a RECAP-generated starter template for academic data projects using the QuaLaR (Quarto + LaTeX + R) stack and is designed to run inside the provided devcontainer or in cloud IDEs (e.g., GitHub Codespaces) and local IDEs (VS Code, RStudio).

Key features provided by this template and the RECAP environment:

- A containerized, reproducible software environment with a preconfigured statistical language (R, Python, or Stata) and LaTeX for writing.
- A clear workflow that converts raw data into processed data, analyses processed data into figures and tables, and uses those assets in LaTeX documents (article, appendix, presentation).
- Built-in practices for reproducible research: version control ([git](https://git-scm.com/)), dependency management ([renv](https://rstudio.github.io/renv/)), automated build pipelines ([Make](https://www.gnu.org/software/make/make.html)), and testing ([testthat](https://testthat.r-lib.org/)).
- Documentation and tutorials (see the [RECAP](https://recap-org.github.io) site) to help you get started and teach collaborators.

The building blocks of this template are:

1. Clean raw data to produce processed data
2. Analyse the processed data to produce tables and figures
3. Use the tables and figures in a series of LaTeX documents: the research article, a separate appendix, and a Beamer presentation. 

These three steps are orchestrated using Make, which ensures that each step is only re-executed when necessary.

## Getting started

To get started, above the file list, click **Use this template**.

![Use this template button](https://docs.github.com/assets/cb-76823/mw-1440/images/help/repository/use-this-template-button.webp)

You have two options: 

### Try it out online

1. Select **Open in a codespace**. 
2. Wait for the codespace to be created and started. **This may take up to 10 minutes.** ☕
3. Once the codespace is ready, you can follow the instructions in the **Basic demo** section below.

### Make your own copy

1. Select **Create a new repository**.
2. Once it is ready, you can: 
    - Open it in GitHub Codespaces by clicking the green **Code** button and selecting **Open with Codespaces > New codespace**.
    - Clone it to your local machine use it locally. Make sure you have [Docker](https://www.docker.com/get-started/) and [Devpod](https://devpod.sh/) installed and running. Then, open the project with Devpod to get the same containerized environment as in Codespaces, but in the IDE of your choice: VS Code, Positron, RStudio (Windows only). On VS Code, you can also use the [VS Code Remote - Containers](https://code.visualstudio.com/docs/remote/containers) extension if you prefer not to use Devpod.

## Basic demo

On VS Code or Github Codespaces, click Menu > View > Open the Command Palette (or press Ctrl + Shift + P) to open the Command Palette, then type "Makefile: Build the current target" and press Enter. Otherwise, you can open a terminal in your IDE and type:

```bash
make
```

 This will run the data cleaning script, then do the analysis, and finally compile all the LaTeX documents. You will find the final documents in the `./bin/tex` directory and intermediary reports of the data cleaning and analysis steps in the `./bin/src` directory.

Run the tests by opening a terminal and typing: 

```bash
make tests
```

## Using this template

This template is organized as follows

```bash
├── LICENSE
├── README.md
├── assets
│   ├── figures
│   ├── static
│   └── tables
├── bin
│   ├── src
│   └── tex
├── data
│   ├── processed
│   └── raw
├── Makefile
├── _quarto.yaml
├── renv
├── renv.lock
├── src
│   ├── analysis
│   ├── data
│   └── lib
├── tests
├── library.bib
└── tex
    ├── appendix
    ├── article
    └── presentation
```

### From data cleaning to document production

When running the command `make all` in the terminal, this template uses GNU make to execute three steps: 

1. **Clean raw data.** Run all the scripts in the `./src/data` directory
2. **Do the analysis.** Run all the scripts in the `./src/analysis` directory
3. **Compile the LaTeX documents.** Build all the documents in the `./tex` directory

Try and customize `./Makefile` to change how the build steps are executed. 

#### Step 1: cleaning raw data

The raw data should be placed in the `./data/raw` directory, and committed to git (unless it is very large, in which case you should consider alternative storage solutions). 

The code that processes that data into raw data should be a series of Quarto `.qmd` scripts placed in the `./src/data` directory. Each script should produce a series of clean datasets, to be placed in the `./data/processed` directory. Each script should be able to run in parallel (i.e., they should not depend on previous scripts). 

Using Quarto has a series of advantages. First, it always produces a single, traceable `.pdf` output that can be used for build scripts. Second, Quarto provides easy to read output. Third, Quarto has a cache feature that can dramatically speed up code re-execution. 

#### Step 2: doing the analysis

The code that does the analysis uses the processed data to procude tables and figures used in the LaTeX documents. This code should be a series of Quarto `.qmd` scripts placed in the `./src/analysis` directory. Each script takes the processed data in `./data/processed` as inputs, and stores its outputs in `./assets/tables` and `./assets/figures`. This template provides the helper functions `save_figure` and `save_table` that do this for you. These functions are in `./src/lib/io.R`. 

#### Step 3: compiling the LaTeX documents

Each LaTeX document is a sub-directory of `./tex`. The main `.tex` file of each document must be called `main.tex`. Each LaTeX document has symlinks to the `./assets` directory and to `./library.bib` for shared use of the project's assets and bibliography. 

A project may also use assets that are not generated by code (e.g., external images, ...). These should be placed in `./assets/static` and committed to git. 

### Helper functions

Helper functions are shared across your data and analysis code. They are declared in `.R` files that are placed in `./src/lib`. Think of these helper functions as a quasi-R package that accompanies the project. As such, each of these functions should be properly documented so that all collaborators understand how they work.  

### Tests

Tests are placed in the `./tests` directory. They should be files called `test-NAME.R`, with `NAME` a friendly name for your series of tests. 

You should specify tests to ensure that the raw data has been properly cleaned and that the helper functions work as intended. 

### Configuration

Look into the following files to tweak things as you see fit: 

- `./.lintr`: R linting options
- `./_quarto.yaml`: Quarto options

## Credits

We thank 

- [Jason Leung](https://unsplash.com/@ninjason?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash) on [Unsplash](https://unsplash.com/photos/donkey-kong-arcade-game-screen-with-1981-date-c5tiCWrZADc?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash) for that nice Donkey Kong photo.
- [grandmaster07](https://www.kaggle.com/grandmaster07) for the student exam score dataset analysis published on [Kaggle](https://www.kaggle.com/datasets/grandmaster07/student-exam-score-dataset-analysis)

