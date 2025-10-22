testthat::test_that(
  "save_figure works",
  {
    library(tidyverse)
    withr::local_dir("..")
    withr::defer(unlink("./assets/figures/test.pdf"))
    source("./src/lib/io.R")
    df <- tibble(x = rnorm(10), y = rnorm(10))
    ggplot(df, aes(x = x, y = y)) + geom_point()
    save_figure("test")
    testthat::expect_true(file.exists("./assets/figures/test.pdf"))
  }
)

testthat::test_that(
  "save_table works",
  {
    library(tidyverse)
    library(modelsummary)
    withr::local_dir("..")
    withr::defer(unlink("./assets/tables/test.tex"))
    source("./src/lib/io.R")
    df <- tibble(x = rnorm(10), y = rnorm(10))
    datasummary_skim(
      df,
      fun_numeric = list(
        Mean = Mean,
        SD = SD
      ),
      escape = FALSE
    ) |> save_table("test")
    testthat::expect_true(file.exists("./assets/tables/test.tex"))
  }
)
