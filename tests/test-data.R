testthat::test_that(
  "processed data has the right properties",
  {
    library(tidyverse)
    withr::local_dir("..")
    df <- read_csv("./data/processed/data.csv")
    testthat::expect_gte(min(df$hours_studied), 0)
    testthat::expect_gte(min(df$sleep_hours), 0)
    testthat::expect_gte(min(df$attendance_percent), 0)
    testthat::expect_lte(max(df$attendance_percent), 1)
    testthat::expect_gte(min(df$previous_scores), 0)
    testthat::expect_lte(max(df$previous_scores), 1)
    testthat::expect_gte(min(df$exam_score), 0)
    testthat::expect_lte(max(df$exam_score), 1)
  }
)
