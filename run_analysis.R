library(tidyverse)
work.dir <- getwd()
train.dir <- paste0(work.dir, "/Data/train")
test.dir <- paste0(work.dir, "/Data/test")
data.dir <- paste0(work.dir,"/Data")

## Import the the common files into R
activity_labels <- read_delim(paste0(data.dir, "/activity_labels.txt"),
                              delim = " ",
                              col_names = c("activity_code", "activity"),
                              col_types = "cc")
features <- read_delim(paste0(data.dir, "/features.txt"), delim = " ",
                       col_names = c("no.", "feature")) %>%
        select(feature)

## Import the training files into R
y_train <- read_fwf(paste0(train.dir, "/y_train.txt"),
                    fwf_widths(1, "activity_code"), col_types = "c")
subject_train <- read_fwf(paste0(train.dir, "/subject_train.txt"),
                          fwf_widths(1, "subject"), col_types = "c")


## to select the columns containing 'mean' and 'standard deviation'
features_mean_std <- features %>% filter(grepl("mean|std", feature)) %>% t()

## to set column types to 'numeric' in training/test set
c_type = strrep("n", nrow(features))

## create the training set
x_train <- read_delim(paste0(train.dir, "/X_train.txt"),
                      col_names = FALSE, delim = " ",
                      col_types = c_type)
colnames(x_train) <- t(features)
training_set <- activity_labels %>%
        inner_join(y_train, by = "activity_code") %>%
        select(activity) %>%
        bind_cols(subject_train) %>%
        select(subject, activity) %>%
        bind_cols(x_train)


## Import the test files into R
y_test <- read_fwf(paste0(test.dir, "/y_test.txt"),
                    fwf_widths(1, "activity_code"), col_types = "c")
subject_test <- read_fwf(paste0(test.dir, "/subject_test.txt"),
                          fwf_widths(1, "subject"), col_types = "c")
x_test <- read_delim(paste0(test.dir, "/X_test.txt"),
                      col_names = FALSE, delim = " ",
                      col_types = c_type)
colnames(x_test) <- t(features)

## Create the test set
test_set <- activity_labels %>%
        inner_join(y_test, by = "activity_code") %>%
        select(activity) %>%
        bind_cols(subject_test) %>%
        select(subject, activity) %>%
        bind_cols(x_test)


## Combine the training set and test set into the common data set
train_plus_test <- bind_rows("training" = training_set,
                             "test" = test_set, .id = "group") %>%
        select(group, subject, activity, as.character(features_mean_std))






