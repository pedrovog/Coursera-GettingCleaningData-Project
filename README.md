# Course Project - Getting and Cleaning Data #
--------

## About this Repo ##

This repository contains my work for the final project of the course Getting and Cleaning Data from John Hopkins University on Coursera.

The purpose of the project is to collect, work with and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

A full description of the data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "The UCI Machine Learning Repository").

## Overview ##

The R script `run_analysis.R`, does the following:

1. Download the dataset, if it does not already exists in the Working Directory;
2. Load the `Activity` and `Feature` information;
3. Loads both the `training` and `test` datasets, keeping only those columns which reflect a mean or standard deviation;
4. Loads the `Activity` and `Subject` data for each dataset, and merges those columns with the dataset;
5. Merges the two datasets: `test` and `training`
6. Converts the activity and subject columns into factors
7. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.


The final result is show in the `tidy_ds.txt`  
