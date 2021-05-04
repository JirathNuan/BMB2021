calc_fprtm <- function(dataset){
  # ------------- Calculate FPRtm --------------------------
  library(caret) # include library
  
  dt <- read.table(dataset, header = TRUE, sep="\t")  # load table
  
  # extract file name, for naming output and rowname
  f_name <- paste0(tools::file_path_sans_ext(dataset))
  # print(paste("Input file name: ", dataset))
  
  # define variable for confusion matrix
  lvs = c("secreted","mitochondrion-matrix","cell-envelope")
  actual = factor(dt$true, levels = lvs)
  pred = factor(dt$y_pred, levels = lvs)
  
  # calculate confusion matrix
  eval_indices <- confusionMatrix(pred, actual, mode = "sens_spec")
  # print(paste("Total FP: ", eval_indices$table[1,3]))
  
  # count number of proteins from cell-envelope
  num_tm <- dplyr::count(dt,true)
  # print(paste("Total number of TM proteins: ", num_tm[1,2]))
  
  FPRtm <- eval_indices$table[1,3] / num_tm[1,2]
  return(print(FPRtm))
}








